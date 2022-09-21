import 'package:emergency_app/constants.dart';
import 'package:emergency_app/screens/dashboard.dart';
import 'package:emergency_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({Key? key}) : super(key: key);

  @override
  State<LoginScreen1> createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  GlobalKey<FormState>? _formKey;
  @override
  void initState() {
    // TODO: implement initState
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  int x = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var _userNameController = TextEditingController();
    var _passwordController = TextEditingController();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        body: SizedBox(
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  color: Colors.white,
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const HomeScreen())),
                                ),
                              ],
                            ),
                            Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: size.width * 0.5,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Column(
                              children: [
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
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Constants.label("Email", size.width * 0.02,
                          size.height * 0.002, size.width * 0.04),
                      TextFormField(
                        controller: _userNameController,
                        decoration:
                            Constants.fieldsDecoration("Enter your Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'username mustn\'t be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Constants.label("Password", size.width * 0.02,
                          size.height * 0.002, size.width * 0.04),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration:
                            Constants.fieldsDecoration("Enter your password"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password address mustn\'t be empty';
                          }
                          return null;
                        },
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MaterialButton(
                          onPressed: () async {
                            if (_formKey!.currentState!.validate()) {
                              try {
                                final credintial = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _userNameController.text,
                                        password: _passwordController.text)
                                    .then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DashboardScreen(),
                                        ),
                                      ),
                                    );
                              } on FirebaseAuthException catch (e) {
                                String _message = "";
                                if (e.code == 'user-not-found') {
                                  _message =
                                      "E-mail isn't correct or not found";
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
                          color: const Color(0xFF044686),
                          textColor: Colors.white,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                            ),
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      const Text(
                        'By continuing you agree to the Terms and Conditions',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
