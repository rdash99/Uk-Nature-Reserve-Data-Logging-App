import 'package:flutter/material.dart';

class SightingCard extends StatefulWidget {
  final String serviceIcon;
  final String serviceTitle;
  final String serviceDescription;
  final String serviceLink;
  final double cardWidth;
  final double cardHeight;

  const SightingCard(
      {@required this.serviceIcon,
      this.serviceTitle,
      this.serviceDescription,
      this.serviceLink,
      this.cardHeight,
      this.cardWidth});

  @override
  _SightingCardState createState() => _SightingCardState();
}

class _SightingCardState extends State<SightingCard> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {}
}
