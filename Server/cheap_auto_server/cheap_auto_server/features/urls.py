from django.urls import path

from . import views ,trips

urlpatterns = [
    path('', views.index, name='index'),
    path('getDriversNearUSer/', views.getDriversNearUSer, name='getDriversNearUSe'),
    path('gettrips/', trips.gettrips, name='gettrips'),
    
]
