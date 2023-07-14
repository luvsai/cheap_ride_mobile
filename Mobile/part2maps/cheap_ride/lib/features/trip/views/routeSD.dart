import 'package:cheap_ride/utility.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io' show Platform;


import 'package:flutter/services.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:draggable_widget/draggable_widget.dart';


class DraggableFloatingWidget extends StatefulWidget {
@override
_DraggableFloatingWidgetState createState() => _DraggableFloatingWidgetState();
}

class _DraggableFloatingWidgetState extends State<DraggableFloatingWidget> {
  Offset position = Offset(100, 100); // Set the initial position as desired

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,

      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        child: GestureDetector(
          child:  FloatingActionButton(
            onPressed: () {
        // Add your onPressed code here!
      },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation),
      ),
          onTap: () => {
            print(" clicked floating button")
          },
        ),
    ),
    );
  }
}

//screen to draw polyline between two points
class MapScreen extends StatefulWidget {
  final LatLng source;
  final LatLng destination;

  MapScreen({required this.source, required this.destination});

  @override
  _MapScreenState createState() => _MapScreenState();
}

// class _MapScreenState extends State<MapScreen> {
//   late GoogleMapController mapController;
//   Set<Polyline> polylines = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _getPolyline();
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }
//
//   void _getPolyline() async {
//     String apiKey = SyswideSharedProps.gapitoken; // Replace with your own Google Maps API Key
//
//     String url = 'https://maps.googleapis.com/maps/api/directions/json?' +
//         'origin=${widget.source.latitude},${widget.source.longitude}&' +
//         'destination=${widget.destination.latitude},${widget.destination.longitude}&' +
//         'key=$apiKey';
//
//     var response = await  get(Uri.parse(url));
//
//
//     print( "rest" + response.body.toString());
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//
//       List<LatLng> polylineCoordinates = [];
//
//       if (data['status'] == 'OK') {
//         List<dynamic> routes = data['routes'];
//         if (routes.isNotEmpty) {
//           dynamic route = routes[0];
//           dynamic overviewPolyline = route['overview_polyline'];
//           String points = overviewPolyline['points'];
//
//           polylineCoordinates = _decodePolyline(points);
//         }
//       }
//
//       setState(() {
//         Polyline polyline = Polyline(
//           polylineId: PolylineId('polyline'),
//           color: Colors.blue,
//           points: polylineCoordinates,
//           width: 5,
//         );
//
//         polylines.add(polyline);
//       });
//     }
//   }
//
//   List<LatLng> _decodePolyline(String encodedPolyline) {
//     List<LatLng> polylineCoordinates = [];
//
//     int index = 0;
//     int len = encodedPolyline.length;
//     int lat = 0, lng = 0;
//
//     while (index < len) {
//       int shift = 0, result = 0;
//       int byte = encodedPolyline.codeUnitAt(index++) - 63;
//       do {
//         byte = encodedPolyline.codeUnitAt(index++) - 63;
//         result |= (byte & 0x1F) << shift;
//         shift += 5;
//       } while (byte >= 0x20);
//
//       int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lat += dlat;
//
//       shift = 0;
//       result = 0;
//
//       byte = encodedPolyline.codeUnitAt(index++) - 63;
//       do {
//         byte = encodedPolyline.codeUnitAt(index++) - 63;
//         result |= (byte & 0x1F) << shift;
//         shift += 5;
//       } while (byte >= 0x20);
//
//       int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
//       lng += dlng;
//
//       double latitude = lat / 1e5;
//       double longitude = lng / 1e5;
//
//       polylineCoordinates.add(LatLng(latitude, longitude));
//     }
//
//     return polylineCoordinates;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shortest Path'),
//       ),
//       body: GoogleMap(
//         onMapCreated: _onMapCreated,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//             (widget.source.latitude + widget.destination.latitude) / 2,
//             (widget.source.longitude + widget.destination.longitude) / 2,
//           ),
//           zoom: 15,
//         ),
//         polylines: polylines,
//       ),
//     );
//   }
// }


class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  Set<Polyline> polylines = {};
  static const platform = MethodChannel('samples.flutter.dev/maps');

  @override
  void initState() {
    super.initState();
    _getPolyline();
  }
  void showFloatingWidget(BuildContext context) {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');

    OverlayEntry floatingWidget = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // Handle the click on the floating widget
                // Launch the app or navigate to a specific screen
                // when the widget is clicked

              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          Positioned(
            left: 100,
            top: 100,
            child: DraggableFloatingWidget(),
          ),
        ],
      ),
    );

    Overlay.of(context)?.insert(floatingWidget);
  }









  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  void _getPolyline() async {

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      SyswideSharedProps.gapitoken, // Replace with your own Google Maps API Key
      PointLatLng(widget.source.latitude, widget.source.longitude),
      PointLatLng(widget.destination.latitude, widget.destination.longitude),
    );
    print('ji' +  result.errorMessage.toString()) ;
    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = [];
      print('ki') ;
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        print('li') ;
        Polyline polyline = Polyline(
          polylineId: PolylineId('polyline'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 5,
        );


        polylines.add(polyline);
      });
    }
  }
  //launch gmaps with directions bw 2 locations

  void launchGoogleMapsDirections(double originLat, double originLng, double destinationLat, double destinationLng) async {
    if (Platform.isAndroid) {
// Android-specific code
      String url = 'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng';
      try {
        final int result = await platform.invokeMethod('openmaps',<String, String>{
          'url': url
        });

      } on PlatformException catch (e) {

      }
    } else if (Platform.isIOS) {
// iOS-specific code
      String url = 'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng';
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        print('Could not launch $url');
      }
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shortest Path'),
      ),
      body:
      Column(
        children: [
          SizedBox(height: 15,),

          // google maps path from source to destination

          SizedBox(height: SyswideSharedProps.screenHeight * 0.75,
          child:GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                (widget.source.latitude + widget.destination.latitude) / 2,
                (widget.source.longitude + widget.destination.longitude) / 2,
              ),
              zoom: 15,
            ),
            polylines: polylines,
          ) ,
          ),
          TextButton(
            onPressed: () {
              // showFloatingWidget(context);

              //launch google maps in app

              double originLat = widget.source.latitude;  // Replace with your origin latitude
              double originLng = widget.source.longitude;  // Replace with your origin longitude
              double destinationLat = widget.destination.latitude;  // Replace with your destination latitude
              double destinationLng = widget.destination.longitude;  // Replace with your destination longitude
              launchGoogleMapsDirections(originLat, originLng, destinationLat, destinationLng);
            },
            child: Text('Open Google Maps'),

          ),

        ],
      )

    );
  }
}
