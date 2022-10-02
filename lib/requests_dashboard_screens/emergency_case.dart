import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emergency_app/tracking.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EmergencyCase extends StatefulWidget {
  const EmergencyCase({
    Key? key,
  }) : super(key: key);

  @override
  State<EmergencyCase> createState() => _EmergencyCaseState();
}

class _EmergencyCaseState extends State<EmergencyCase> {
  TextStyle nameStyle = const TextStyle(
    color: Color(0xFF0773DC),
    fontSize: 16,
    overflow: TextOverflow.ellipsis,
    fontWeight: FontWeight.bold,
  );

  TextStyle detailsStyle = const TextStyle(
    color: Color(0xFF044686),
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );

  TextStyle checkLabelStyle = const TextStyle(
    color: Color(0xFFE00508),
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );
  ButtonStyle redButton(BuildContext ctx) {
    var size = MediaQuery.of(ctx).size;
    return ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE00508),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.022, horizontal: size.width * 0.27));
  }

  ButtonStyle greyButton(BuildContext ctx) {
    var size = MediaQuery.of(ctx).size;
    return ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC1C1C1),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        padding: EdgeInsets.symmetric(
            vertical: size.height * 0.022, horizontal: size.width * 0.27));
  }

  List emergencyData = [];
  getData() {
    FirebaseFirestore.instance
        .collection("emergency")
        .orderBy("date", descending: false)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        setState(() {
          emergencyData.add(element.data());
        });
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool ambulanceCheck = false;
  bool fireCheck = false;
  bool trafficCheck = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: emergencyData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: size.width * 0.02),
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.white,
            elevation: 5,
            shadowColor: Colors.black,
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        emergencyData[index]["mobile"],
                        style: nameStyle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: size.height * 0.12,
                                    child: const VerticalDivider(
                                      color: Color(0xFFC1C1C1),
                                      thickness: 1,
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mobile:",
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Date:",
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Time:",
                                    style: detailsStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${emergencyData[index]["mobile"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${emergencyData[index]["date"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${emergencyData[index]["time"]}",
                            style: detailsStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.check,
                            size: 60,
                            color: emergencyData[index]["status"]
                                ? const Color(0xFF044686)
                                : const Color(0xFFC1C1C1),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => ElevatedButton(
                      onPressed: emergencyData[index]["status"]
                          ? null
                          : () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => TrackingScreen(
                                          sourceLat: emergencyData[index]
                                              ['sourceLatitude'],
                                          sourceLong: emergencyData[index]
                                              ['sourceLongitude'],
                                          distinationLat: emergencyData[index]
                                              ['distanceLatitude'],
                                          distinationLong: emergencyData[index]
                                              ['distanceLongitude'])));
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return StatefulBuilder(
                              //           builder: (context, setState) {
                              //         return AlertDialog(
                              //           actions: [
                              //             TextButton(
                              //                 onPressed: () =>
                              //                     Navigator.of(context).pop(),
                              //                 child: const Text("Cancel")),
                              //             TextButton(
                              //                 onPressed: () {
                              //                   const snackbar = SnackBar(
                              //                       backgroundColor:
                              //                           Color(0xFFE00508),
                              //                       content: Text(
                              //                         "The Location Sent Successfuly",
                              //                         style: TextStyle(
                              //                             color: Colors.white),
                              //                       ));
                              //                   ScaffoldMessenger.of(context)
                              //                       .showSnackBar(snackbar);
                              //                   setState(() {
                              //                     cases[index]["status"] = true;
                              //                   });
                              //                   Navigator.of(context).pop();
                              //                 },
                              //                 child: const Text(
                              //                   "Send Location",
                              //                   style: TextStyle(
                              //                       color: Color(0xFF0773DC),
                              //                       fontWeight:
                              //                           FontWeight.bold),
                              //                 )),
                              //           ],
                              //           shape: const RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.all(
                              //                   Radius.circular(20))),
                              //           title: const Text(
                              //             "Choose the Needed Viechles",
                              //             style: TextStyle(
                              //                 color: Color(0xFF044686),
                              //                 fontWeight: FontWeight.bold),
                              //           ),
                              //           content: SizedBox(
                              //             height: size.height * 0.19,
                              //             child: Column(
                              //               children: [
                              //                 Row(
                              //                   children: [
                              //                     Checkbox(
                              //                       side: const BorderSide(
                              //                         color: Color(0xFF0773DC),
                              //                         width: 1,
                              //                       ),
                              //                       shape: const RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius.all(
                              //                                   Radius.circular(
                              //                                       3))),
                              //                       activeColor: Colors.white,
                              //                       checkColor:
                              //                           const Color(0xFFE00508),
                              //                       value: ambulanceCheck,
                              //                       onChanged: (bool? value) {
                              //                         setState(() {
                              //                           ambulanceCheck = value!;
                              //                         });
                              //                       },
                              //                     ),
                              //                     Text(
                              //                       "AMBULANCE",
                              //                       style: checkLabelStyle,
                              //                     )
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Checkbox(
                              //                       side: const BorderSide(
                              //                         color: Color(0xFF0773DC),
                              //                         width: 1,
                              //                       ),
                              //                       shape: const RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius.all(
                              //                                   Radius.circular(
                              //                                       3))),
                              //                       activeColor: Colors.white,
                              //                       checkColor:
                              //                           const Color(0xFFE00508),
                              //                       value: fireCheck,
                              //                       onChanged: (bool? value) {
                              //                         setState(() {
                              //                           fireCheck = value!;
                              //                         });
                              //                       },
                              //                     ),
                              //                     Text(
                              //                       "FIRETRUCK",
                              //                       style: checkLabelStyle,
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Checkbox(
                              //                       side: const BorderSide(
                              //                         color: Color(0xFF0773DC),
                              //                         width: 1,
                              //                       ),
                              //                       shape: const RoundedRectangleBorder(
                              //                           borderRadius:
                              //                               BorderRadius.all(
                              //                                   Radius.circular(
                              //                                       3))),
                              //                       activeColor: Colors.white,
                              //                       checkColor:
                              //                           const Color(0xFFE00508),
                              //                       value: trafficCheck,
                              //                       onChanged: (bool? value) {
                              //                         setState(() {
                              //                           trafficCheck = value!;
                              //                         });
                              //                       },
                              //                     ),
                              //                     Text(
                              //                       "TRAFFIC PATROL",
                              //                       style: checkLabelStyle,
                              //                     )
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       });
                              //     });
                            },
                      child: const Text(
                        "TAKE ACTION",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: emergencyData[index]["status"]
                          ? greyButton(context)
                          : redButton(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
