import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Clipper/circular_reveal_clipper.dart';
import 'package:intro_views_flutter/Constants/constants.dart';

/// This class reveals the next page in the circular form.

class PageReveal extends StatelessWidget {
  final RevealPosition revealPosition;
  final double revealPercent;
  final Widget child;
  final SlideDirection slideDirection;

  //Constructor
  PageReveal({this.revealPercent, this.child, this.slideDirection,this.revealPosition});

  @override
  Widget build(BuildContext context) {
    //ClipOval cuts the page to circular shape.
    return new ClipOval(
      clipper: new CircularRevealClipper(revealPercent: revealPercent,slideDirection:slideDirection,revealPosition:revealPosition),
      child: child,
    );
  }
}
