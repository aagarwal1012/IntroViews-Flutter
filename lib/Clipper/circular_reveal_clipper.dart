import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';

/// Custom clipper for circular page reveal.

class CircularRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;
  final SlideDirection slideDirection;
  final RevealPosition revealPosition;


  CircularRevealClipper({this.revealPercent,this.slideDirection,this.revealPosition});

  @override
  Rect getClip(Size size) {
    // center of rectangle
//    final center = new Offset(size.width / 2, size.height * 0.9);
//    final center = new Offset(size.width / 2, size.height * 0.9);
    Offset center;
    double theta;

    switch(this.revealPosition){
      case RevealPosition.bottom:
        center = new Offset(size.width / 2, size.height * 0.9);
        theta = atan(center.dy / center.dx);
        break;
      case RevealPosition.GestureDirection:
        center = this.slideDirection == SlideDirection.leftToRight ?
          Alignment.centerLeft.alongSize(size) : Alignment.centerRight.alongSize(size);
        theta = atan(center.dy / Alignment.center.alongSize(size).dx) * 0.40;
        break;
      default:
        center = new Offset(size.width / 2, size.height * 0.9);
        theta = atan(center.dy / center.dx);
    }
    // Calculate distance from center to the top left corner to make sure we fill the screen via simple trigonometry.
    final distanceToCorner = center.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return new Rect.fromLTWH(
        center.dx - radius, center.dy - radius, diameter, diameter);

//    final Offset center = Alignment.centerRight.alongSize(size) ;
//    final minRadius = this.minRadius ?? 0;
//    final maxRadius = this.maxRadius ?? calcMaxRadius(size, center);
//
//    return Path()
//      ..addOval(
//        Rect.fromCircle(
//          center: center,
//          radius: lerpDouble(minRadius, maxRadius, fraction),
//        ),
//      );
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
