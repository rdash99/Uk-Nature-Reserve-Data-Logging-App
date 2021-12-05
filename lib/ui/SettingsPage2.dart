import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsRoute2 extends StatefulWidget {
  @override
  State createState() => _SettingsRouteState2();
}

class _SettingsRouteState2 extends State<SettingsRoute2> {
  Widget build(BuildContext context) {
    bool isSwitched = true;
    return SwitchSettingsTile(
      leading: Icon(Icons.developer_mode),
      settingKey: 'key-switch-dev-mode',
      title: 'Developer Settings',
      onChange: (value) {
        debugPrint('key-switch-dev-mod: $value');
      },
      childrenIfEnabled: <Widget>[
        CheckboxSettingsTile(
          leading: Icon(Icons.adb),
          settingKey: 'key-is-developer',
          title: 'Developer Mode',
          onChange: (value) {
            debugPrint('key-is-developer: $value');
          },
        ),
        SwitchSettingsTile(
          leading: Icon(Icons.usb),
          settingKey: 'key-is-usb-debugging',
          title: 'USB Debugging',
          onChange: (value) {
            debugPrint('key-is-usb-debugging: $value');
          },
        ),
        SimpleSettingsTile(
          title: 'Root Settings',
          subtitle: 'These settings is not accessible',
          enabled: false,
        )
      ],
    );
  }
}
