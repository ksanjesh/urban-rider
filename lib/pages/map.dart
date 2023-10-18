import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:urban_rider/pages/second_camera_page.dart';
const LatLng currentLocation = LatLng(12.8986,77.5709);
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}
Map<MarkerId, Marker> markers = {};
PolylinePoints polylinePoints = PolylinePoints();
Map<PolylineId, Polyline> polylines = {};

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
 // late GoogleMapController mapController;

  @override
  void initState() {
    _addMarker(
      const LatLng(12.9148, 77.5883),
      "origin",
      BitmapDescriptor.defaultMarker,
    );

    _addMarker(
      const LatLng(12.9121, 77.6446),
      "destination",
      BitmapDescriptor.defaultMarkerWithHue(90),
    );
    _getPolyline();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 12,
              ),
              myLocationEnabled: true,
              tiltGesturesEnabled: true,
              compassEnabled: true,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
                markers: Set<Marker>.of(markers.values),
             onMapCreated: (GoogleMapController controller) {
             _controller.complete(controller);}


            ),
            Positioned(
              bottom: 00,
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 3),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 20, right: 20),
                  child: Column(
                    children: [
                      Text("Ride In Progress", style: TextStyle(fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text("Time", style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),),
                              SizedBox(height: 5,),
                              Text("HH:MM:SS", style: TextStyle(fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),),
                              SizedBox(height: 20,),
                              Text("00:23:45", style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),)
                            ],
                          ),
                          Column(
                            children: [
                              Text("Distance", style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),),
                              SizedBox(height: 5,),
                              Text("KMS", style: TextStyle(fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),),
                              SizedBox(height: 20,),
                              Text("25:000", style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),)
                            ],
                          ),
                          Column(
                            children: [
                              Text("Avg Speed", style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 20),),
                              SizedBox(height: 5,),
                              Text("kmph", style: TextStyle(fontSize: 15,
                                  color: Colors.black.withOpacity(0.5)),),
                              SizedBox(height: 20,),
                              Text("00:23:45", style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),)
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SlideAction(
                          borderRadius: 12,
                          innerColor: Colors.black,
                          outerColor: Colors.blue.withOpacity(0.8),
                          sliderButtonIcon: Icon(Icons.arrow_forward_outlined,
                            color: Colors.white,),
                          text: "Slide to finish",
                          textStyle: TextStyle(color: Colors.white,
                              fontSize: 25),
                          onSubmit: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SecondCameraPage()));
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }


  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }
  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }


  Future<void> _getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyAFfkk5FtmXgIsbHQzmEXsyFOACA4Jj_oY",
      PointLatLng(12.9148, 77.5883),
      PointLatLng(12.9121, 77.6446),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
