import 'package:app/ui/login_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'Sightings/add_sightings_page.dart';
import 'package:app/Page_navigation/tab_navigation_items.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeRoute extends StatefulWidget {
  @override
  State createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  bool _isVisible1 = false;
  bool _isVisible2 = true;

  //create firebase authentication instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //create new google maps instance
  /*  GoogleMapController mapContoller;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapContoller = controller; */

  @override
  Widget build(BuildContext context) {
    final menu = Column(
      children: <Widget>[
        /* ListTile(
          title: Text("Identify"),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName("/identify"));
          },
        ), */

        //log out button
        Visibility(
          visible: _isVisible1,
          child: ListTile(
            title: Text("Logout"),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
          ),
        ),

        //login button
        Visibility(
          visible: _isVisible2,
          child: ListTile(
            title: Text("Login"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginRoute()));
            },
          ),
        ),
      ],
    );

    /* if (auth.authStateChanges != null) {
      Globals.GlobalData.userID = auth.currentUser.uid;
      //print(auth.currentUser.uid);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginRoute()));
    } */
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        _isVisible2 = true;
        _isVisible1 = false;
      });
    } else {
      setState(() {
        _isVisible2 = true;
        _isVisible1 = false;
      });
    }
    /* FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        setState(() {
          _isVisible2 = true;
          _isVisible1 = false;
        });
      } else {
        setState(() {
          _isVisible2 = false;
          _isVisible1 = true;
        });
      }
    }); */

    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(FirebaseAuth.instance.currentUser.uid),
                accountEmail: Text(FirebaseAuth.instance.currentUser.email),
              ),
              menu,
            ],
          ),
        ),
        //display map
        body:
            /* GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ), */
            Text('Hello'));
  }
}
