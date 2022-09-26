import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/dashboard.dart';
import 'package:emergency_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var _userNameController = TextEditingController();
var _passwordController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Constants.greyColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) {
              return const HomeScreen();
            })),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: size.width,
                    height: size.height * 0.45,
                    child: const Image(
                      image: AssetImage('assets/images/wallpaper.jpg'),
                      fit: BoxFit.cover,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0)),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                  ),
                  SizedBox(
                    height: size.height * 0.45,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: size.width * 0.5,
                          color: Constants.greyColor,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Text(
                          'Enter username and password\n to Sign in',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size.width * 0.05,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                    vertical: 20, horizontal: size.width * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Constants.label(
                          "* E-mail", size.width, size.height, size.width),
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Email Field Can't be Empty";
                          } else if (!value.contains("@") ||
                              (!value.contains(".com") &&
                                  !value.contains(".net") &&
                                  !value.contains(".org"))) {
                            return "Invalid Email Form";
                          }
                        },
                        decoration:
                            Constants.fieldsDecoration("Enter your Email"),
                      ),
                      Constants.label(
                          "* Password", size.width, size.height, size.width),
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Password Field Can't be Empty";
                          }
                        },
                        obscureText: true,
                        decoration:
                            Constants.fieldsDecoration("Enter your Password"),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              final credintial = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _userNameController.text,
                                      password: _passwordController.text)
                                  .then(
                                    (value) => Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DashboardScreen(),
                                      ),
                                    ),
                                  );
                            } on FirebaseAuthException catch (e) {
                              String _message = "";
                              if (e.code == 'user-not-found') {
                                _message = "E-mail isn't correct or not found";
                              } else if (e.code == 'wrong-password') {
                                _message = "Incorrect password";
                              }
                              SnackBar snackBar = SnackBar(
                                content: Text(
                                  _message,
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

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) =>
                            //           const DashboardScreen()),
                            // );
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        style: Constants.redButtonStyles(
                            size.height * 0.02, size.width * 0.3),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "By Continuing you agree to the Terms and Conditions",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: size.width * 0.03),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
