import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'home_route.dart';
import 'package:email_validator/email_validator.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SignUpRoute extends StatefulWidget {
  @override
  State createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  final _controller = TextEditingController();
  bool _validate = false;
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;
  bool _isVisible4 = false;

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
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onChanged: (text) {
          if (EmailValidator.validate(text) == true) {
            Globals.GlobalData.email = text;
            setState(() {
              _isVisible1 = false;
            });
          } else {
            setState(() {
              _isVisible1 = true;
            });
          }
        },
      ),
    );

    // show error
    final emailInputError = Visibility(
        visible: _isVisible1,
        child: Center(
            child: Text('Invalid email!',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));
    // show error
    final alreadyExistsError = Visibility(
        visible: _isVisible4,
        child: Center(
            child: Text(
                'An account already exists for that email, would you like to login?',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

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
            setState(() {
              _isVisible2 = false;
            });
          } else {
            setState(() {
              _isVisible2 = true;
            });
          }
        },
      ),
    );

    // password validation error
    final passwordMatchError = Visibility(
        visible: _isVisible2,
        child: Center(
            child: Text('Passwords do not match!',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

// weak password error
    final weakPasswordError = Visibility(
        visible: _isVisible3,
        child: Center(
            child: Text('The password provided is too weak',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

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
            // go to home screen
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeRoute()));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
              setState(() {
                _isVisible3 = true;
                _isVisible4 = false;
              });
            } else if (e.code == 'email-already-in-use') {
              print('An account already exists for that email.');
              setState(() {
                _isVisible4 = true;
                _isVisible3 = false;
              });
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );

    //create home button
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

    // create login page link button
    final loginButton = Visibility(
        visible: _isVisible4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 5.0,
            shadowColor: Colors.blue.shade100,
            child: MaterialButton(
              minWidth: 200.0,
              height: 48.0,
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginRoute()));
              },
            ),
          ),
        ));

    //display page
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            inputEmail,
            emailInputError,
            alreadyExistsError,
            passwordInput1,
            passwordInput2,
            passwordMatchError,
            weakPasswordError,
            signUpButton,
            loginButton,
            homeButton,
          ],
        ),
      ),
    );
  }
}
