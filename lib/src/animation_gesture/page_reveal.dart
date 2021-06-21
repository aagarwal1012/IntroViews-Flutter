import 'package:flutter/material.dart';
import 'package:intro_views_flutter/src/clipper/circular_reveal_clipper.dart';

/// This class reveals the next page in the circular form.
class PageReveal extends StatelessWidget {
  const PageReveal({
    Key? key,
    required this.revealPercent,
    required this.child,
  }) : super(key: key);

  final double revealPercent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // ClipOval cuts the page to circular shape.
    return ClipOval(
      clipper: CircularRevealClipper(revealPercent: revealPercent),
      child: child,
    );
  }
}
