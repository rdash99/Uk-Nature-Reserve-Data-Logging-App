import 'dart:ffi';

import 'package:app/ui/home_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;

class AddSightingsRoute extends StatefulWidget {
  @override
  State createState() => _AddSightingsRouteState();
}

class _AddSightingsRouteState extends State<AddSightingsRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool bird_visible = true;
  bool butterfly_visible = true;
  var dropdownValue = 'Butterflies';

  /* var butterfly_list = FirebaseFirestore.instance
      .collection('Species')
      .doc('Butterflies')
      .collection('Butterflies')
      .get()
      .then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print(result.data());
    });
  }); */
  @override
  Void check() {
    if (dropdownValue == 'Butterflies') {
      setState(() {
        butterfly_visible = true;
        bird_visible = false;
      });
      if (dropdownValue == 'Birds') {
        setState(() {
          bird_visible = true;
          butterfly_visible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final SelectionOptions = Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
            if (newValue == 'Butterflies') {
              setState(() {
                butterfly_visible = true;
                bird_visible = false;
              });
            } else {
              setState(() {
                bird_visible = true;
                butterfly_visible = false;
              });
            }
          },
          items: <String>['Butterflies', 'Birds']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));

    final SubmitButtonBird = Visibility(
        visible: bird_visible,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 48.0,
            child: Text(
              "Submit bird",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            onPressed: () {},
            color: Colors.blue,
          ),
        ));

    final SubmitButtonButterfly = Visibility(
        visible: butterfly_visible,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MaterialButton(
            minWidth: 200.0,
            height: 48.0,
            child: Text(
              "Submit butterfly",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            onPressed: () {},
            color: Colors.blue,
          ),
        ));

//display page
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          children: [
            SelectionOptions,
            SubmitButtonButterfly,
            SubmitButtonBird,
          ],
        ),
      ),
    );
  }
}
