import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeRoute extends StatefulWidget {
  @override
  State createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  bool _isVisible1 = false;
  bool _isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    final menu = Column(
      children: <Widget>[
        ListTile(
          title: Text("Identify"),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName("/identify"));
          },
        ),
        //log out button
        Visibility(
          visible: _isVisible1,
          child: ListTile(
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ),
        //login button
        Visibility(
          visible: _isVisible2,
          child: ListTile(
            title: Text("Login"),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ),
      ],
    );
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        setState(() {
          _isVisible2 = true;
          _isVisible1 = false;
        });
      } else {
        setState(() {
          _isVisible2 = false;
          _isVisible1 = true;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("John Doe"),
              accountEmail: Text("johndoe@testfairy.com"),
            ),
            menu,
          ],
        ),
      ),
      body: Center(
        child: Text("Hello"),
      ),
      floatingActionButton: FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
