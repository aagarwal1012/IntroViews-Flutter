import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';

class AnimatedPageDragger{
  static const PERCENT_PER_MILLISECOND = 0.005;

  final slideDirection;
  final transitionGoal;

  AnimationController completionAnimationController;

  AnimatedPageDragger({
    this.slideDirection,
    this.transitionGoal,
    slidePercent,
    StreamController<SlideUpdate> slideUpdateStream,
    TickerProvider vsync,
  }){
    final startSlidePercent = slidePercent;
    var endSlidePercent;
    var duration;

    if(transitionGoal == TransitionGoal.open){
      endSlidePercent = 1.0;
      final slideRemaining = 1.0 - slidePercent;
      duration = new Duration(
        milliseconds: (slideRemaining / PERCENT_PER_MILLISECOND).round()
      );
    }
    else{
      endSlidePercent = 0.0;
      duration = new Duration(
        milliseconds: (slidePercent / PERCENT_PER_MILLISECOND).round()
      );
    }



    completionAnimationController = new AnimationController(
      duration: duration,
        vsync: vsync)
    ..addListener((){

        final slidePercent = lerpDouble(startSlidePercent, endSlidePercent,
            completionAnimationController.value);

        slideUpdateStream.add(
          new SlideUpdate(slideDirection, slidePercent, UpdateType.animating)
        );
    })
    ..addStatusListener((AnimationStatus status){
      if(status == AnimationStatus.completed){
        slideUpdateStream.add(
            new SlideUpdate(slideDirection, slidePercent, UpdateType.doneAnimating)
        );
      }
    });
  }

  run(){
    completionAnimationController.forward(from: 0.0);
  }
  dispose(){
    completionAnimationController.dispose();
  }
}

enum TransitionGoal{
  open,
  close,
}