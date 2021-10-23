import 'package:app/ui/login_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpeciesRoute extends StatefulWidget {
  @override
  State createState() => _SpeciesRouteState();
}

class _SpeciesRouteState extends State<SpeciesRoute> {
  final Stream<QuerySnapshot<Map<String, dynamic>>> _butterflyStream =
      FirebaseFirestore.instance
          .collection('Species')
          .doc('Butterflies')
          .collection('Butterflies')
          .snapshots();
  @override
  Widget build(BuildContext context) {
    //return Image.network(
    //    "https://c.tenor.com/sAdUgAlKEloAAAAM/party-parrot-rgb-rainbow-dance-cool.gif");
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _butterflyStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['Eng_Name']),
                  subtitle: Text('Latin: ' + data['Latin_Name']),
                );
              }).toList(),
            );
          } else {
            return Text("No data");
          }
        });
  }
}