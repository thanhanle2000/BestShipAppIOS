import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  String route;
  NavigationModel(
      {required this.title, required this.icon, required this.route});
}

List<NavigationModel> navItems = [
  NavigationModel(
    title: 'Profile',
    icon: Icons.person,
    route: 'profile',
  ),
  NavigationModel(
    title: 'Settings',
    icon: Icons.settings,
    route: 'settings',
  ),
];

final TextStyle navItemStyle = TextStyle(fontSize: 18, color: Colors.black);

final TextStyle navItemSelectedStyle =
    TextStyle(fontSize: 18, color: Colors.white);
