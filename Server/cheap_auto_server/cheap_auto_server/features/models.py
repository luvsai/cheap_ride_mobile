from django.db import models

# Create your models here.

from datetime import time


class Trip:
    def __init__(self):
        # Unique identifier for the trip
        self.tid = 0
        # Source coordinates of the trip
        self.source = (0.0, 0.0)
        # Source coordinates Name of the trip
        self.sourceN = "Start"
        # Destination coordinates of the trip
        self.destination = (0.0, 0.0)
        # Destination coordinates Name of the trip
        self.destinationN = "Destination"
        # List of coordinates representing the path of the trip
        self.path = []
        # Start time of the trip
        self.starttime = time()
        # Expected time of arrival at the destination
        self.ETATime = time()
        # Actual time of arrival at the destination
        self.DestinationTime = time()
        # Status of the trip (e.g., ongoing or completed)
        self.Tripstatus = False
        # Estimated distance of the trip
        self.Estimateddistance = 0.0
        # Actual distance traveled in the trip
        self.ActualDistance = 0.0
        # Cost of the trip
        self.TripCost = 0.0
        # Base price for the trip
        self.BasePrice = 0.0
        # Base distance for the trip
        self.BaseDistance = 0.0
        # Cost per distance after the base distance is exceeded
        self.CostperDistanceAfterBaseDistance = 0.0
        # Vehicle associated with the trip
        self.tripVehicle = 0
        # ID of the passenger associated with the trip
        self.PassengerId = 0
        # ID of the driver assigned to the trip
        self.DriverId = 0

    # Getter functions
    def get_tid(self):
        return self.tid

    def get_source(self):
        return self.source

    def get_destination(self):
        return self.destination

    def get_path(self):
        return self.path

    def get_starttime(self):
        return self.starttime

    def get_ETATime(self):
        return self.ETATime

    def get_DestinationTime(self):
        return self.DestinationTime

    def get_Tripstatus(self):
        return self.Tripstatus

    def get_Estimateddistance(self):
        return self.Estimateddistance

    def get_ActualDistance(self):
        return self.ActualDistance

    def get_TripCost(self):
        return self.TripCost

    def get_BasePrice(self):
        return self.BasePrice

    def get_BaseDistance(self):
        return self.BaseDistance

    def get_CostperDistanceAfterBaseDistance(self):
        return self.CostperDistanceAfterBaseDistance

    def get_tripVehicle(self):
        return self.tripVehicle

    def get_PassengerId(self):
        return self.PassengerId

    def get_DriverId(self):
        return self.DriverId

    # Setter functions
    def set_tid(self, tid):
        self.tid = tid

    def set_source(self, source):
        self.source = source

    def set_destination(self, destination):
        self.destination = destination

    def set_path(self, path):
        self.path = path

    def set_starttime(self, starttime):
        self.starttime = starttime

    def set_ETATime(self, eta_time):
        self.ETATime = eta_time

    def set_DestinationTime(self, dest_time):
        self.DestinationTime = dest_time

    def set_Tripstatus(self, status):
        self.Tripstatus = status

    def set_Estimateddistance(self, est_distance):
        self.Estimateddistance = est_distance

    def set_ActualDistance(self, act_distance):
        self.ActualDistance = act_distance

    def set_TripCost(self, trip_cost):
        self.TripCost = trip_cost

    def set_BasePrice(self, base_price):
        self.BasePrice = base_price

    def set_BaseDistance(self, base_distance):
        self.BaseDistance = base_distance

    def set_CostperDistanceAfterBaseDistance(self, cost_per_distance):
        self.CostperDistanceAfterBaseDistance = cost_per_distance

    def set_tripVehicle(self, trip_vehicle):
        self.tripVehicle = trip_vehicle

    def set_PassengerId(self, passenger_id):
        self.PassengerId = passenger_id

    def set_DriverId(self, driver_id):
        self.DriverId = driver_id
