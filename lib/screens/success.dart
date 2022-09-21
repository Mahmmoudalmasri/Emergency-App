import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/home_screen.dart';
import 'package:flutter/material.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.darkBlueColor,
        body: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              Container(
                  child: Icon(
                    Icons.check,
                    color: Constants.darkBlueColor,
                    size: size.width * 0.5,
                  ),
                  width: size.width * 0.7,
                  height: size.width * 0.7,
                  margin: EdgeInsets.all(size.width * 0.1),
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle)),
              Text(
                'Thank you for your help ... \n'
                '        We appreciate it',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.bold,
                    height: size.height * 0.002),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.05,
                      vertical: size.width * 0.008),
                  width: size.width,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => HomeScreen()));
                    },
                    child: Text(
                      'BACK TO HOME',
                      style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
