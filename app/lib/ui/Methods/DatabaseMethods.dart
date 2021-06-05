import 'package:app/Page_navigation/tabs_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> storeButterfly(
    String Species, Number, Date, Time, lat, long, Point) async {
  BuildContext context;
  User user = FirebaseAuth.instance.currentUser;
  var uid = user.uid;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  var ref = fire.collection('Butterfly_Sightings');
  try {
    await ref.add({
      'UserID': uid,
      'Species': Species,
      'Number': Number,
      'Date': Date,
      'Time': Time,
      'Location': {'Latitude': lat, 'Longitude': long},
      'LocationGeoPoint': Point.data,
    });
    return Alert(
      context: context,
      type: AlertType.success,
      title: 'Success',
      desc: 'Sighting added sucessfully.',
      buttons: [
        DialogButton(
          child: Text("Go back to the home page",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()))
          },
          padding: const EdgeInsets.all(16.0),
          //width: 120,
          height: 120,
        )
      ],
    ).show();
  } catch (error) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: 'Error',
      desc: 'Sighting not added due to $error',
      buttons: [
        DialogButton(
          child: Text("Go back to the home page",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()))
          },
          padding: const EdgeInsets.all(16.0),
          //width: 120,
          height: 60,
        )
      ],
    ).show();
  }
}

Future<void> storeBird(
    String Species, Number, Date, Time, lat, long, Point) async {
  BuildContext context;
  User user = FirebaseAuth.instance.currentUser;
  var uid = user.uid;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  var ref = fire.collection('Bird_Sightings');
  try {
    await ref.add({
      'UserID': uid,
      'Species': Species,
      'Number': Number,
      'Date': Date,
      'Time': Time,
      'Location': {'Latitude': lat, 'Longitude': long},
      'LocationGeoPoint': Point.data,
    });
    return Alert(
      context: context,
      type: AlertType.success,
      title: 'Success',
      desc: 'Sighting added sucessfully.',
      buttons: [
        DialogButton(
          child: Text("Go back to the home page",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()))
          },
          padding: const EdgeInsets.all(16.0),
          //width: 120,
          height: 120,
        )
      ],
    ).show();
  } catch (error) {
    return Alert(
      context: context,
      type: AlertType.error,
      title: 'Error',
      desc: 'Sighting not added due to $error',
      buttons: [
        DialogButton(
          child: Text("Go back to the home page",
              style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => TabsPage()))
          },
          padding: const EdgeInsets.all(16.0),
          //width: 120,
          height: 60,
        )
      ],
    ).show();
  }
}
