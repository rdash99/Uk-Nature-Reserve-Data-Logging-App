import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_route.dart';

class SignUpRoute extends StatefulWidget {
  @override
  State createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
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
        shadowColor: Colors.lime.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 48.0,
          child: Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          color: Colors.lime,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginRoute()));
          },
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [username, password, submitButton],
        ),
      ),
    );
  }
}
