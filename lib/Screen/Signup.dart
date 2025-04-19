import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

import '../Constants/constants.dart';
import '../main.dart';
import 'loginscreen.dart';
import 'mainscreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _firstnameController = TextEditingController();
  var fullPhoneNumber = TextEditingController();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPwdController = TextEditingController();

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _confirmPwdController = new TextEditingController();

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
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Container(
        child: Stack(children: [
          Container(
            height: heightDevice * 0.7,
            decoration: BoxDecoration(
              color: Colors.black,
            ),

          ),
          Container(
            margin: EdgeInsets.only(top: heightDevice * 0.03),
            child: Lottie.asset('assets/animations/ani.json', width: 250),
          ),
          Container(
            margin: EdgeInsets.only(top: heightDevice * 0.28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45),
                topRight: Radius.circular(45),
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Username",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),

                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration:
                          InputDecoration(hintText: "Doe"),
                          keyboardType: TextInputType.name,
                          controller: _usernameController,
                          validator: emailValidator,
                        ),
                      ),


                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration:
                          InputDecoration(hintText: "john.doe@gmail.com"),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          validator: emailValidator,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Password",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "********"),
                          obscureText: true,
                          controller: _passwordController,
                          validator: pwdValidator,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: widthDevice * 0.1),
                        child: SizedBox(
                          width: widthDevice * 0.8,
                          height: heightDevice * 0.09,
                          child: TextButton(
                            onPressed:() async {
                              registerNewUser(context);
                              // firebaseRegistration();},
                            },
                            child: Text(
                              'Sign Up',
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
                              "Already have an account ! ",
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
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text(
                                "Sign In",
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
            ),
          ),
        ]),
      ),
    );
  }

  void firebaseRegistration() async {
    if (_confirmPwdController.text == _passwordController.text) {
      _registerFormKey.currentState!.validate();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text)
            .then((value) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(value.user!.uid)
              .set({
            "email": _emailController.text,
            "password":  _passwordController.text,

          });
        }).then((value) => Navigator.pushAndRemoveUntil(
            context,
              MaterialPageRoute(builder: (context) => mainscreen()),
                (_) => false));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Passwords doesn't match"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
        content: Text("It is the body of the alert Dialog"),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }
  }

  User? firebaseUser;
  User? currentfirebaseUser;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> registerNewUser(BuildContext context) async {
    // String fullPhoneNumber = '$selectedCountryCode${phonecontroller.text.trim()
    //     .toString()}';

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
                      borderRadius: BorderRadius.circular(20.0)
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            SizedBox(width: 6.0,),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.black),),
                            SizedBox(width: 26.0,),
                            Text("Signing up,please wait...")

                          ],
                        ),
                      ))));
        });


    firebaseUser = (await _firebaseAuth
        .createUserWithEmailAndPassword(
        email: _emailController.text, password: _passwordController.text)
        .catchError((errMsg) {
      Navigator.pop(context);
      displayToast("Error" + errMsg.toString(), context);
    }))
        .user;


    if (firebaseUser != null) // user created

        {
      //save use into to database

      Map userDataMap = {

        "email": _emailController.text.trim().toString(),
        "FirstName": _firstnameController.text.trim().toString(),
        "LastName": _usernameController.text.trim().toString(),
        // "phoneNumber": fullPhoneNumber,
        "Password": _passwordController.text.trim().toString(),

      };
      Clientsdb.child(firebaseUser!.uid).set(userDataMap);
      // Admin.child(firebaseUser!.uid).set(userDataMap);

      currentfirebaseUser = firebaseUser;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginScreen(),
        ),
      );
    } else {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return login();
      //   }),
      // );      // Navigator.pop(context);
      // error occured - display error
      displayToast("user has not been created", context);
    }
  }

}
displayToast(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}