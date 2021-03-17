import 'package:app/ui/Sightings/add_sightings_page.dart';
import 'package:app/ui/Sightings/edit_sightings_page.dart';
import 'package:app/ui/home_route.dart';
import 'package:app/ui/login_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
            page: HomeRoute(), title: "Home", icon: Icon(Icons.home)),
        TabNavigationItem(
            page: AddSightingsRoute(),
            title: "Add a sighting",
            icon: Icon(Icons.add_circle)),
        TabNavigationItem(
            page: EditSightingsRoute(),
            title: "Edit sightings",
            icon: Icon(Icons.edit)),
      ];
}
