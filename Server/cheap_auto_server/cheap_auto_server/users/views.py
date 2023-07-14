from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
import math
import random
from firebase_admin.auth import  create_user
from twilio.rest import Client

account_sid = 'AC6277ba0a151fec7eb3693dec8276b91d'
auth_token = 'c70835edbd4fff5a6cd0673097924b70'
client = Client(account_sid, auth_token)


# Create your views here.
from django.http import HttpResponse, JsonResponse
from . import utilities, dbhelper
import json

# path to firebase key
fbpath = "/Users/luvsai/Desktop/FBprivatekey/cheapride-38303-firebase-adminsdk-i72s3-2ab22e4966.json"
import firebase_admin
from firebase_admin import credentials

cred = credentials.Certificate(fbpath)
firebase_admin.initialize_app(cred)

def index(request):
    return HttpResponse("""Cheap auto users api is working.<br> <pre _ngcontent-jsv-c99="" class="form-control-static">_______________                                _______         _____        
__  ____/___  /_ _____ ______ _________        ___    |____  ____  /_______ 
_  /     __  __ \_  _ \_  __ `/___  __ \       __  /| |_  / / /_  __/_  __ \\
/ /___   _  / / //  __// /_/ / __  /_/ /       _  ___ |/ /_/ / / /_  / /_/ /
\____/   /_/ /_/ \___/ \__,_/  _  .___/        /_/  |_|\__,_/  \__/  \____/ 
                               /_/                                          
 """)


# Data Structures #INMEMORY DB need to be insync with the MONGODB in order to be fault tolerant. TODO write threading to sync frequently
# -- initializing inmemory db's


logging_users = dbhelper.readlu()  # to save otp for logging


active_users = dbhelper.readau()  # Currently active users


# requested Account creation for a user
requested_account_creation = dbhelper.readrac()

print("check : In memory DB's initialized \nLogging users : ", logging_users,
      "\nActive users : ", active_users, "\nRAcC : ", requested_account_creation, "\n")

# ----


@csrf_exempt
def login(request):
    if request.method == 'POST':
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        phone = body["phone"]
        otp = body["otp"]
        if otp == "":
            resend = body["resend"]
            if resend == "True":  # asking for resend otp
                # send otp to the mobile using messaging system
                # TODO
                otp = logging_users[phone]
                dic = {"status": "200 OK", "code": "2", "des": "OTP is resent"}
                print(logging_users)  # TODO remove
                return JsonResponse(dic)
            otp = utilities.generateOTP()
            logging_users[phone] = otp
            dbhelper.savelogging_users(logging_users)  # save to db

            # send otp to the mobile using messaging system
            # TODO
            try:
                # Create the user with the specified phone number and OTP
                # message = client.messages.create(
                #     body='Your OTP: '+ otp + " for logging into CheapRide",  # Replace with the desired message content
                #     from_='+918179233514',  # Replace with your Twilio phone number
                #     to="+91"+ phone # Replace with the recipient's phone number
                # )

                # print(f"SMS sent successfully with SID: {message.sid}")

                print(f"OTP sent successfully to {phone}")
            except Exception as e:
                print(f"Error sending OTP: {e}")

            print(logging_users)  # TODO remove
            dic = {"status": "200 OK", "code": "1",
                   "des": "Fresh OTP is generated", "usertoken": ""}
            return JsonResponse(dic)
        # verify otp
        if logging_users.get(phone) != None:
            if logging_users[phone] == otp:
                # phone number verification is done

                # check the user is also exists if not ask the user to create the account

                # if user already exits return the secret user login token
                if dbhelper.checkUser(ph=phone):
                    userToken = utilities.generateToken()
                    active_users[userToken] = phone
                    dbhelper.saveactive_users(active_users)  # save to db
                    dic = {"status": "200 OK", "code": "2",
                           "des": "OTP is matched: user login is successfull", "usertoken": userToken}
                    return JsonResponse(dic)
                # else return code 3 to request create_user api endpoint to create new user
                else:

                    requested_account_creation[phone] = "True"
                    dbhelper.saverequested_account_creation(
                        requested_account_creation)
                    dic = {"status": "200 OK", "code": "3",
                           "des": "OTP is matched, create new account", "usertoken": ""}

                    logging_users.pop(phone)
                    dbhelper.savelogging_users(logging_users)
                    return JsonResponse(dic)
            else:
                dic = {"status": "200 OK", "code": "4",
                       "des": "OTP doesn't match", "usertoken": ""}
                return JsonResponse(dic)

        else:
            # ask the user
            dic = {"status": "200 OK", "code": "5",
                   "des": "OTP not valid", "usertoken": ""}

            return JsonResponse(dic)

    if request.method == 'PUT':  # create new user account
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        phone = body["phone"]

        # check for access to create user
        if phone in list(requested_account_creation.keys()):

            dbhelper.createUser(body)
            userToken = utilities.generateToken()
            active_users[userToken] = phone
            dbhelper.saveactive_users(active_users)

            dic = {"status": "200 OK", "code": "2",
                   "des": "OTP is matched: user login is successfull", "usertoken": userToken}

            requested_account_creation.pop(phone)
            dbhelper.saverequested_account_creation(
                requested_account_creation)
            return JsonResponse(dic)
        else:
            dic = {"request": "400 Error", "des": "No access"}
            return JsonResponse(dic)
    if request.method == 'DELETE':
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        actoken = body["accesstoken"]
        active_users.pop(actoken)
        dbhelper.saveactive_users(active_users)
        dic = {"status": "200 OK", "code": "9",
                   "des": "logout is successfull" }
        return JsonResponse(dic)
    else:  # get request
        dic = {"request": "400 Error", "des": "No access"}
        return JsonResponse(dic)
