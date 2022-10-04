import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/success.dart';
import 'package:emergency_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

class CompleteAccidentRequest extends StatefulWidget {
  const CompleteAccidentRequest({Key? key}) : super(key: key);

  @override
  State<CompleteAccidentRequest> createState() =>
      _CompleteAccidentRequestState();
}

var _nationalIdController = TextEditingController();
var _nameController = TextEditingController();
var _ageController = TextEditingController();
var _mobileController = TextEditingController();

class _CompleteAccidentRequestState extends State<CompleteAccidentRequest> {
  // double maxLines = 5.0;
  bool _strongColligion = false;
  bool _twoCars = false;
  bool _threeCarsAndMore = false;
  bool _injuries = false;
  bool _selfSident = false;
  bool _unknounCase = false;

  final _formKey = GlobalKey<FormState>();

  List<String> sitOfCase = [];

  addData() async {
    CollectionReference ambRef =
        FirebaseFirestore.instance.collection('accident');
    ambRef.doc(_mobileController.text).set({
      "national id": _nationalIdController.text,
      "name": _nameController.text,
      "age": int.parse(_ageController.text),
      "mobile": _mobileController.text,
      "date": DateFormat.yMMMd().format(DateTime.now()).toString(),
      "time": DateFormat('h:mm a').format(DateTime.now()).toString(),
      "sit of case": sitOfCase,
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
          LocaleKeys.title_accident_req.tr(),
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
                  height: size.height * 0.04,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Constants.label(LocaleKeys.natID.tr(), size.width,
                            size.height, size.width),
                        TextFormField(
                          controller: _nationalIdController,
                          keyboardType: TextInputType.number,
                          decoration: Constants.fieldsDecoration(
                              LocaleKeys.hint_natId.tr()),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(LocaleKeys.full_name.tr(), size.width,
                            size.height, size.width),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.e_empty.tr();
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: Constants.fieldsDecoration(
                              LocaleKeys.hint_name.tr()),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(LocaleKeys.age.tr(), size.width,
                            size.height, size.width),
                        TextFormField(
                          controller: _ageController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.e_empty.tr();
                            } else if (int.parse(value) < 18) {
                              return LocaleKeys.e_age.tr();
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: Constants.fieldsDecoration(
                              LocaleKeys.hint_age.tr()),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(LocaleKeys.mobile.tr(), size.width,
                            size.height, size.width),
                        TextFormField(
                          controller: _mobileController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return LocaleKeys.e_empty.tr();
                            } else if (value.length < 9) {
                              return LocaleKeys.e_mobile.tr();
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: Constants.fieldsDecoration(
                              LocaleKeys.hint_mobile.tr()),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(LocaleKeys.sit_case.tr(), size.width,
                            size.height, size.width),
                        Container(
                          padding: EdgeInsets.all(size.width * 0.03),
                          margin: EdgeInsets.all(size.width * 0.01),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ChoiceChip(
                                      label: Text(LocaleKeys.strong_acc.tr()),
                                      selected: _strongColligion,
                                      onSelected: (value) {
                                        setState(() {
                                          _strongColligion = value;
                                          if (_strongColligion) {
                                            sitOfCase.add(
                                                LocaleKeys.strong_acc.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _strongColligion
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    ChoiceChip(
                                      label: Text(LocaleKeys.two.tr()),
                                      selected: _twoCars,
                                      onSelected: (value) {
                                        setState(() {
                                          _twoCars = value;
                                          if (_twoCars) {
                                            sitOfCase.add(LocaleKeys.two.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _twoCars
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ChoiceChip(
                                      label: Text(LocaleKeys.injuries.tr()),
                                      selected: _injuries,
                                      onSelected: (value) {
                                        setState(() {
                                          _injuries = value;
                                          if (_injuries) {
                                            sitOfCase
                                                .add(LocaleKeys.injuries.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _injuries
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    ChoiceChip(
                                      label: Text(LocaleKeys.three.tr()),
                                      selected: _threeCarsAndMore,
                                      onSelected: (value) {
                                        setState(() {
                                          _threeCarsAndMore = value;
                                          if (_threeCarsAndMore) {
                                            sitOfCase
                                                .add(LocaleKeys.three.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _threeCarsAndMore
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ChoiceChip(
                                      label: Text(LocaleKeys.self.tr()),
                                      selected: _selfSident,
                                      onSelected: (value) {
                                        setState(() {
                                          _selfSident = value;
                                          if (_selfSident) {
                                            sitOfCase.add(LocaleKeys.self.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _selfSident
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    ChoiceChip(
                                      label: Text(LocaleKeys.unknown.tr()),
                                      selected: _unknounCase,
                                      onSelected: (value) {
                                        setState(() {
                                          _unknounCase = value;
                                          if (_unknounCase) {
                                            sitOfCase
                                                .add(LocaleKeys.unknown.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _unknounCase
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (_injuries == true ||
                                    _selfSident == true ||
                                    _strongColligion == true ||
                                    _threeCarsAndMore == true ||
                                    _twoCars == true ||
                                    _unknounCase == true) {
                                  addData();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Success()),
                                  );
                                } else {
                                  SnackBar snackBar = SnackBar(
                                    content: Text(
                                      LocaleKeys.e_sit.tr(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: const Duration(seconds: 4),
                                    elevation: 3,
                                    backgroundColor: Constants.redColor,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Text(LocaleKeys.submit_btn.tr()),
                            style: Constants.redButtonStyles(
                                size.height * 0.022, size.width * 0.36)),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
