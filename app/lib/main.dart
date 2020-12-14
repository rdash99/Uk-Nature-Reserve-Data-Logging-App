import 'dart:async';
import 'package:flutter/material.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseAnalytics analytics;
Future<void> main() async {
  analytics = FirebaseAnalytics();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) => LoginRoute(),
        "/home": (context) => HomeRoute(),
        "/signup": (context) => SignUpRoute(),
        "/identify": (context) => IdentificationRoute(),
      },
      initialRoute: "/home",
    );
  }
}
