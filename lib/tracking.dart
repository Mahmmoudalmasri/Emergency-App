import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:emergency_app/constants.dart';

// ignore: must_be_immutable
class TrackingScreen extends StatefulWidget {
  double sourceLat;
  double sourceLong;
  double distinationLat;
  double distinationLong;
  TrackingScreen({
    Key? key,
    required this.sourceLat,
    required this.sourceLong,
    required this.distinationLat,
    required this.distinationLong,
  }) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyC5Y9BPYzBlfYhnc5lTjY0rJI4Ojm_LE3c",
      PointLatLng(widget.sourceLat, widget.sourceLong),
      PointLatLng(widget.distinationLat, widget.distinationLong),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Tracking',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.sourceLat, widget.sourceLong),
          zoom: 13.5,
        ),
        markers: {
          Marker(
            markerId: const MarkerId("source"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.sourceLat, widget.sourceLong),
          ),
          Marker(
            markerId: const MarkerId("destination"),
            icon: BitmapDescriptor.defaultMarker,
            position: LatLng(widget.distinationLat, widget.distinationLong),
          ),
        },
        polylines: {
          Polyline(
            polylineId: const PolylineId("route"),
            points: polylineCoordinates,
            color: Constants.darkBlueColor,
            width: 6,
          ),
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ),
    );
  }
}
