import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';

/// This class is used to get user gesture and work according to it.

class PageDragger extends StatefulWidget {
  //These bool variables are used to check whether user can drag left or right or none.
  final bool canDragLeftToRight;
  final bool canDragRightToLeft;
  final double fullTransitionPX;
  //Stream controller
  final StreamController<SlideUpdate> slideUpdateStream;

  //Constructor
  PageDragger({
    this.canDragLeftToRight,
    this.canDragRightToLeft,
    this.slideUpdateStream,
    this.fullTransitionPX = FULL_TARNSITION_PX,
  }) : assert(fullTransitionPX != null);

  @override
  _PageDraggerState createState() => _PageDraggerState();
}

class _PageDraggerState extends State<PageDragger> {
  //Variables
  Offset dragStart;
  SlideDirection slideDirection;
  double slidePercent = 0.0;
  Duration startDragDuration;

  // This methods executes when user starts dragging.
  onDragStart(DragStartDetails details) {
    startDragDuration = details.sourceTimeStamp;
    dragStart = details.globalPosition;
  }

  // This methods executes while user is dragging.
  onDragUpdate(DragUpdateDetails details) {
    if (dragStart != null) {
      Duration dragDuration = details.sourceTimeStamp - startDragDuration;
      //Getting new position details
      final newPosition = details.globalPosition;
      //Change in position in x
      final dx = dragStart.dx - newPosition.dx;
      var deltaSpeed = details.delta.dx.abs() / dragDuration.inMilliseconds ?? 1.0;
      //predicting slide direction
      if (dx > 0.0 && widget.canDragRightToLeft) {
        slideDirection = SlideDirection.rightToLeft;
      } else if (dx < 0.0 && widget.canDragLeftToRight) {
        slideDirection = SlideDirection.leftToRight;
      } else {
        slideDirection = SlideDirection.none;
      }
      //predicting slide percent
      if (slideDirection != SlideDirection.none) {
        //clamp method is used to clamp the value of slidePercent from 0.0 to 1.0, after 1.0 it set to 1.0
        var fullPositionPx = widget.fullTransitionPX - deltaSpeed * 20;
        slidePercent = (dx / fullPositionPx).abs().clamp(0.0, 1.0);
      } else {
        slidePercent = 0.0;
      }

      // Adding to slideUpdateStream
      widget.slideUpdateStream
          .add(SlideUpdate(slideDirection, slidePercent, UpdateType.dragging));
    }
  }

  // This method executes when user ends dragging.
  onDragEnd(DragEndDetails details) {
    widget.slideUpdateStream.add(SlideUpdate(
        SlideDirection.none, slidePercent, UpdateType.doneDragging));

    //Making dragStart to null for the reallocation
    dragStart = null;
  }

  _onTap() {
    if (widget.canDragRightToLeft){
      widget.slideUpdateStream.add(SlideUpdate(SlideDirection.rightToLeft, 0.0, UpdateType.nextPage));
    }
  }


  @override
  Widget build(BuildContext context) {
    //Gesture Detector for horizontal drag
    return GestureDetector(
      onHorizontalDragStart: onDragStart,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      onTap: _onTap,
    );
  }
}
