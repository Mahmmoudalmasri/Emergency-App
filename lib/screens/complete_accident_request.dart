import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/success.dart';
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.greyColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title: const Text(
          'Accident Request',
          style: TextStyle(
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
                    "By submitting this form, you confirm that the information entered is correct and any false information exspose you to legal accoutability.",
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
                        Constants.label(
                            "National ID", size.width, size.height, size.width),
                        TextFormField(
                          controller: _nationalIdController,
                          keyboardType: TextInputType.number,
                          decoration:
                              Constants.fieldsDecoration("Enter National ID"),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(
                            "Full Name", size.width, size.height, size.width),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is required";
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration:
                              Constants.fieldsDecoration("Enter Full Name"),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(
                            "Age", size.width, size.height, size.width),
                        TextFormField(
                          controller: _ageController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age is required";
                            } else if (int.parse(value) < 18) {
                              return "you are under age";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                              Constants.fieldsDecoration("Enter Your Age"),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label(
                            "Mobile", size.width, size.height, size.width),
                        TextFormField(
                          controller: _mobileController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Mobile is required";
                            } else if (value.length < 9) {
                              return "Enter valid mobile no";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration:
                              Constants.fieldsDecoration("Enter Mobile No"),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Constants.label("Situation of Case", size.width,
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
                                      label: const Text("Strong Collision"),
                                      selected: _strongColligion,
                                      onSelected: (value) {
                                        setState(() {
                                          _strongColligion = value;
                                          if (_strongColligion) {
                                            sitOfCase.add("Strong Collision");
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
                                      label: const Text("Two Cars"),
                                      selected: _twoCars,
                                      onSelected: (value) {
                                        setState(() {
                                          _twoCars = value;
                                          if (_twoCars) {
                                            sitOfCase.add("Two Cars");
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
                                      label: const Text("Injuries"),
                                      selected: _injuries,
                                      onSelected: (value) {
                                        setState(() {
                                          _injuries = value;
                                          if (_injuries)
                                            sitOfCase.add("Injuries");
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
                                      label: const Text("Three Cars and More"),
                                      selected: _threeCarsAndMore,
                                      onSelected: (value) {
                                        setState(() {
                                          _threeCarsAndMore = value;
                                          if (_threeCarsAndMore) {
                                            sitOfCase
                                                .add("Three Cars and More");
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
                                      label: const Text("Self-Sident"),
                                      selected: _selfSident,
                                      onSelected: (value) {
                                        setState(() {
                                          _selfSident = value;
                                          if (_selfSident)
                                            sitOfCase.add("Self-Sident");
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
                                      label:
                                          const Text("CAN'T DIAGNOSE THE CASE"),
                                      selected: _unknounCase,
                                      onSelected: (value) {
                                        setState(() {
                                          _unknounCase = value;
                                          if (_unknounCase) {
                                            sitOfCase.add("Can't Diagnose");
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_injuries == true ||
                                    _selfSident == true ||
                                    _strongColligion == true ||
                                    _threeCarsAndMore == true ||
                                    _twoCars == true ||
                                    _unknounCase == true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Success()),
                                  );
                                } else {
                                  SnackBar snackBar = const SnackBar(
                                    content: Text(
                                      " You must choose at least one situation of case",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    duration: Duration(seconds: 4),
                                    elevation: 3,
                                    backgroundColor: Constants.redColor,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: const Text("SUBMIT"),
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
