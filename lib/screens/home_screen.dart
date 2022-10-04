import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/requests/complete_accident_request.dart';
import 'package:emergency_app/screens/requests/complete_ambulance_request.dart';
import 'package:emergency_app/screens/requests/complete_fire_request.dart';
import 'package:emergency_app/screens/location_screen.dart';
import 'package:emergency_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location/location.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool _serviceEnabled;
  bool lang = false;
  late PermissionStatus _permissionGranted;
  static LocationData? _location;
  bool got = false;
  List centerLocations = [];

  getData() {
    FirebaseFirestore.instance.collection("centers locations").get().then(
      (value) {
        value.docs.forEach((element) {
          centerLocations.add(element.data());
        });
      },
    );
  }

  Future<void> checkLocationService() async {
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        _location = await location.getLocation();
        setState(() {
          got = true;
        });
      } else {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print("Permission is allowed");
          setState(() {
            got = true;
          });
        } else {
          print("Permission Not Allowed");
        }
      }
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print("Permishion is allowed");
          setState(() {
            got = true;
          });
          _location = await Location().getLocation();
        } else {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.granted) {
            print("Permission is allowed");
            setState(() {
              got = true;
            });
            _location = await Location().getLocation();
          } else {
            print("Permission Not Allowed");
          }
        }
      } else {
        print("Exit");
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      print("Permishion is allowed");
      setState(() {
        got = true;
      });
    } else {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        print("Permission is allowed");
        setState(() {
          got = true;
        });
      } else {
        print("Permission Not Allowed");
      }
    }
  }

  @override
  void initState() {
    super.initState();

    checkLocationService();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.greyColor,
        body: got == false
            ? const Center(
                child: CircularProgressIndicator(
                  color: Constants.blueColor,
                ),
              )
            : Container(
                padding: EdgeInsets.all(size.width * 0.055),
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            ),
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.grey.shade300),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                setState(() {
                                  lang = !lang;
                                });
                                if (lang == false) {
                                  await context.setLocale(Locale('en'));
                                } else {
                                  await context.setLocale(Locale('ar'));
                                }
                              },
                              child: Text(
                                context.locale == Locale('ar') ? "En" : "Ar",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Constants.redColor),
                              )),
                        ],
                      ),
                      Text(
                        "${LocaleKeys.slogen.tr()} \n        ${LocaleKeys.slogen1.tr()}",
                        style: TextStyle(
                          color: Constants.darkBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.05,
                          height: size.height * 0.0018,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Material(
                        elevation: 7.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteAmbulanceRequest()),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.truckMedical,
                            color: Constants.darkBlueColor,
                            size: size.width * 0.1,
                          ),
                          title: Text(
                            LocaleKeys.home_amb.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.darkBlueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.02,
                              horizontal: size.width * 0.05),
                          subtitle: Text(
                            LocaleKeys.home_amb_sub.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.darkBlueColor,
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.03),
                          ),
                          trailing: Icon(
                            context.locale == Locale('ar')
                                ? FontAwesomeIcons.arrowLeft
                                : FontAwesomeIcons.arrowRight,
                            color: Constants.darkBlueColor,
                            size: size.width * 0.07,
                          ),
                          tileColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Material(
                        elevation: 7.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteFireRequest()),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.fireExtinguisher,
                            color: Constants.redColor,
                            size: size.width * 0.1,
                          ),
                          title: Text(
                            LocaleKeys.home_fire.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.redColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.02,
                              horizontal: size.width * 0.05),
                          subtitle: Text(
                            LocaleKeys.home_fire_sub.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.redColor,
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.03),
                          ),
                          trailing: Icon(
                            context.locale == Locale('ar')
                                ? FontAwesomeIcons.arrowLeft
                                : FontAwesomeIcons.arrowRight,
                            color: Constants.redColor,
                            size: size.width * 0.07,
                          ),
                          tileColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Material(
                        elevation: 7.0,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CompleteAccidentRequest()),
                          ),
                          leading: Icon(
                            FontAwesomeIcons.carBurst,
                            color: Constants.orangeColor,
                            size: size.width * 0.1,
                          ),
                          title: Text(
                            LocaleKeys.home_accident.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.orangeColor,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.05),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.02,
                              horizontal: size.width * 0.05),
                          subtitle: Text(
                            LocaleKeys.home_accident_sub.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Constants.orangeColor,
                                fontWeight: FontWeight.normal,
                                fontSize: size.width * 0.03),
                          ),
                          trailing: Icon(
                            context.locale == Locale('ar')
                                ? FontAwesomeIcons.arrowLeft
                                : FontAwesomeIcons.arrowRight,
                            color: Constants.orangeColor,
                            size: size.width * 0.07,
                          ),
                          tileColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: size.width * 0.5,
                          height: size.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            width: size.width * 0.4,
                            height: size.width * 0.4,
                            decoration: const BoxDecoration(
                              color: Constants.blueColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                var lat = await _location!.latitude as double;
                                var lng = await _location!.longitude as double;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationScreen(
                                            lat: lat,
                                            lng: lng,
                                            centerLocations: centerLocations,
                                          )),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(25),
                                width: size.width * 0.3,
                                height: size.width * 0.3,
                                decoration: const BoxDecoration(
                                  color: Constants.darkBlueColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                    child: Text(
                                  LocaleKeys.home_emergency.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.045,
                                      height: size.height * 0.002),
                                )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
