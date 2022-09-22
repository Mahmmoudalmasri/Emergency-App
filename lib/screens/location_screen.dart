import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:emergency_app/screens/complete_case1.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Completer<GoogleMapController> _controller = Completer();

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
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 14.4746,
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
                            builder: (context) => const CompleteCase()),
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
