import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class speciesData {
  getButterflySpeciesText(String species) {
    List info = [];
    CollectionReference butterflyInfo = FirebaseFirestore.instance
        .collection('Species')
        .doc('Butterflies')
        .collection('Butterflies');

    return FutureBuilder<DocumentSnapshot>(builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError || !snapshot.hasData) {}
      if (snapshot.hasData &&
          snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        info.add("English Name: " + data['Eng_Name']);
      }
    });
  }
}
