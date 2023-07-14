import 'package:cheap_ride/utility.dart' ;
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:cheap_ride/NetworkCalls.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart'
as location_package;
import 'package:google_directions_api/google_directions_api.dart';


enum AppPermissions {
  granted,
  denied,
  restricted,
  permanentlyDenied,
}
 class LocationManager {
  // Start with default permission status i.e denied
  PermissionStatus _locationStatus = PermissionStatus.denied;



  // Create a LatLng type that'll be user location
  LatLng? _locationCenter;
  // Initiate location from location package
  final location_package.Location _location = location_package.Location();
  location_package.LocationData? _locationData;

  LatLng? userlocation;

  // Getter
  get location => _location;
  get locationStatus => _locationStatus;
  get locationCenter => _locationCenter as LatLng;



  Future<PermissionStatus>  getLocationStatus() async {
    // Request for permission
    final status = await Permission.location.request();
    // change the location status
    _locationStatus = status;
    print("ask prerm") ;

    print(_locationStatus);
    return status;
  }

  Future<void> getLocation() async {



    //
    //


    // Call Location status function here
    final status = await getLocationStatus();
    print("I am inside get location");
    // if permission is granted or limited call function
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      try {
        // assign location data that's returned by Location package
        _locationData = await _location.getLocation();
        // Check for null values
        final lat = _locationData != null
            ? _locationData!.latitude as double
            : 0.0;
        final lon = _locationData != null
            ? _locationData!.longitude as double
            : 0.0;

        this.userlocation = LatLng(lat,lon) ;


        // get the response from callable function
        _locationCenter = LatLng(lat,lon);
        print(lat.toString() + " : latutituis");
        return ;
      } catch (e) {
        // incase of error location witll be null
        _locationCenter = null;
        rethrow;
      }
    }

  }
}

class MymApp extends StatefulWidget {

  var cloc  ;
   MymApp(LatLng latLng, {Key? key , this.cloc  =  SyswideSharedProps.deloc  }) : super(key: key );

  @override
  State<MymApp> createState() => _MymAppState();
}

class _MymAppState extends State<MymApp> {
  late GoogleMapController mapController;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late Polyline route ;
// For storing the current position
//   Position _currentPosition;


  late LatLng cloc  = widget.cloc ;


  //call ios code

  static const platform = MethodChannel('samples.flutter.dev/location');
  String _uloc = '0:0';


  Future<void> _getlocperms() async {
    String uloc;
    try {
      final String result = await platform.invokeMethod('getlocation');
      uloc = result ;
      print(uloc);
      var cord = uloc.split(':');
      setState(() {
        cloc = LatLng(double.parse(cord[0]), double.parse(cord[1])  );
      });
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: cloc,
            zoom: 15.0,
          ),
        ),
      );


    } on PlatformException catch (e) {
      uloc = "Failed to get loc perm: '${e.message}'.";
    }

    setState(() {
      _uloc = uloc;

    });
  }


  LatLng _lastMapPosition = LatLng(12.932200, 77.698290);

  final LatLng _center = const LatLng(12.932200, 77.698290);
  @override
  void initState() {
    addCustomIcon();


      DirectionsService.init('AIzaSyCPfHHjL9-hpzEtZe3bFPcuSmCFD5feun0');

      final directionsService = DirectionsService();

      final request = DirectionsRequest(
        origin: 'New York',
        destination: 'San Francisco',
        travelMode: TravelMode.driving,
      );

      // directionsService.route(request,
      //         (DirectionsResult response, DirectionsStatus status) {
      //       if (status == DirectionsStatus.ok) {
      //         // do something with successful response
      //
      //
      //       } else {
      //         // do something with error response
      //       }
      //     });

    super.initState();
  }
  void addCustomIcon() {


    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), "assets/images/ricks.png")
        .then(
          (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  //

  //
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
//     mapController.animateCamera(
//       CameraUpdate.zoomIn(),
//     );
//
// // Zoom Out action
//     mapController.animateCamera(
//       CameraUpdate.zoomOut(),
//     );
  }
  //
  // _getCurrentLocation() async {
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) async {
  //     setState(() {
  //       // Store the position in the variable
  //       _currentPosition = position;
  //
  //       print('CURRENT POS: $_currentPosition');
  //
  //       // For moving the camera to current location
  //       mapController.animateCamera(
  //         CameraUpdate.newCameraPosition(
  //           CameraPosition(
  //             target: LatLng(position.latitude, position.longitude),
  //             zoom: 18.0,
  //           ),
  //         ),
  //       );
  //     });
  //     await _getAddress();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }
  void _onCameraMove(CameraPosition position) {
    print(position);
    setState(() {
      _lastMapPosition = position.target;
    });

    addnearbydrivermarkers( _lastMapPosition) ;



  }

  void addnearbydrivermarkers(LatLng _lastMapPosition) {
    print(" addnearbydriver") ;
    //get the drivers nearby and plot
    HttpService.getDrivers(_lastMapPosition.latitude.toString(), _lastMapPosition.longitude.toString()).then((value) {

      print(value);

      for (var driver in value ) {
        Marker startMarker = Marker(
          markerId: MarkerId(driver.id),
          position: LatLng(driver.lat, driver.long),
          infoWindow: InfoWindow(
            title: 'Start $driver.id',

          ),
          //icon: BitmapDescriptor.defaultMarker,
          icon: markerIcon
        );

        setState(() {

          markers.add(startMarker) ;
        });
      }

    });
  }


  Set<Marker> markers = {
    // Marker(
    //   markerId: const MarkerId("marker1"),
    //   position:  _lastMapPosition ,
    //   draggable: false,
    //
    //   onDragEnd: (value) {
    //     print(value);
    //     // value is the new position
    //   },
    //
    //
    //   icon: markerIcon,
    //   // To do: custom marker icon
    // ),

    Marker(
      markerId: const MarkerId("marker2"),
      position: const LatLng(12.942200, 77.698200),

    ),
  };

  @override
  Widget build(BuildContext context) {
    return


            Stack(

              alignment: Alignment.center,

              children: [


                GoogleMap(
                  onMapCreated: _onMapCreated,
                  compassEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  onCameraMove: _onCameraMove,
                  markers: markers,
                  initialCameraPosition: CameraPosition(

                    target: _center,
                    zoom: 16.0,
                  ),
                  polylines: {},
                ),

                //center marker //TODO
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 8,),
                            Icon(
                              CupertinoIcons.map_pin_ellipse,
                              color: Colors.black,
                              size: 38.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),

                          ],
                        ),

                        Icon(
                          CupertinoIcons.map_pin,
                          color: Colors.green,
                          size: 32.0,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),

                      ],
                    ),

                    SizedBox( width: 38, height: 31,)
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          child:
                          Stack(
                            alignment: Alignment.center,
                            children: [

                              Icon(
                                CupertinoIcons.square_fill,
                                color: Colors.grey,
                                size: 60.0,
                                semanticLabel: 'Locate location',
                              ),
                              Icon(
                                CupertinoIcons.location_fill,
                                color: Colors.black,
                                size: 36.0,
                                semanticLabel: 'Locate location',
                              ),
                              Icon(
                                CupertinoIcons.location_fill,
                                color: Colors.blueAccent,
                                size: 33.0,
                                semanticLabel: 'Locate location',
                              ),

                            ],
                          ),
                          onTap: () => _getlocperms()
                          ,
                        ),
                        SizedBox(width: 10,)


                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                )



              ],

            )



      ;
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    _getlocperms() ;
    super.initState();
  }
  LatLng cloc = LatLng(12.932018982989353, 77.69831892102957) ;

  //call ios code

  static const platform = MethodChannel('samples.flutter.dev/location');
  String _uloc = '0:0';


  Future<void> _getlocperms() async {
    String uloc;
    try {
      final String result = await platform.invokeMethod('getlocation');
      uloc = result ;
      print(uloc);
      var cord = uloc.split(':');
      setState(() {
        cloc = LatLng(double.parse(cord[0]), double.parse(cord[1])  );
      });
      
      
    } on PlatformException catch (e) {
      uloc = "Failed to get loc perm: '${e.message}'.";
    }

    setState(() {
      _uloc = uloc;

    });
  }
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child:
              Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _getlocperms();
                        SyswideSharedProps.lmg .getLocation().then((res) {
                            print(SyswideSharedProps.lmg.location) ;
                          });

                      },
                      child: Text("GetLoc"),
                    )
                     ,
                    SizedBox(
                      width: SyswideSharedProps.screenWidth,
                      height: SyswideSharedProps.screenHeight * 0.8,
                      child: MymApp(cloc = cloc),


                    ),


                  ],
                    )
                  )
      ) ;
  }
}



  // location.onLocationChanged.listen((LocationData loc) {
  // print("${loc.latitude} ${loc.longitude}");
  // });