import 'dart:html';
import 'package:app/Page_navigation/tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'home_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
    //store user data
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    Future<void> addUser() {
      return users
          .add({
            'First_name': Globals.GlobalData.firstName,
            'surname': Globals.GlobalData.surname,
            'UserId': Globals.GlobalData.userID
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    //create first name input
    final firstName = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          decoration: InputDecoration(
            labelText: "First name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          onChanged: (text) {
            Globals.GlobalData.firstName = text;
          }),
    );

    //create second name input
    final surname = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
          decoration: InputDecoration(
            labelText: "Surname",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
          onChanged: (text) {
            Globals.GlobalData.surname = text;
          }),
    );

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

            Globals.GlobalData.userID = auth.currentUser.uid;
            /* FirebaseFirestore.instance
                .collection('Users')
                .doc(Globals.GlobalData.userID)
                .set({
              "FirstName": Globals.GlobalData.firstName,
              "Surname": Globals.GlobalData.surname,
              "Email": Globals.GlobalData.email,
            }); */
            Globals.GlobalData.userID = FirebaseAuth.instance.currentUser.uid;
            // go to home screen
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()));
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
            firstName,
            surname,
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
