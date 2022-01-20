import 'package:syncfusion_flutter_maps/maps.dart';
/* import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/material.dart';

late List<Model> data;
late MapShapeSource _mapSource;

@override
void initState() {
  data = <Model>[
    Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
        '       New\nSouth Wales'),
    Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
    Model('Northern Territory', Colors.red.withOpacity(0.85),
        'Northern\nTerritory'),
    Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
    Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
        'South Australia'),
    Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
        'Western Australia'),
    Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
    Model('Australian Capital Territory', Colors.teal, 'ACT')
  ];

  _mapSource = MapShapeSource.asset(
    'assets/australia.json',
    shapeDataField: 'STATE_NAME',
    dataCount: data.length,
    primaryValueMapper: (int index) => data[index].state,
    dataLabelMapper: (int index) => data[index].stateCode,
    shapeColorValueMapper: (int index) => data[index].color,
  );
  super.initState();
}

@override
Widget build(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  return Scaffold(
    body: Container(
      height: 520,
      child: Center(
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: _mapSource,
              legend: MapLegend(MapElement.shape),
              showDataLabels: true,
              shapeTooltipBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(7),
                  child: Text(data[index].stateCode,
                      style: themeData.textTheme.caption!
                          .copyWith(color: themeData.colorScheme.surface)),
                );
              },
              tooltipSettings: MapTooltipSettings(
                  color: Colors.grey[700],
                  strokeColor: Colors.white,
                  strokeWidth: 2),
              strokeColor: Colors.white,
              strokeWidth: 0.5,
              dataLabelSettings: MapDataLabelSettings(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: themeData.textTheme.caption!.fontSize)),
            ),
          ],
        ),
      ),
    ),
  );
}

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}
 */
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class MapRoute extends StatefulWidget {
  @override
  _MapRouteState createState() => _MapRouteState();
}

class _MapRouteState extends State<MapRoute> {
  late MapShapeSource _mapSource;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = MapZoomPanBehavior();
    _mapSource = MapShapeSource.asset(
      'assets/gb.json',
      shapeDataField: 'features',
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
