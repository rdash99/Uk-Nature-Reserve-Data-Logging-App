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

  @override
  Widget build(BuildContext context) {
/*     return StreamBuilder<QuerySnapshot>(
      stream: butterfly_sightings
          .where(
            'UserId', = userid
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {},
    );
    butterfly_sightings.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }
} */
  }
}
