import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home_route.dart';
import 'sign_up_route.dart';
import 'package:flutter/cupertino.dart';

class LoginRoute extends StatefulWidget {
  @override
  State createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
    final username = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
    final password = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
    final submitButton = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.blue.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 48.0,
          child: Text(
            "LOG IN",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          color: Colors.blue,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeRoute()));
          },
        ),
      ),
    );
    final signUpButton = Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 48.0,
        child: Text(
          "SIGN UP",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        color: Colors.blue,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpRoute()));
        },
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            username,
            password,
            submitButton,
            signUpButton,
          ],
        ),
      ),
    );
  }
}
