import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsRoute extends StatefulWidget {
  @override
  State createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  Widget build(BuildContext context) {
    bool value = false;
    return SettingsList(
      sections: [
        SettingsSection(
          title: 'Test',
          tiles: [
            SettingsTile(
              title: 'Wombat',
              subtitle: 'Combat',
              leading: Icon(Icons.language, color: Colors.black),
              onPressed: (BuildContext context) {},
            ),
            SettingsTile.switchTile(
                title: 'Fingers?',
                leading: Icon(Icons.fingerprint, color: Colors.black),
                switchValue: value,
                onToggle: (bool value) {
                  //todo set value method
                }),
          ],
        )
      ],
    );
  }
}
