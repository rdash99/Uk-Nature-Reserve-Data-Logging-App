import 'dart:async';
import 'package:flutter/material.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'ui/add_sightings_page.dart';
import 'Page_navigation/tabs_page.dart';
import 'database/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local database
  final dbHelper = DatabaseHelper();
  await dbHelper.database; // This will create the database if it doesn't exist
  
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
      },
      initialRoute: "/login",
    );
  }
}
