import 'package:emergency_app/constants.dart';
import 'package:emergency_app/views/text.dart';
import 'package:flutter/material.dart';

class CompleteFireRequest extends StatefulWidget {
  const CompleteFireRequest({Key? key}) : super(key: key);

  @override
  State<CompleteFireRequest> createState() => _CompleteFireRequestState();
}

class _CompleteFireRequestState extends State<CompleteFireRequest> {
  bool _store = false;
  bool _house = false;
  bool _largeArea = false;
  bool _burningWeeds = false;
  bool _smallArea = false;
  bool _injuries = false;
  bool _unknounCase = false;

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
                Constants.label("National ID", size.width * 0.06,
                    size.height * 0.005, size.width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: Constants.fieldsDecoration("Enter National ID"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Constants.label("Full Name", size.width * 0.06,
                    size.height * 0.005, size.width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: Constants.fieldsDecoration("Enter Full Name"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Constants.label("Age", size.width * 0.06, size.height * 0.005,
                    size.width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: Constants.fieldsDecoration("Enter Your Age"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Constants.label("Mobile", size.width * 0.06,
                    size.height * 0.005, size.width * 0.04),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: Constants.fieldsDecoration("Enter Mobile No"),
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Constants.label("Situation of Case", size.width * 0.06,
                    size.height * 0.005, size.width * 0.04),
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
                              label: const Text("Store"),
                              selected: _store,
                              onSelected: (value) {
                                setState(() {
                                  _store = value;
                                  if (_store) {
                                    sitOfCase.add("Store");
                                  }
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _store ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("House"),
                              selected: _house,
                              onSelected: (value) {
                                setState(() {
                                  _house = value;
                                  if (_house) {
                                    sitOfCase.add("House");
                                  }
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _house ? Colors.white : Colors.grey),
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
                                  if (_injuries) sitOfCase.add("Injuries");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _injuries ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("Burning Weeds"),
                              selected: _burningWeeds,
                              onSelected: (value) {
                                setState(() {
                                  _burningWeeds = value;
                                  if (_burningWeeds) {
                                    sitOfCase.add("Burning Weeds");
                                  }
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _burningWeeds
                                      ? Colors.white
                                      : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("Small Area"),
                              selected: _smallArea,
                              onSelected: (value) {
                                setState(() {
                                  _smallArea = value;
                                  if (_smallArea) sitOfCase.add("Small Area");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _smallArea ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ChoiceChip(
                              label: const Text("Large Area"),
                              selected: _largeArea,
                              onSelected: (value) {
                                setState(() {
                                  _largeArea = value;
                                  if (_largeArea) sitOfCase.add("Larg Area");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _largeArea ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("CAN'T DIAGNOSE THE CASE"),
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
                      sitOfCase.forEach((element) {
                        print(element);
                      });
                    },
                    child: const Text("SUBMIT"),
                    style: Constants.redButtonStyles(
                        size.height * 0.022, size.width * 0.36)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
