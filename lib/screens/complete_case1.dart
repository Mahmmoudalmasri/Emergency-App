import 'package:emergency_app/screens/success.dart';
import 'package:emergency_app/views/text.dart';
import 'package:flutter/material.dart';

class CompleteCase extends StatefulWidget {
  const CompleteCase({Key? key}) : super(key: key);

  @override
  State<CompleteCase> createState() => _CompleteCaseState();
}

class _CompleteCaseState extends State<CompleteCase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue.shade900,
          title: Text(
            'Complete Case',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Container(
            height: 110,
            width: 350,
            // margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            padding: EdgeInsets.only(left: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blue.shade900,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              'By submiting this from , you confirm that \n'
              'the information entered is correct and any false \n'
              'information exposes you to leagal accoutability',
              style: TextStyle(
                color: Colors.white,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.all(25),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    textField('Enter your National ID '),
                    SizedBox(
                      height: 300,
                    ),
                    Container(
                        width: double.infinity,
                        height: 65,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Success()));
                          },
                          child: Text(
                            'SUBMIT',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.redAccent.shade700,
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ))
                  ])),
        ]))));
  }
}
