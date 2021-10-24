import 'dart:async';
import 'ui/Sightings/edit_sightings_page.dart';
import 'ui/Sightings/EditPages/edit_sightings_page_butterflies.dart';
import 'ui/Sightings/EditPages/edit_sightings_page_birds.dart';
import 'package:flutter/material.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'ui/Sightings/add_sightings_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Page_navigation/tabs_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:app/ui/test_page.dart';

late FirebaseAnalytics analytics;
Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  analytics = FirebaseAnalytics();
  await Firebase.initializeApp();
  try {
    await FirebaseFirestore.instance.enablePersistence();
  } catch (error) {
    print(error);
  }
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'UK Nature Reserve data',
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
        "/butterflyedit": (context) => EditButterflySightingsRoute(),
        "/birdedit": (context) => EditBirdSightingsRoute(),
        "/test": (context) => TestRoute()
      },
      initialRoute: "/login",
    );
  }
}
