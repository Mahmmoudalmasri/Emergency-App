import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/success.dart';

import '../../translations/locale_keys.g.dart';

// ignore: must_be_immutable
class CompleteCase extends StatefulWidget {
  double lat;
  double long;
  List sourceLocation;
  CompleteCase({
    Key? key,
    required this.lat,
    required this.long,
    required this.sourceLocation,
  }) : super(key: key);

  @override
  State<CompleteCase> createState() => _CompleteCaseState();
}

var _mobileNoController = TextEditingController();

class _CompleteCaseState extends State<CompleteCase> {
  final _formKey = GlobalKey<FormState>();

  addData() async {
    CollectionReference ambRef =
        FirebaseFirestore.instance.collection('emergency');
    ambRef.doc(_mobileNoController.text).set({
      "mobile": _mobileNoController.text,
      "sourceLatitude": widget.sourceLocation[0]['latitude'],
      "sourceLongitude": widget.sourceLocation[0]['longitude'],
      "distanceLongitude": widget.long,
      "distanceLatitude": widget.lat,
      "date": DateFormat.yMMMd().format(DateTime.now()).toString(),
      "time": DateFormat('h:mm a').format(DateTime.now()).toString(),
      "status": false
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.greyColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          LocaleKeys.title_emergency_req.tr(),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(size.width * 0.06),
        width: size.width,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(size.width * 0.05),
                  margin: EdgeInsets.all(size.width * 0.015),
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Constants.darkBlueColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Text(
                    LocaleKeys.req_agree.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.038,
                        height: size.height * 0.002),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.25,
                ),
                SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Constants.label(LocaleKeys.mobile.tr(), size.width,
                          size.height, size.width),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _mobileNoController,
                        decoration: Constants.fieldsDecoration(
                            LocaleKeys.hint_mobile.tr()),
                        validator: (value) {
                          if (value!.isEmpty || value == null || value == "") {
                            return LocaleKeys.e_empty.tr();
                          }
                          if (value.length < 9) {
                            return LocaleKeys.e_mobile.tr();
                          }
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              addData();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Success(),
                                ),
                              );
                              setState(() {
                                _mobileNoController.text = "";
                              });
                            }
                          },
                          child: Text(LocaleKeys.submit_btn.tr()),
                          style: Constants.redButtonStyles(
                              size.height * 0.022, size.width * 0.36)),
                    ]),
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
