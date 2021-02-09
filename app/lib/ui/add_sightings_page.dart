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

  String eng_Name;
  String latin_Name;
  var location;
  bool bird_visible = true;
  bool butterfly_visible = true;
  var dropdownValue = 'Butterflies';
  var dropdownValue1 = 'Butterflies';
  var dropdownValue2 = 'Birds';

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
  check() {
    if (Globals.GlobalData.butterBird == 'Butterflies') {
      setState(() {
        butterfly_visible = true;
        bird_visible = false;
      });
      if (Globals.GlobalData.butterBird == 'Birds') {
        setState(() {
          bird_visible = true;
          butterfly_visible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /* setState(() {
      Globals.GlobalData.butterBird = 'Butterflies';
      check();
    }); */

    // create a collection reference
    CollectionReference Butterfly_Sightings =
        FirebaseFirestore.instance.collection('Butterfly_Sightings');

    Future<void> addButterfly() {
      // Call the Butterfly_Sightings' CollectionReference to add a new document
      return Butterfly_Sightings.add({})
          .then((value) => print("Butterfly Added"))
          .catchError((error) => print("Failed to add Butterfly: $error"));
    }

    final titleSelector1 = Center(
        child: Text('Select animal group',
            style: TextStyle(color: Colors.blue, fontSize: 16.0)));

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
              Globals.GlobalData.butterBird = dropdownValue;
              check();
            });
          },
          items: <String>['Butterflies', 'Birds']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));

    final titleSelector2 = Center(
        child: Text('Select butterfly species',
            style: TextStyle(color: Colors.blue, fontSize: 16.0)));

    final ButterflySpeciesSelect = Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField(
          value: dropdownValue1,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue1 = newValue;
              check();
            });
          },
          items: <String>['Butterflies']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));

    final titleSelector3 = Center(
        child: Text('Select Bird species',
            style: TextStyle(color: Colors.blue, fontSize: 16.0)));

    final BirdSpeciesSelect = Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField(
          value: dropdownValue2,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue2 = newValue;
              check();
            });
          },
          items:
              <String>['Birds'].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));

    final numberSeenButterfly = Visibility(
        visible: butterfly_visible,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Number seen",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onChanged: (text) {
              Globals.GlobalData.butterflyNum = text;
            },
          ),
        ));

    final numberSeenBird = Visibility(
        visible: bird_visible,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Number seen",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            onChanged: (text) {
              Globals.GlobalData.birdNum = text;
            },
          ),
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
            titleSelector1,
            SelectionOptions,
            titleSelector2,
            ButterflySpeciesSelect,
            titleSelector3,
            BirdSpeciesSelect,
            numberSeenButterfly,
            numberSeenBird,
            SubmitButtonButterfly,
            SubmitButtonBird,
          ],
        ),
      ),
    );
  }
}
