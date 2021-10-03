import 'package:app/Page_navigation/tabs_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddSightingsRoute extends StatefulWidget {
  @override
  State createState() => _AddSightingsRouteState();
}

class _AddSightingsRouteState extends State<AddSightingsRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final geo = Geoflutterfire();
  String eng_Name;
  String latin_Name;
  var location;
  bool bird_visible = false;
  bool butterfly_visible = true;
  var dropdownValueButterflies = 'Butterflies';
  var dropdownValueButterflies1 = 'Adonis Blue';
  var dropdownValueButterflies2 = 'Birds';
  var UserID = Globals.GlobalData.userID;
  var SpeciesButterfly = 'test';
  var dateTime = '';
  var formattedDate = '';
  var finalDate = '';
  var formattedTime = '';
  var finalTime = '';
  var latitude = '';
  var longitude = '';
  var geoPoint = '';
  bool butterfly_number_error = false;

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

    final titleSelector1 = Center(
        child: Text('Select animal group',
            style: TextStyle(color: Colors.blue, fontSize: 16.0)));

    final SelectionOptions = Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButtonFormField(
          value: dropdownValueButterflies,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.blue),
          onChanged: (String newValue) {
            setState(() {
              dropdownValueButterflies = newValue;
              Globals.GlobalData.butterBird = dropdownValueButterflies;
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

    //title 2
    final titleSelector2 = Visibility(
        visible: butterfly_visible,
        child: Center(
            child: Text('Select butterfly species',
                style: TextStyle(color: Colors.blue, fontSize: 16.0))));

    //butterfly species selection dropdown
    final ButterflySpeciesSelect = Visibility(
        visible: butterfly_visible,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField(
              value: dropdownValueButterflies1,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueButterflies1 = newValue;
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

    //bird species title - not displayed
    final titleSelector3 = Visibility(
        visible: bird_visible,
        child: Center(
            child: Text('Select Bird species',
                style: TextStyle(color: Colors.blue, fontSize: 16.0))));

    //Bird species selection - not implemented
    final BirdSpeciesSelect = Visibility(
        visible: bird_visible,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField(
              value: dropdownValueButterflies2,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueButterflies2 = newValue;
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

    //input number of butterflies seen
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
              //convert text into integer and perform validation
              var number = int.parse(text);
              if (number > 0) {
                setState(() {
                  Globals.GlobalData.butterflyNum = number;
                  butterfly_number_error = false;
                });
              } else {
                setState(() {
                  butterfly_number_error = true;
                });
              }
            },
          ),
        ));

    //butterfly number input error
    final numberErrorButterfly = Visibility(
        visible: butterfly_number_error,
        child: Center(
            child: Text('Please enter a positive number',
                style: TextStyle(color: Colors.red, fontSize: 16.0))));

    //numbers of birds input - not implemented
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

    //submit bird sighting - not implemented
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

    //submit butterfly sighting
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
              //get location
              Position position = await Geolocator.getCurrentPosition(
                  desiredAccuracy: LocationAccuracy.best);
              setState(() {
                //get current date and time
                dateTime = new DateTime.now().toString();
                //process date and time
                var dateParse = DateTime.parse(dateTime);
                formattedDate =
                    "${dateParse.day}-${dateParse.month}-${dateParse.year}";
                finalDate = formattedDate.toString();
                formattedTime =
                    "${dateParse.hour}-${dateParse.minute}-${dateParse.second}";
                finalTime = formattedTime.toString();
                //process location
                latitude = position.latitude.toString();
                longitude = position.longitude.toString();
              });
              //create geoPoint
              GeoFirePoint geoPoint = geo.point(
                  latitude: position.latitude, longitude: position.longitude);

              //submit sighting
              await Butterfly_Sightings.add({
                'UserID': Globals.GlobalData.userID,
                'Species': SpeciesButterfly,
                'Number': Globals.GlobalData.butterflyNum,
                'Date': finalDate,
                'Time': finalTime,
                'Location': {'Latitude': latitude, 'Longitude': longitude},
                'LocationGeoPoint': geoPoint.data,
              })
                  .then((value) => Alert(
                        context: context,
                        type: AlertType.success,
                        title: 'Success',
                        desc: 'Sighting added sucessfully.',
                        buttons: [
                          DialogButton(
                            child: Text("Go back to the home page",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabsPage()))
                            },
                            padding: const EdgeInsets.all(16.0),
                            //width: 120,
                            height: 120,
                          )
                        ],
                      ).show())
                  .catchError((error) => Alert(
                        context: context,
                        type: AlertType.error,
                        title: 'Error',
                        desc: 'Sighting not added due to $error',
                        buttons: [
                          DialogButton(
                            child: Text("Go back to the home page",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TabsPage()))
                            },
                            padding: const EdgeInsets.all(16.0),
                            //width: 120,
                            height: 60,
                          )
                        ],
                      ).show());
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
            numberErrorButterfly,
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
