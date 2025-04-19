import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kanshare/Screen/Homepage.dart';
import 'package:kanshare/Screen/Signup.dart';
import 'package:kanshare/firebase_options.dart';

import 'Screen/loginscreen.dart';
import 'Screen/mainscreen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
DatabaseReference Clientsdb = FirebaseDatabase.instance.ref().child("Clients");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanshare',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    debugShowCheckedModeBanner: false,
    initialRoute : '/Homepage',
    // initialRoute:FirebaseAuth.instance.currentUser == null ? '/SignUP'
    // : '/Homepage',
    routes: {
      "/Homepage": (context) =>HomeScreen(),
      "/Sign": (context) =>LoginScreen(),
      "/SignUP": (context) =>SignUpScreen(),
      "/main": (context) =>mainscreen(),
    },
    );
  }
}
