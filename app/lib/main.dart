import 'package:flutter/material.dart';
import 'login_route.dart';
import 'home_route.dart';
import 'sign_up_route.dart';
import 'identification_route.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
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
    ;
  }
}
