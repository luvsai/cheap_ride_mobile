from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
import math
import random

# Create your views here.
from django.http import HttpResponse, JsonResponse
from . import utils
import json

import numpy as np



grid = utils.bgrid["grid"]
grid = np.array(grid)
def nearest_coordinates(grid, A):
    # Compute the Euclidean distance between each coordinate in the grid and A
    distances = np.linalg.norm(grid - A, axis=-1)
    # Get the indices of the 4 smallest distances (i.e. the 4 nearest coordinates)
    nearest_indices = np.argpartition(distances.flatten(), 4)[:4]
    # Get the corresponding coordinates from the grid
    print(nearest_indices)
    nearest_coordinates = grid[np.unravel_index(nearest_indices, distances.shape)]
    return nearest_coordinates

#cde to find the top 4 nearest drivers
 

def nearest_drivers(M, A):
    distances = np.sqrt((M[:,0]-A[0])**2 + (M[:,1]-A[1])**2)
    nearest_indices = np.argpartition(distances, 4)[:4]
    return nearest_indices

def nearest_indicestocoordinates(nearest_indices, A):
    # Compute the Euclidean distance between each coordinate in the grid and A
    distances = np.linalg.norm(grid - A, axis=-1)

    # Get the corresponding coordinates from the grid
    nearest_coordinates = grid[np.unravel_index(nearest_indices, distances.shape)]
    return nearest_coordinates
def get_bin_tag(grid, A):
    # Compute the Euclidean distance between each coordinate in the grid and A
    distances = np.linalg.norm(grid - A, axis=-1)
    # Get the indices of the 4 smallest distances (i.e. the 4 nearest coordinates)
    nearest_indices = np.argpartition(distances.flatten(), 4)[:4]
    # Get the corresponding coordinates from the grid
    # 
    return sorted(list(nearest_indices))

#usecase
    # M = np.array([[45.5, -122.3], [47.2, -121.5], [46.1, -123.2], [47.5, -124.8], [46.7, -121.9], [48.2, -122.5]])
    # A = [46.6, -122.5]
    # print(nearest_drivers(M, A))

#---------------------
drivers = []
drivers.append(utils.driver("1", "sai" , (12.932200, 77.698290)))
drivers.append(utils.driver("2", "ryan" , (12.932200, 77.598290)))
drivers.append(utils.driver("3", "pam",(12.632200, 77.698290)))


drivers.append(utils.driver("4", "asdf",(12.992943778808101,77.70601484924555)))



bins = {}

print("bin tags---")
for driver in drivers:
    bintag = ".".join(  [ str(x) for x in  get_bin_tag(grid, driver.cor) ])
    print(bintag)
    if bins.get(bintag) == None:
        bins[bintag] = [driver]
    else:
        bins[bintag].append(driver)

print("bin tags end---")


def index(request):
    return HttpResponse(""" <H1> Features </H1> api is working.<br> <pre _ngcontent-jsv-c99="" class="form-control-static">_______________                                _______         _____        
__  ____/___  /_ _____ ______ _________        ___    |____  ____  /_______ 
_  /     __  __ \_  _ \_  __ `/___  __ \       __  /| |_  / / /_  __/_  __ \\
/ /___   _  / / //  __// /_/ / __  /_/ /       _  ___ |/ /_/ / / /_  / /_/ /
\____/   /_/ /_/ \___/ \__,_/  _  .___/        /_/  |_|\__,_/  \__/  \____/ 
                               /_/                                          
 """)

A = (12.932282, 77.698296)

@csrf_exempt
def getDriversNearUSer(request) :
    if request.method == 'POST':
        body_unicode = request.body.decode('utf-8')
        body = json.loads(body_unicode)
        usertoken = body["usertoken"]

        print("sending driver details")
        
        #if user token is valid than allow user 
        try:
            lat = float( body["lat"])
            long = float( body["long"] )
            bintag = ".".join(  [ str(x) for x in  get_bin_tag(grid, (lat,long)) ])
            print(bintag)
            if bins.get(bintag) == None:
                return JsonResponse({})
            else:
                drivers = bins[bintag] 
                res = {}
                for driver in drivers:
                    res[driver.id] =  { "id" : driver.id , "lat" : driver.cor[0] , "long" : driver.cor[1] , "vehicle" :  driver.vehicle}

                return JsonResponse(res)
        except:
            return  JsonResponse({})

        #else return

    
    return HttpResponse("OK ")

