import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/login_screen.dart';
import 'package:emergency_app/requests_dashboard_screens/accident_request_screen.dart';
import 'package:emergency_app/requests_dashboard_screens/ambulance_request_screen.dart';
import 'package:emergency_app/requests_dashboard_screens/emergency_case.dart';
import 'package:emergency_app/requests_dashboard_screens/fire_request_screen.dart';
import 'package:emergency_app/translations/locale_keys.g.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Map> screens = [
    {
      "title": LocaleKeys.dash_title_emergency.tr(),
      "body": EmergencyCase(),
    },
    {
      "title": LocaleKeys.dash_amb_req.tr(),
      "body": AmbulanceRequestScreen(),
    },
    {
      "title": LocaleKeys.dash_fire_req.tr(),
      "body": FireRequestScreen(),
    },
    {
      "title": LocaleKeys.dash_acc_req.tr(),
      "body": AccidentRequestScreen(),
    }
  ];

  TextStyle titleStyle = const TextStyle(
      color: Color(0xFFFFFFFF), fontSize: 17, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xFF044686),
          elevation: 2,
          title: Text(
            "${screens[_selectedIndex]["title"]}",
            style: titleStyle,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                            ),
                          );
                    } on FirebaseAuthException catch (e) {
                      SnackBar snackBar = SnackBar(
                        content: Text(
                          e.code,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        duration: const Duration(seconds: 4),
                        elevation: 3,
                        backgroundColor: Constants.redColor,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF044686),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.suitcaseMedical),
                label: "Emergency"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.truckMedical), label: "Ambulance"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.fireExtinguisher), label: "Fire"),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.carBurst), label: "Accident"),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFFFFDD04),
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          iconSize: 20,
          elevation: 2,
        ),
        backgroundColor: const Color(0xFFF4F4F4),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: screens[_selectedIndex]["body"],
        ),
      ),
    );
  }
}
