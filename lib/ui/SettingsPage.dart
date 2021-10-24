import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsRoute extends StatefulWidget {
  @override
  State createState() => _SettingsRouteState();
}

class _SettingsRouteState extends State<SettingsRoute> {
  Widget build(BuildContext context) {
    bool isSwitched = true;
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
                title: 'Internet connection',
                leading: Icon(Icons.wifi, color: Colors.black),
                switchValue: isSwitched,
                onToggle: (bool value) async {
                  if (value == true) {
                    await FirebaseFirestore.instance.enableNetwork();
                  } else if (isSwitched = value) {
                    await FirebaseFirestore.instance.disableNetwork();
                  }

                  print(value);
                  setState(() {
                    value = !value;
                  });
                }),
          ],
        )
      ],
    );
  }
}
