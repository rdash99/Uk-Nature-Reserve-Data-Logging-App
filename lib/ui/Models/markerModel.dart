import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/map.dart';

class markerModel {
  markerModel(this.lat, this.lng);
  final double lat;
  final double lng;
}

class markerData {
  static getData() {
    Stream<QuerySnapshot> butterflyStream = FirebaseFirestore.instance
        .collection('Butterfly_Sightings')
        .snapshots();
    StreamSubscription<QuerySnapshot> butterflySubscription =
        butterflyStream.listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        //print(f.data()!['Latitude'] + f.data()['Longitude']);
      });
    });
  }

  /* var stream = StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _butterflyStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              if (snapshot.hasData) {
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
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
            }); */
}
