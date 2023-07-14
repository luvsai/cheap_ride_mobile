from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
import math
import random

# Create your views here.
from django.http import HttpResponse, JsonResponse
from . import utils
import json

import numpy as np


# trips api

#  api to get 

from . import  dbhelper , models

usertrips = dbhelper.readTrip()  # readtrips

print("trips Initialized : ", usertrips)
usertripdic = {}

trip = models.Trip()
usertrips["t1"] = trip

trip_dict = {
        'tid': trip.tid,
        'source': trip.source,
        'destination': trip.destination,
        'sourceN': trip.sourceN,
        'destinationN': trip.destinationN,
        'path': trip.path,
        'starttime': str(trip.starttime),
        'ETATime': str(trip.ETATime),
        'DestinationTime': str(trip.DestinationTime),
        'Tripstatus': trip.Tripstatus,
        'Estimateddistance': trip.Estimateddistance,
        'ActualDistance': trip.ActualDistance,
        'TripCost': trip.TripCost,
        'BasePrice': trip.BasePrice,
        'BaseDistance': trip.BaseDistance,
        'CostperDistanceAfterBaseDistance': trip.CostperDistanceAfterBaseDistance,
        'tripVehicle': trip.tripVehicle,
        'PassengerId': trip.PassengerId,
        'DriverId': trip.DriverId
    }
usertripdic ["t1"] = trip_dict
dbhelper.savetrips(trips=usertripdic)

@csrf_exempt
def gettrips(request):
    if request.method == 'POST':
        # body_unicode = request.body.decode('utf-8')
        # body = json.loads(body_unicode)

        # print(usertrips["t1"])
        trip = usertrips["t1"]
        # Convert the Trip object to a dictionary
        trip_dict = {
        'tid': trip.tid,
        'source': trip.source,
        'destination': trip.destination,
        'sourceN': trip.sourceN,
        'destinationN': trip.destinationN,
        'path': trip.path,
        'starttime': trip.starttime,
        'ETATime': trip.ETATime,
        'DestinationTime': trip.DestinationTime,
        'Tripstatus': trip.Tripstatus,
        'Estimateddistance': trip.Estimateddistance,
        'ActualDistance': trip.ActualDistance,
        'TripCost': trip.TripCost,
        'BasePrice': trip.BasePrice,
        'BaseDistance': trip.BaseDistance,
        'CostperDistanceAfterBaseDistance': trip.CostperDistanceAfterBaseDistance,
        'tripVehicle': trip.tripVehicle,
        'PassengerId': trip.PassengerId,
        'DriverId': trip.DriverId
    }
        return JsonResponse(trip_dict)
    return HttpResponse("Accesed trips")



