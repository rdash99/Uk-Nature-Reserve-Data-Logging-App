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
  @override
  Widget build(BuildContext context) {
    final SelectionOptions = Padding(
        padding: const EdgeInsets.all(16.0),
        child: DropdownButton(
          value: Globals.GlobalData.dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          onChanged: (String newValue) {
            setState(() {
              Globals.GlobalData.dropdownValue = newValue;
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
  }
}

final SubmitButton = Visibility(
    visible: Globals.GlobalData.add_visible,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: MaterialButton(
        minWidth: 200.0,
        height: 48.0,
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        color: Colors.blue,
      ),
    ));
