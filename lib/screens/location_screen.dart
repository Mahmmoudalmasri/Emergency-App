import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:emergency_app/screens/requests/complete_emergency_case.dart';

// ignore: must_be_immutable
class LocationScreen extends StatefulWidget {
  double lat;
  double lng;
  List centerLocations;
  LocationScreen({
    Key? key,
    required this.lat,
    required this.lng,
    required this.centerLocations,
  }) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late LatLng currentLatLng = LatLng(widget.lat, widget.lng);
  Location location = Location();
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> markers = [];

  double selectedLat = 0.0;
  double selectedLong = 0.0;
  double sourceLat = 0.0;
  double sourcelong = 0.0;
  List<dynamic> shortetSource = [];

  shortestLocation(double distLat, double distlong) {
    var p = 0.017453292519943295;
    int index = 0;
    var temp = 0.0;
    var min = 12742 *
        asin(sqrt(0.5 -
            cos((distLat - widget.centerLocations[0]['latitude']) * p) / 2 +
            cos(distLat * p) *
                cos(widget.centerLocations[0]['latitude'] * p) *
                (1 -
                    cos((widget.centerLocations[0]['longitude'] - distlong) *
                        p)) /
                2));

    for (int i = 0; i < widget.centerLocations.length; i++) {
      temp = 12742 *
          asin(sqrt(0.5 -
              cos((distLat - widget.centerLocations[i]['latitude']) * p) / 2 +
              cos(distLat * p) *
                  cos(widget.centerLocations[i]['latitude'] * p) *
                  (1 -
                      cos((widget.centerLocations[i]['longitude'] - distlong) *
                          p)) /
                  2));
      if (temp < min) {
        setState(() {
          min = temp;
          index = i;
        });
      }
    }
    shortetSource.add(widget.centerLocations[index]);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF044686),
          centerTitle: true,
          title: const Text("CASE LOCATION"),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: size.height * 0.7,
                child: GoogleMap(
                  mapType: MapType.normal,
                  onLongPress: (argument) {
                    setState(() {
                      selectedLat = argument.latitude;
                      selectedLong = argument.longitude;
                      markers = [
                        Marker(
                          markerId: const MarkerId("Selected Location"),
                          position:
                              LatLng(argument.latitude, argument.longitude),
                          draggable: true,
                          infoWindow: const InfoWindow(
                            title: 'Selected Location',
                          ),
                        ),
                      ];

                      shortestLocation(argument.latitude, argument.longitude);
                    });
                  },
                  markers: markers.toSet(),
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: currentLatLng,
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
              Container(
                height: size.height * 0.1485,
                width: size.width,
                padding: EdgeInsets.all(size.width * 0.03),
                decoration: const BoxDecoration(
                    color: Color(0xFF044686),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Please set the correct address to arrive in record time",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteCase(
                                  lat: selectedLat,
                                  long: selectedLong,
                                  sourceLocation: shortetSource,
                                )),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Color(0xFF044686)),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * 0.04,
                              horizontal: size.width * 0.3)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
