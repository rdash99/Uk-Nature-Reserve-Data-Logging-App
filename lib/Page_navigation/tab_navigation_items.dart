import 'package:app/ui/Sightings/add_sightings_page.dart';
import 'package:app/ui/Sightings/edit_sightings_page.dart';
import 'package:app/ui/home_route.dart';
import 'package:app/ui/identification_route.dart';
import 'package:app/ui/login_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/ui/test_page.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    required this.page,
    required this.title,
    required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: HomeRoute(),
            title: "Home",
            icon: Icon(Icons.home, color: Colors.black)),
        TabNavigationItem(
            page: AddSightingsRoute(),
            title: "Add a sighting",
            icon: Icon(Icons.add_circle, color: Colors.black)),
        TabNavigationItem(
            page: TestRoute(),
            title: "Test",
            icon: Icon(Icons.edit, color: Colors.black)),
        TabNavigationItem(
            page: IdentificationRoute(),
            title: "Identification",
            icon: Icon(Icons.search, color: Colors.black)),
      ];
}
