import 'dart:async';
import 'package:app/ui/edit_sightings_page.dart';
import 'package:flutter/material.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'ui/add_sightings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page_navigation/tabs_page.dart';

FirebaseAnalytics analytics;
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
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
        "/": (context) => TabsPage(),
        "/login": (context) => LoginRoute(),
        "/home": (context) => HomeRoute(),
        "/signup": (context) => SignUpRoute(),
        "/identify": (context) => IdentificationRoute(),
        "/add": (context) => AddSightingsRoute(),
        "/edit": (context) => EditSightingsRoute(),
      },
      initialRoute: "/login",
    );
  }
}
