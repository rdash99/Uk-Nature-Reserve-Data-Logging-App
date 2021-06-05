import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../login_route.dart';

class Auth {
  Future<void> userSetup(String displayName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    users.add({'Username': displayName, 'uid': uid});
  }

  checkAuth() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print('Already logged in');
      return true;
    } else {
      print('Signed out');
      return false;
    }
  }

  signUp(String email, String password) async {
    BuildContext context;
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.toString(), password: password.toString());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Alert(
                context: context,
                title: 'Error',
                type: AlertType.error,
                desc: 'Provided password is too weak.')
            .show();
      } else if (e.code == 'email-already-in-use') {
        return Alert(
            context: context,
            title: 'Error',
            type: AlertType.error,
            desc: 'Provided email is already in use.',
            buttons: [
              DialogButton(
                child: Text("Go to login",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                onPressed: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginRoute()))
                },
                padding: const EdgeInsets.all(16.0),
                //width: 120,
                height: 120,
              )
            ]).show();
      } else {
        return Alert(
                context: context,
                title: 'Error',
                type: AlertType.error,
                desc: 'Signup failed due to $e')
            .show();
      }
    }
  }

  Future<void> signOut() async {
    BuildContext context;
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return Alert(
          context: context,
          title: 'Error',
          type: AlertType.error,
          desc: 'Sign out failed due to $e',
          buttons: [
            DialogButton(
              child: Text("Try again",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: () => {signOut()},
              padding: const EdgeInsets.all(16.0),
              //width: 120,
              height: 120,
            )
          ]).show();
    }
  }

  resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  verifyEmail() {
    User user = FirebaseAuth.instance.currentUser;
    user.sendEmailVerification();
  }

  checkVerified() {
    User user = FirebaseAuth.instance.currentUser;
    bool verified = user.emailVerified;
    user.reload();
    return verified;
  }
}
