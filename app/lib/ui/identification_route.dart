import 'package:app/Page_navigation/tabs_page.dart';
import 'package:flutter/material.dart';
import 'home_route.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class IdentificationRoute extends StatefulWidget {
  @override
  State createState() => _IdentificationRouteState();
}

class _IdentificationRouteState extends State<IdentificationRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final returnButton = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
            elevation: 5.0,
            shadowColor: Colors.blue.shade100,
            child: MaterialButton(
                minWidth: 200.0,
                height: 48.0,
                child: Text(
                  "GO BACK - you shouldn't be here!",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TabsPage()));
                })));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
          children: [returnButton],
        )));
  }
}
