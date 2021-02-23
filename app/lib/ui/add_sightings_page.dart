import 'package:app/ui/home_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:geolocator/geolocator.dart';

class AddSightingsRoute extends StatefulWidget {
  @override
  State createState() => _AddSightingsRouteState();
}

class _AddSightingsRouteState extends State<AddSightingsRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String eng_Name;
  String latin_Name;
  var location;
  bool bird_visible = false;
  bool butterfly_visible = true;
  var dropdownValue = 'Butterflies';
  var dropdownValue1 = 'Adonis Blue';
  var dropdownValue2 = 'Birds';
  var UserID = Globals.GlobalData.userID;
  var SpeciesButterfly = 'test';
  var dateTime = '';
  var formattedDate = '';
  var finalDate = '';
  var formattedTime = '';
  var finalTime = '';
  var latitude = '';
  var longitude = '';

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
    // create a collection reference for butterfly sightings
    CollectionReference Butterfly_Sightings =
        FirebaseFirestore.instance.collection('Butterfly_Sightings');

    // create a collection reference for birds sightings
    CollectionReference Bird_Sightings =
        FirebaseFirestore.instance.collection('Bird_Sightings');

    // create a collection reference for butterfly species
    CollectionReference Butterfly_Species = FirebaseFirestore.instance
        .collection('Species/Butterflies/Butterflies/');

    var Butterfly_Species_List = Butterfly_Species.get();

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

    final titleSelector2 = Visibility(
        visible: butterfly_visible,
        child: Center(
            child: Text('Select butterfly species',
                style: TextStyle(color: Colors.blue, fontSize: 16.0))));

    final ButterflySpeciesSelect = Visibility(
        visible: butterfly_visible,
        child: Padding(
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
                  SpeciesButterfly = newValue;
                  check();
                });
              },
              items: <String>[
                'Adonis Blue',
                'Black Hairstreak',
                'Brimstone',
                'Brown Argus',
                'Brown Hairstreak',
                'Chalkhill Blue',
                'Chequered Skipper',
                'Clouded Yellow',
                'Comma',
                'Common Blue',
                'Dark Green Fritillary',
                'Dingy Skipper',
                'Duke of Burgundy',
                'Essex Skipper',
                'Gatekeeper',
                'Glanville Fritillary',
                'Grayling',
                'Green-veined White',
                'Green Hairstreak',
                'Grizzled Skipper',
                'Heath Fritillary',
                'High Brown Fritillary',
                'Holly Blue',
                'Large Blue',
                'Large Heath',
                'Large Skipper',
                'Large White',
                'Lulworth Skipper',
                'Marbled White',
                'Marsh Fritillary',
                'Meadow Brown',
                'Mountain Ringlet',
                'Northern Brown Argus',
                'Swallowtail',
                'Orange Tip',
                'Painted Lady',
                'Peacock',
                'Pearl-bordered Fritillary',
                'Purple Emperor',
                'Purple Hairstreak',
                'Real’s Wood White',
                'Red Admiral',
                'Ringlet',
                'Scotch Argus',
                'Silver-spotted Skipper',
                'Silver-studded Blue',
                'Silver-washed Fritillary',
                'Small Blue',
                'Small Copper',
                'Small Heath',
                'Small Pearl-bordered Fritillary',
                'Small Skipper',
                'Small Tortoiseshell',
                'Small White',
                'Speckled Wood',
                'Wall',
                'White Admiral',
                'White-letter Hairstreak',
                'Wood White'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )));

    final titleSelector3 = Visibility(
        visible: bird_visible,
        child: Center(
            child: Text('Select Bird species',
                style: TextStyle(color: Colors.blue, fontSize: 16.0))));

    final BirdSpeciesSelect = Visibility(
        visible: bird_visible,
        child: Padding(
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
              items: <String>['Birds']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )));

    final numberSeenButterfly = Visibility(
        visible: butterfly_visible,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextFormField(
            obscureText: false,
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
            onPressed: () async {
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.best);
              setState(() {
                dateTime = new DateTime.now().toString();
                var dateParse = DateTime.parse(dateTime);
                formattedDate =
                    "${dateParse.day}-${dateParse.month}-${dateParse.year}";
                finalDate = formattedDate.toString();
                formattedTime =
                    "${dateParse.hour}-${dateParse.minute}-${dateParse.second}";
                finalTime = formattedTime.toString();
                latitude = position.latitude.toString();
                longitude = position.longitude.toString();
              });
              await Butterfly_Sightings.add({
                'UserID': Globals.GlobalData.userID,
                'Species': SpeciesButterfly,
                'Number': Globals.GlobalData.butterflyNum,
                'Date': finalDate,
                'Time': finalTime,
                'Location': {'Latitude': latitude, 'Longitude': longitude},
              }).then((value) => print("Butterfly sighting Added")).catchError(
                  (error) => print("Failed to add butterfly sighting: $error"));
              Navigator.popUntil(context, ModalRoute.withName("/home"));
            },
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
