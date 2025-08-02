import 'package:app/ui/login_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'add_sightings_page.dart';
import 'package:app/Page_navigation/tab_navigation_items.dart';
import 'package:app/Global_stuff/GlobalVars.dart' as Globals;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../database/auth_service.dart';

class HomeRoute extends StatefulWidget {
  @override
  State createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  bool _isVisible1 = false;
  bool _isVisible2 = true;
  
  final AuthService _authService = AuthService();
  String? _currentUserId;
  String? _currentUserEmail;

  //create new google maps instance
  GoogleMapController? mapContoller;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  
  void _onMapCreated(GoogleMapController controller) {
    mapContoller = controller;
  }
  
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }
  
  void _checkAuthState() async {
    final userId = await _authService.getCurrentUserId();
    if (userId != null) {
      final user = await _authService.getCurrentUser();
      setState(() {
        _currentUserId = userId;
        _currentUserEmail = user?['email'];
        _isVisible1 = true;
        _isVisible2 = false;
      });
      Globals.GlobalData.userID = userId;
    } else {
      setState(() {
        _isVisible1 = false;
        _isVisible2 = true;
      });
      // Navigate to login if not authenticated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginRoute()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final menu = Column(
      children: <Widget>[
        ListTile(
          title: Text("Identify"),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName("/identify"));
          },
        ),

        //log out button
        Visibility(
          visible: _isVisible1,
          child: ListTile(
            title: Text("Logout"),
            onTap: () async {
              await _authService.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => LoginRoute()));
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_currentUserId ?? 'Unknown User'),
              accountEmail: Text(_currentUserEmail ?? 'Unknown Email'),
            ),
            menu,
          ],
        ),
      ),
      //display map
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
