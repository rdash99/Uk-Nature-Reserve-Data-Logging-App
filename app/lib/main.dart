import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'dart:async';

FirebaseAnalytics analytics;
void main() {
  analytics = FirebaseAnalytics();
  runApp(MyApp());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseApp MyApp = Firebase.app();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //initialise flutterfire
      future: _initialization,
      builder: (context, snapshot) {
        //check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }

        //once complete, load app
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }

        //otherwise show loading screen
        return Loading();
      },
    );
  }
}

class SomethingWentWrong extends App {}

class Loading extends App {
  @override
  Widget build(BuildContext context) {
    final spinkit = SpinKitFadingCircle(
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven ? Colors.red : Colors.green,
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: spinkit,
      ),
    );
  }
}

// ignore: must_be_immutable
class MyApp extends App {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.lime,
      ),
      routes: {
        "/": (context) => LoginRoute(),
        "/home": (context) => HomeRoute(),
        "/signup": (context) => SignUpRoute(),
        "/identify": (context) => IdentificationRoute(),
      },
      initialRoute: "/",
    );
  }
}
