import 'package:app/Page_navigation/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'home_route.dart';
import 'sign_up_route.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class LoginRoute extends StatefulWidget {
  @override
  State createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final _controller = TextEditingController();
  bool _validate = false;
  bool _isVisible1 = false;
  bool _isVisible2 = false;

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
          } else {}
        },
      ),
    );

    // show error
    final emailError = Visibility(
        visible: _isVisible2,
        child: Center(
            child: Text(
                'No user exists with that email, do you want to sign up?',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

    //create password input
    final passwordInput = Padding(
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
          Globals.GlobalData.password = text;
        },
      ),
    );

    // show error
    final passwordError = Visibility(
        visible: _isVisible1,
        child: Center(
            child: Text('Incorrect password!',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

    //create submission button
    final loginButton = Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 48.0,
        child: Text(
          "LOGIN",
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
                .signInWithEmailAndPassword(
                    email: Globals.GlobalData.email,
                    password: Globals.GlobalData.password);
            Globals.GlobalData.userID = auth.currentUser.uid;
            // go to home screen
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('No user found for that email.');
              setState(() {
                _isVisible1 = false;
                _isVisible2 = true;
              });
            } else if (e.code == 'wrong-password.') {
              print('Incorrect password!');
              setState(() {
                _isVisible2 = false;
                _isVisible1 = true;
              });
            }
          } catch (e) {
            print(e);
          }
        },
      ),
    );

    //create link to sign up page
    final signUpButton = Visibility(
        visible: true,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 5.0,
            shadowColor: Colors.blue.shade100,
            child: MaterialButton(
              minWidth: 200.0,
              height: 48.0,
              child: Text(
                "SIGN UP",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              color: Colors.blue,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpRoute()));
              },
            ),
          ),
        ));

    //create forgot password button
    final forgotButton = Visibility(
        visible: _isVisible1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Material(
            elevation: 5.0,
            shadowColor: Colors.blue.shade100,
            child: MaterialButton(
              minWidth: 200.0,
              height: 48.0,
              child: Text(
                "Forgottten password?",
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
              color: Colors.blue,
              onPressed: () {},
            ),
          ),
        ));

    //create back button
    final homeButton = Visibility(
        visible: false,
        child: Padding(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeRoute()));
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
            emailError,
            passwordInput,
            passwordError,
            loginButton,
            forgotButton,
            signUpButton,
            homeButton,
          ],
        ),
      ),
    );
  }
}
