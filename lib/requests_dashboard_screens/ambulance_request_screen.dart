import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmbulanceRequestScreen extends StatefulWidget {
  const AmbulanceRequestScreen({Key? key}) : super(key: key);

  @override
  State<AmbulanceRequestScreen> createState() => _AmbulanceRequestScreenState();
}

class _AmbulanceRequestScreenState extends State<AmbulanceRequestScreen> {
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

  bool ambulanceCheck = false;
  bool fireCheck = false;
  bool trafficCheck = false;

  List ambulanceData = [];

  getData() {
    FirebaseFirestore.instance
        .collection("ambulance")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        setState(() {
          ambulanceData.add(element.data());
        });
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: ambulanceData.length,
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
                        ambulanceData[index]["name"],
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
                                    height: size.height * 0.21,
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
                                    LocaleKeys.natID.tr(),
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.age.tr(),
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.mobile.tr(),
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.date.tr(),
                                    style: detailsStyle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    LocaleKeys.time.tr(),
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
                            "${ambulanceData[index]["national id"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ambulanceData[index]["age"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ambulanceData[index]["mobile"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ambulanceData[index]["date"]}",
                            style: detailsStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${ambulanceData[index]["time"]}",
                            style: detailsStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StatefulBuilder(
                    builder: (context, setState) => ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            elevation: 3,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25)),
                            ),
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.all(size.width * 0.02),
                                height: size.height * 0.8,
                                width: size.width,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: size.width * 0.2,
                                          height: size.height * 0.01,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              color: Colors.grey.shade300),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(size.width * 0.02),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Text(
                                            LocaleKeys.case_btn.tr(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.04,
                                          ),
                                          Container(
                                            width: size.width,
                                            height: size.height * 0.3,
                                            color: Colors.grey.shade300,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.03,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                                LocaleKeys.action_btn.tr()),
                                            style: redButton(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text(
                        LocaleKeys.case_btn.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: redButton(context),
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
