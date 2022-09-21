import 'package:emergency_app/constants.dart';
import 'package:flutter/material.dart';

class CompleteAmbulanceRequest extends StatefulWidget {
  const CompleteAmbulanceRequest({Key? key}) : super(key: key);

  @override
  State<CompleteAmbulanceRequest> createState() =>
      _CompleteAmbulanceRequestState();
}

class _CompleteAmbulanceRequestState extends State<CompleteAmbulanceRequest> {
  // double maxLines = 5.0;
  bool _canWalk = false;
  bool _fainting = false;
  bool _chronicDiseases = false;
  bool _clot = false;
  bool _specialNeeds = false;
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
          'Ambulance Request',
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
                              label: const Text("Can Walk"),
                              selected: _canWalk,
                              onSelected: (value) {
                                setState(() {
                                  _canWalk = value;
                                  if (_canWalk) sitOfCase.add("Can Walk");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _canWalk ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("Chronic Diseases"),
                              selected: _chronicDiseases,
                              onSelected: (value) {
                                setState(() {
                                  _chronicDiseases = value;
                                  if (_chronicDiseases) {
                                    sitOfCase.add("Chronic Diseases");
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
                              label: const Text("FAINTING"),
                              selected: _fainting,
                              onSelected: (value) {
                                setState(() {
                                  _fainting = value;
                                  if (_fainting) sitOfCase.add("Fainting");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _fainting ? Colors.white : Colors.grey),
                              elevation: 2,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                            ChoiceChip(
                              label: const Text("Patient with Special Needs"),
                              selected: _specialNeeds,
                              onSelected: (value) {
                                setState(() {
                                  _specialNeeds = value;
                                  if (_specialNeeds) {
                                    sitOfCase.add("Special Needs");
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
                              label: const Text("Clot"),
                              selected: _clot,
                              onSelected: (value) {
                                setState(() {
                                  _clot = value;
                                  if (_clot) sitOfCase.add("Clot");
                                });
                              },
                              selectedColor: Constants.blueColor,
                              labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _clot ? Colors.white : Colors.grey),
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
