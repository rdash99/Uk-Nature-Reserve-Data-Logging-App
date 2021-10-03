import 'package:app/Page_navigation/tabs_page.dart';
//import 'package:app/ui/Sightings/models/sighting.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:geolocator/geolocator.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EditSightingsRoute extends StatefulWidget {
  @override
  State createState() => _EditSightingsRouteState();
}

class _EditSightingsRouteState extends State<EditSightingsRoute> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final geo = Geoflutterfire();

  var userid = FirebaseAuth.instance.currentUser.uid;

  CollectionReference butterfly_sightings =
      FirebaseFirestore.instance.collection('Butterfly_Sightings');

  bool Selection = true;
  var dropdownValue1 = 'Adonis Blue';
  var SpeciesButterfly = 'Adonis Blue';
  final List items = new List();

  @override
  Widget build(BuildContext context) {
    final Selection_box = Visibility(
        visible: Selection,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField(
              value: dropdownValue1,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.blue),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue1 = newValue;
                  SpeciesButterfly = newValue;
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

    /* final display = StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Butterfly_Sightings')
          .where('UserID', isEqualTo: Globals.GlobalData.userID)
          .where("Species", isEqualTo: SpeciesButterfly)
          .snapshots(),
      initialData: items,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            width: 200,
            height: 500,
            child: ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot sightings = snapshot.data.docs[index];
                setState(() {
                  var name = sightings['Species'];
                  var date = sightings['Date'];
                  var time = sightings['Time'];
                  int num = sightings['Number'];
                  items.add(Sighting(name, date, time, num));
                });
              },
            ));
      },
    ); */

    final list = Visibility(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              return ListTile(
                title: Text('${items[position].body}'),
              );
            }));

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: ListView(
          children: [
            Selection_box,
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Butterfly_Sightings')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView(
                    children: snapshot.data.docs.map((document) {
                      return Center(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.height / 6,
                            child: Text("Date: " + document['Date'])),
                      );
                    }).toList(),
                  );
                })
          ],
        )));
  }
}
