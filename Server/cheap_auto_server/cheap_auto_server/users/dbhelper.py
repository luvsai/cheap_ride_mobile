import pymongo

# import ObjectID from MongoDB's BSON library
from bson import ObjectId

my_client = pymongo.MongoClient("mongodb://localhost:27017/")

# First define the database name
dbname = my_client['cheap-auto']


def createUser(user):
    collection_name = dbname["users"]
    # Insert the document
    collection_name.insert_many([user])


def checkUser(ph):
    # Read the documents
    collection_name = dbname["users"]
    user_details = collection_name.find({})
    # Print on the terminal
    for r in user_details:
        if r["phone"] == ph:
            return True
    return False


# -- Saving state of the system INmemeory db

    # -- init
def readlu():
    collection_name = dbname["logging_users"]
    cd = collection_name.find({})
    collectiondata = []
    for r in cd:
        collectiondata.append(r)
    if len(collectiondata) == 0:
        print("Initialiazed logging users db")
        query = {"_id": ObjectId("63b6fb0f95c9095e4d69668d")}
        collection_name.insert_one(query)
        return {}
    collectiondata = collectiondata[0]
    collectiondata.pop("_id")
    return collectiondata


def readau():
    collection_name = dbname["active_users"]
    cd = collection_name.find({})
    collectiondata = []
    for r in cd:
        collectiondata.append(r)
    if len(collectiondata) == 0:
        query = {"_id": ObjectId("63b6fb0f95c9095e4d69668a")}
        collection_name.insert_one(query)
        return {}
    collectiondata = collectiondata[0]
    collectiondata.pop("_id")
    return collectiondata


def readrac():
    """
    to read account requested users
    """
    collection_name = dbname["requested_account_creation"]
    cd = collection_name.find({})
    collectiondata = []
    for r in cd:
        collectiondata.append(r)
    if len(collectiondata) == 0:
        query = {"_id": ObjectId("63b6fb0f95c9095e4d69668b")}
        collection_name.insert_one(query)
        return {}
    collectiondata = collectiondata[0]
    collectiondata.pop("_id")
    return collectiondata


def savelogging_users(logging_users):
    query = {"_id": ObjectId("63b6fb0f95c9095e4d69668d")}
    collection_name = dbname["logging_users"]
    result = collection_name.replace_one(query, logging_users)


def saveactive_users(active_users):
    query = {"_id": ObjectId("63b6fb0f95c9095e4d69668a")}
    collection_name = dbname["active_users"]
    result = collection_name.replace_one(query, active_users)


def saverequested_account_creation(requested_account_creation):
    query = {"_id": ObjectId("63b6fb0f95c9095e4d69668b")}
    collection_name = dbname["requested_account_creation"]
    result = collection_name.replace_one(query, requested_account_creation)
