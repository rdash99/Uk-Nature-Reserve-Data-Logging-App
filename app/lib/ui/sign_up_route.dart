import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'login_route.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class SignUpRoute extends StatefulWidget {
  @override
  State createState() => _SignUpRouteState();
}

class _SignUpRouteState extends State<SignUpRoute> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firstName = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
    final lastName = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
    final password1 = Padding(
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
    final password2 = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: "Re-enter Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
    final age = Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Age",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
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
          onPressed: () async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: "barry.allen@example.com",
                      password: "SuperSecretPassword!");
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                print('The password provided is too weak.');
              } else if (e.code == 'email-already-in-use') {
                print('The account already exists for that email.');
              }
            } catch (e) {
              print(e);
            }
          },
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            firstName,
            lastName,
            age,
            password1,
            password2,
            submitButton
          ],
        ),
      ),
    );
  }
}
