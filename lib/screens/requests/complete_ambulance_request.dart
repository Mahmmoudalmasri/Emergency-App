import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/success.dart';
import 'package:emergency_app/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';

class CompleteAmbulanceRequest extends StatefulWidget {
  const CompleteAmbulanceRequest({Key? key}) : super(key: key);

  @override
  State<CompleteAmbulanceRequest> createState() =>
      _CompleteAmbulanceRequestState();
}

var _nationalIdController = TextEditingController();
var _nameController = TextEditingController();
var _ageController = TextEditingController();
var _mobileController = TextEditingController();

class _CompleteAmbulanceRequestState extends State<CompleteAmbulanceRequest> {
  addData() async {
    CollectionReference ambRef =
        FirebaseFirestore.instance.collection('ambulance');
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

  // double maxLines = 5.0;
  bool _canWalk = false;
  bool _fainting = false;
  bool _chronicDiseases = false;
  bool _clot = false;
  bool _specialNeeds = false;
  bool _unknounCase = false;

  List<String> sitOfCase = [];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Constants.greyColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: Text(
          LocaleKeys.title_amb_req.tr(),
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
                                      label: Text(LocaleKeys.can_walk.tr()),
                                      selected: _canWalk,
                                      onSelected: (value) {
                                        setState(() {
                                          _canWalk = value;
                                          if (_canWalk) {
                                            sitOfCase
                                                .add(LocaleKeys.can_walk.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _canWalk
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    ChoiceChip(
                                      label: Text(
                                          LocaleKeys.chronic_diseases.tr()),
                                      selected: _chronicDiseases,
                                      onSelected: (value) {
                                        setState(() {
                                          _chronicDiseases = value;
                                          if (_chronicDiseases) {
                                            sitOfCase.add(LocaleKeys
                                                .chronic_diseases
                                                .tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _chronicDiseases
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
                                      label: Text(LocaleKeys.fainting.tr()),
                                      selected: _fainting,
                                      onSelected: (value) {
                                        setState(() {
                                          _fainting = value;
                                          if (_fainting) {
                                            sitOfCase
                                                .add(LocaleKeys.fainting.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _fainting
                                              ? Colors.white
                                              : Colors.grey),
                                      elevation: 2,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.015,
                                    ),
                                    ChoiceChip(
                                      label:
                                          Text(LocaleKeys.special_needs.tr()),
                                      selected: _specialNeeds,
                                      onSelected: (value) {
                                        setState(() {
                                          _specialNeeds = value;
                                          if (_specialNeeds) {
                                            sitOfCase.add(
                                                LocaleKeys.special_needs.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _specialNeeds
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
                                      label: Text(LocaleKeys.clot.tr()),
                                      selected: _clot,
                                      onSelected: (value) {
                                        setState(() {
                                          _clot = value;
                                          if (_clot) {
                                            sitOfCase.add(LocaleKeys.clot.tr());
                                          }
                                        });
                                      },
                                      selectedColor: Constants.blueColor,
                                      labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _clot
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
                                if (_canWalk == true ||
                                    _clot == true ||
                                    _fainting == true ||
                                    _specialNeeds == true ||
                                    _chronicDiseases == true ||
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
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
