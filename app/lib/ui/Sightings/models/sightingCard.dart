import 'package:flutter/material.dart';

class SightingCard extends StatefulWidget {
  final String serviceIcon;
  final String serviceTitle;
  final String serviceDescription;
  final String serviceLink;
  final double cardWidth;
  final double cardHeight;

  const SightingCard(
      {required this.serviceIcon,
      required this.serviceTitle,
      required this.serviceDescription,
      required this.serviceLink,
      required this.cardHeight,
      required this.cardWidth});

  @override
  _SightingCardState createState() => _SightingCardState();
}

class _SightingCardState extends State<SightingCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return Text("You shouldn't be here.");
  }
}
