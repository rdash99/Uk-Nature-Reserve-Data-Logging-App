import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'ui/login_route.dart';
import 'ui/home_route.dart';
import 'ui/sign_up_route.dart';
import 'ui/identification_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _intialized = false;
  bool _error = false;

  void intiializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _intialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    intiializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return SomethingWentWrong();
    }
    if (!_intialized) {
      return Loading();
    }
    return MyApp();
  }
}

class SomethingWentWrong extends App {
  @override
  Widget build(BuildContext context) {}
}

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
        child: ListView(
          children: [spinkit],
        ),
      ),
    );
  }
}

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
    ;
  }
}
