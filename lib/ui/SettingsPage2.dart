import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';

class SettingsRoute2 extends StatefulWidget {
  @override
  State createState() => _SettingsRouteState2();
}

class _SettingsRouteState2 extends State<SettingsRoute2> {
  Widget build(BuildContext context) {
    return SettingsScreen(title: "Application Settings", children: [
      SwitchSettingsTile(
          leading: Icon(Icons.wifi),
          settingKey: 'key-switch-network',
          title: 'Network connection',
          onChange: (value) async {
            debugPrint('key-switch-wifi-on: $value');
            if (value == false) {
              await FirebaseFirestore.instance.disableNetwork();
              print('Network disabled');
            } else {
              await FirebaseFirestore.instance.enableNetwork();
              print('Network enabled');
            }
          }),
      SwitchSettingsTile(
        leading: Icon(Icons.warning_amber),
        settingKey: 'key-switch-experimental-features',
        title: 'Enable experimental features',
        onChange: (value) async {
          debugPrint('key-switch-experimental-features: $value');
        },
        childrenIfEnabled: <Widget>[
          SwitchSettingsTile(
            leading: Icon(Icons.adb),
            settingKey: 'key-test-page',
            title: 'Test page, things in development use at your own risk',
            onChange: (value) {
              debugPrint('key-test-page: $value');
            },
          ),
          SwitchSettingsTile(
            leading: Icon(Icons.usb),
            settingKey: 'key-is-usb-debugging',
            title: 'USB Debugging',
            onChange: (value) {
              debugPrint('key-is-usb-debugging: $value');
            },
          )
        ],
      ),
    ]);
  }
}
