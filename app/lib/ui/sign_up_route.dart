import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'home_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flash/flash.dart';
import 'package:fluttertoast/fluttertoast.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SignUpRoute extends StatefulWidget {
  @override
  State createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  final _controller = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //create email input
    final inputEmail = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onChanged: (text) {
          if (EmailValidator.validate(text) == true) {
            Globals.GlobalData.email = text;
          } else {
            print('invalid email');
          }
        },
      ),
    );
    //create first password input
    final passwordInput1 = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onChanged: (text) {
          Globals.GlobalData.password_1 = text;
        },
      ),
    );
    //create second password input
    final passwordInput2 = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onChanged: (text) {
          Globals.GlobalData.password_2 = text;
          if (Globals.GlobalData.password_1 == Globals.GlobalData.password_2) {
            Globals.GlobalData.password = Globals.GlobalData.password_2;
          } else {
            print('Passwords do not match!');
          }
        },
      ),
    );
    //create submission button
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
        //attempt to create account
        onPressed: () async {
          setState(() {
            _controller.text.isEmpty ? _validate = true : _validate = false;
          });
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: Globals.GlobalData.email,
                    password: Globals.GlobalData.password);
            //clear stored data on successful submission
            Globals.GlobalData.email = '';
            Globals.GlobalData.password_1 = '';
            Globals.GlobalData.password_2 = '';
            Globals.GlobalData.password = '';
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('An account already exists for that email.');
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );
    final homeButton = Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.blue.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 48.0,
          child: Text(
            "Go Back",
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
    //display page
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            inputEmail,
            passwordInput1,
            passwordInput2,
            signUpButton,
            homeButton,
          ],
        ),
      ),
    );
  }
}
