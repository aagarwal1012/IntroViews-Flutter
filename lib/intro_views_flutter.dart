library intro_views_flutter;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Animation_Gesture/animated_page_dragger.dart';
import 'package:intro_views_flutter/Animation_Gesture/page_dragger.dart';
import 'package:intro_views_flutter/Animation_Gesture/page_reveal.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/Models/pager_indicator_view_model.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';
import 'package:intro_views_flutter/UI/page_indicator_buttons.dart';
import 'package:intro_views_flutter/UI/pager_indicator.dart';
import 'package:intro_views_flutter/UI/page.dart';

/// This is the IntroViewsFlutter widget of app which is a stateful widget as its state is dynamic and updates asynchronously.
class IntroViewsFlutter extends StatefulWidget {
  final List<PageViewModel> pages;
  final VoidCallback onTapDoneButton;
  final Color pageButtonsColor;
  final bool showSkipButton;
  final double pageButtonTextSize;
  final String pageButtonFontFamily;

  /// Override 'DONE' Text with Your Own Text, its TextStyle will be copied and override [pageButtonTextSize] [PageButtonFontFamily] [PageButtonsColor]
  final Text done;

  /// Override 'Skip' Text with Your Own Text, its TextStyle will be copied and override [pageButtonTextSize] [PageButtonFontFamily] [PageButtonsColor]
  final Text skip;

  IntroViewsFlutter(
    this.pages, {
    Key key,
    this.onTapDoneButton,
    this.pageButtonsColor = const Color(0x88FFFFF),
    this.showSkipButton = true,
    this.pageButtonTextSize = 18.0,
    this.pageButtonFontFamily,
    this.done,
    this.skip,
  }) : super(key: key);

  @override
  _IntroViewsFlutterState createState() => new _IntroViewsFlutterState();
}

/// State of above widget.
/// It extends the TickerProviderStateMixin as it is used for animation control (vsync).

class _IntroViewsFlutterState extends State<IntroViewsFlutter>
    with TickerProviderStateMixin {
  StreamController<SlideUpdate>
      // ignore: close_sinks
      slideUpdateStream; //Stream controller is used to get all the updates when user slides across screen.

  AnimatedPageDragger
      animatedPageDragger; //When user stops dragging then by using this page automatically drags.

  int activePageIndex = 0; //active page index
  int nextPageIndex = 0; //next page index
  SlideDirection slideDirection = SlideDirection.none; //slide direction
  double slidePercent = 0.0; //slide percentage (0.0 to 1.0)

  /// Constructor
  _IntroViewsFlutterState() {
    //Stream Controller initialization
    slideUpdateStream = new StreamController<SlideUpdate>();
    //listening to updates of stream controller
    slideUpdateStream.stream.listen((SlideUpdate event) {
      setState(() {
        //setState is used to change the values dynamically

        //if the user is dragging then
        if (event.updateType == UpdateType.dragging) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          //conditions on slide direction
          if (slideDirection == SlideDirection.leftToRight) {
            nextPageIndex = activePageIndex - 1;
          } else if (slideDirection == SlideDirection.rightToLeft) {
            nextPageIndex = activePageIndex + 1;
          } else {
            nextPageIndex = activePageIndex;
          }
        }
        //if the user has done dragging
        else if (event.updateType == UpdateType.doneDragging) {
          //Auto completion of event using Animated page dragger.
          if (slidePercent > 0.5) {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal:
                  TransitionGoal.open, //we have to animate the open page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          } else {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal:
                  TransitionGoal.close, //we have to close the page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            //also next page is active page
            nextPageIndex = activePageIndex;
          }
          //Run the animation
          animatedPageDragger.run();
        }
        //when animating
        else if (event.updateType == UpdateType.animating) {
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
        }
        //done animating
        else if (event.updateType == UpdateType.doneAnimating) {
          activePageIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          //disposing the animation controller
          animatedPageDragger.dispose();
        }
      });
    });
  }

  /// Build method

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = widget.pages;

    return new Scaffold(
      //Stack is used to place components over one another.
      body: new Stack(
        children: <Widget>[
          new Page(
            pageViewModel: pages[activePageIndex],
            percentVisible: 1.0,
          ), //Pages
          new PageReveal(
            //next page reveal
            revealPercent: slidePercent,
            child: new Page(
              pageViewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ), //PageReveal

          new PagerIndicator(
            //bottom page indicator
            viewModel: new PagerIndicatorViewModel(
              pages,
              activePageIndex,
              slideDirection,
              slidePercent,
            ),
          ), //PagerIndicator
          new PageIndicatorButtons(
            //Skip and Done Buttons
            acitvePageIndex: activePageIndex,
            totalPages: pages.length,
            onPressedDoneButton: widget
                .onTapDoneButton, //void Callback to be executed after pressing done button
            slidePercent: slidePercent,
            slideDirection: slideDirection,
            onPressedSkipButton: () {
              //method executed on pressing skip button
              setState(() {
                activePageIndex = pages.length - 1;
                nextPageIndex = activePageIndex;
              });
            },
            pageButtonTextSize: widget.pageButtonTextSize,
            pageButtonsColor: widget.pageButtonsColor,
            showSkipButton: widget.showSkipButton,
            fontFamily: widget.pageButtonFontFamily,
            done: widget.done,
            skip: widget.skip,
          ),
          new PageDragger(
            //Used for gesture control
            canDragLeftToRight: activePageIndex > 0,
            canDragRightToLeft: activePageIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ), //PageDragger
        ], //Widget
      ), //Stack
    ); //Scaffold
  }
}
