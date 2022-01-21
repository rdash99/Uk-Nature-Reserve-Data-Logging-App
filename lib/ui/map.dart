import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'Models/mapModel.dart';

class MapRoute extends StatefulWidget {
  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  var data = MapData().data;
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  int selectedIndex = -1;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    _mapSource = MapShapeSource.asset(
      'assets/uk3.json',
      shapeDataField: "LAD21NM",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].key,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Settings.getValue<bool>('key-test-map', false),
      child: Container(
        child: Center(
          child: SfMaps(
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
                    print(selectedIndex);
                  });
                },
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
        ),
      ),
    );
  }
}
