import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kanshare/Screen/mainscreen.dart';
import 'package:lottie/lottie.dart';

import '../Constants/constants.dart';
import 'Homepage.dart';
import 'Signup.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    super.initState();
  }

  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Email format is invalid';
    } else {
      return "";
    }
  }

  String? pwdValidator(String? value) {
    if (value!.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery
        .of(context)
        .size
        .width;
    double heightDevice = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.10),
              child: Column(children: [
                Text(
                  "KanShare",
                  style: TextStyle(
                    color: Color(0XFF091424),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),


              ]),
            ),
            Container(
                margin: EdgeInsets.only(top: heightDevice * 0.0011),
                child: Lottie.asset('assets/animations/ani.json',width: 234,height: 214)),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.02),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.email,
                                size: 28,
                              )),
                          SizedBox(
                            width: widthDevice * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              controller: _emailController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: heightDevice * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            child: Icon(
                              Icons.security,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: widthDevice * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Password"),
                              controller: _passwordController,
                              validator: pwdValidator,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: widthDevice * 0.1),
                      child: SizedBox(
                        width: widthDevice * 0.8,
                        height: heightDevice * 0.09,
                        child: TextButton(
                          onPressed: (){
                            loginAndAuthenticateUser(context);
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: widthDevice * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You don't have an account ! ",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 16,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//Connexion par email/mot de passe
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                  margin: EdgeInsets.all(15.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40.0)),
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 6.0,
                            ),
                            CircularProgressIndicator(
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                            SizedBox(
                              width: 26.0,
                            ),
                            Text("Loging In,please wait")
                          ],
                        ),
                      ))));
        });

    final User? firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
      email: _emailController.text.toString().trim(),
      password: _passwordController.text.toString().trim(),
    )
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;
    try {
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      const String adminEmail = 'admin@gmail.com';
      // if(_emailController.text==adminEmail){
      //
      //   Navigator.pushReplacement(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => Admin()));
      //
      // }
      // else
      if (firebaseUser != null) {
        // AssistantMethod.getCurrentOnlineUserInfo(context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
                (Route<dynamic> route) => false);
        displayToast("Logged-in ", context);
      } else {
        displayToast("Error: Cannot be signed in", context);
      }
    } catch (e) {
      // handle error
    }
  }
}