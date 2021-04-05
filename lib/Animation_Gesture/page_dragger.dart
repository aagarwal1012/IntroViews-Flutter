import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';

/// This class is used to get user gesture and work according to it.
class PageDragger extends StatefulWidget {
  const PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
    this.fullTransitionPX = FULL_TRANSITION_PX,
  }) : assert(fullTransitionPX != null);

  // These bool variables are used to check whether user can drag left or right or none.
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final double fullTransitionPX;

  /// Stream controller
  final StreamController<SlideUpdate> slideUpdateStream;

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;

  /// This methods executes when user starts dragging.
  void onDragStart(DragStartDetails details) {
    dragStart = details.globalPosition;
  }

  /// This methods executes while user is dragging.
  void onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      // getting new position details
      final newPosition = details.globalPosition;
      // change in position in x
      final dx = dragStart.dx - newPosition.dx;

      // predicting slide direction
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }

      // predicting slide percent
      if (slideDirection != SlideDirection.none) {
        // clamp method is used to clamp the value of slidePercent from 0.0 to 1.0,
        // after 1.0 it set to 1.0
        slidePercent = (dx / widget.fullTransitionPX).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      // adding to slideUpdateStream
      widget.slideUpdateStream.add(
        SlideUpdate(
          slideDirection,
          slidePercent,
          UpdateType.dragging,
        ),
      );
    }
  }

  /// This method executes when user ends dragging.
  void onDragEnd(DragEndDetails details) {
    // adding to slideUpdateStream
    widget.slideUpdateStream.add(
      SlideUpdate(
        SlideDirection.none,
        slidePercent,
        UpdateType.doneDragging,
      ),
    );

    // making dragStart to null for the reallocation
    dragStart = null;
  }

  @override
  Widget build(BuildContext context) {
    // gesture detector for horizontal drag
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}
