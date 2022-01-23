import 'dart:async';

import 'package:app/ui/Models/markerModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Settings;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'Models/mapModel.dart';

class MapRoute extends StatefulWidget {
  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  final geo = Geoflutterfire();
  var data = MapData().data;
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  int selectedIndex = -1;
  late MapShapeLayerController _mapController;
  List<markerModel> _markerList = [];

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    _mapController = MapShapeLayerController();
    _mapSource = MapShapeSource.asset(
      'assets/uk3.json',
      shapeDataField: "LAD21NM",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].key,
    );

    super.initState();
  }

  Stream<QuerySnapshot> butterflyStream =
      FirebaseFirestore.instance.collection('Butterfly_Sightings').snapshots();
  getData() {
    StreamSubscription<QuerySnapshot> butterflySubscription =
        butterflyStream.listen((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        Map<String, dynamic> data = f.data()! as Map<String, dynamic>;
        _markerList.add(markerModel(double.parse(data["Location"]["Latitude"]),
            double.parse(data["Location"]["Longitude"])));
        _mapController.insertMarker(_markerList.indexOf(_markerList.last));
        //print(f.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Visibility(
      visible: Settings.getValue<bool>('key-test-map', false),
      child: Column(
        children: [
          SfMaps(
            layers: [
              MapShapeLayer(
                source: _mapSource,
                zoomPanBehavior: _zoomPanBehavior,
                selectedIndex: selectedIndex,
                onSelectionChanged: (int index) {
                  setState(() {
                    if (selectedIndex == index) {
                      selectedIndex = -1;
                    } else {
                      selectedIndex = index;
                    }
                    //print(selectedIndex);
                  });
                },
                initialMarkersCount: 0,
                markerBuilder: (BuildContext context, int index) {
                  return MapMarker(
                    latitude: _markerList[index].lat,
                    longitude: _markerList[index].lng,
                    child: Icon(Icons.add_location),
                  );
                },
                controller: _mapController,
                loadingBuilder: (BuildContext context) {
                  return Container(
                    height: 25,
                    width: 25,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  );
                },
              ),
            ],
          ),
          ElevatedButton(
            child: Text('Update markers'),
            onPressed: () {
              setState(() {
                _markerList.clear();
                _mapController.clearMarkers();
                getData();
              });
            },
          )
        ],
      ),
    ));
  }
}

class markerModel {
  markerModel(this.lat, this.lng);
  final double lat;
  final double lng;
}
