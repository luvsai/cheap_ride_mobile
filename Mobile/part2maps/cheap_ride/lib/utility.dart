import 'package:location/location.dart'
as location_package;

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Views/HomeScreens.dart';

class SyswideSharedProps{
  // variables to get the screen size
  // static var screenSize = MediaQuery.of(context).size;
  static var  lmg = LocationManager();
  static var screenHeight = 0.0;
  static var screenWidth = 0.0;
  static const deloc = LatLng(12.942200, 77.698200) ;
  static const gapitoken =  "AIzaSyCPfHHjL9-hpzEtZe3bFPcuSmCFD5feun0" ;

  static var baseURL = "http://127.0.0.1:8000/" ;
}
