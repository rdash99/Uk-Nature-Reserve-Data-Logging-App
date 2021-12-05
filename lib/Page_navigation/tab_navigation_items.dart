import 'package:app/ui/SettingsPage.dart';
import 'package:app/ui/SettingsPage2.dart';
import 'package:app/ui/Sightings/add_sightings_page.dart';
import 'package:app/ui/Sightings/edit_sightings_page.dart';
import 'package:app/ui/home_route.dart';
import 'package:app/ui/identification_route.dart';
import 'package:app/ui/login_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/ui/test_page.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;
  final bool visible;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
    required this.visible,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: HomeRoute(),
            title: "Home",
            icon: Icon(Icons.home, color: Colors.black),
            visible: true),
        TabNavigationItem(
            page: AddSightingsRoute(),
            title: "Add a sighting",
            icon: Icon(Icons.add_circle, color: Colors.black),
            visible: true),
        TabNavigationItem(
            page: TestRoute(),
            title: "Test",
            icon: Icon(Icons.edit, color: Colors.black),
            visible: Settings.getValue<bool>(
                'key-switch-experimental-features', false)),
        TabNavigationItem(
            page: IdentificationRoute(),
            title: "Identification",
            icon: Icon(Icons.search, color: Colors.black),
            visible: true),
        TabNavigationItem(
            page: SettingsRoute2(),
            title: "Settings",
            icon: Icon(Icons.settings, color: Colors.black),
            visible: true),
      ];
}
