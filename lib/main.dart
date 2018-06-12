import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Animation/animated_page_dragger.dart';
import 'package:intro_views_flutter/Animation/page_dragger.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/pager_indicator_view_model.dart';
import 'package:intro_views_flutter/Models/slide_update.dart';
import 'package:intro_views_flutter/UI/pager_indicator.dart';
import 'package:intro_views_flutter/UI/pages.dart';
import 'Animation/page_reveal.dart';

/**
 * This is the main method of app, from here execution starts.
 */
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IntroViews Flutter',  //title of app
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),  //theme
      home: new Home(), //home page
    );
  }
}

/**
 * This is Home widget of app which is a stateful widget as its state is dynamic and updates asynchronously.
 */
class Home extends StatefulWidget {

  @override
  _HomeState createState() => new _HomeState();

}

/**
 * State of above Home widget.
 * It extends the TickerProviderStateMixin as it is used for animation control.
 */
class _HomeState extends State<Home> with TickerProviderStateMixin {

  StreamController<SlideUpdate> slideUpdateStream;  //Stream controller is used to get all the updates when user slides across screen.

  AnimatedPageDragger animatedPageDragger;  //When user stops dragging then by using this page automatically drags.

  int activeIndex = 0;  //active page index
  int nextPageIndex = 0;  //next page index
  SlideDirection slideDirection = SlideDirection.none;   //slide direction
  double slidePercent = 0.0;  //slide percentage (0.0 to 1.0)

  /**
   * Constructor
   */
  _HomeState(){
    //Stream Controller initialization
    slideUpdateStream = new StreamController<SlideUpdate>();
    //listening to updates of stream controller
    slideUpdateStream.stream.listen((SlideUpdate event){

      setState(() {     //setState is used to change the values dynamically

        //if the user is dragging then
        if(event.updateType == UpdateType.dragging){

          slideDirection = event.direction;
          slidePercent = event.slidePercent;

          //conditions on slide direction
          if(slideDirection == SlideDirection.leftToRight){
            nextPageIndex = activeIndex - 1;
          }
          else if(slideDirection == SlideDirection.rightToLeft){
            nextPageIndex = activeIndex + 1;
          }
          else{
            nextPageIndex = activeIndex;
          }

        }
        //if the user has done dragging
        else if(event.updateType == UpdateType.doneDragging){

          //Auto completion of event using Animated page dragger.
          if(slidePercent > 0.5){
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.open,  //we have to animate the open page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
          }
          else
          {
            animatedPageDragger = new AnimatedPageDragger(
              slideDirection: slideDirection,
              transitionGoal: TransitionGoal.close, //we have to close the page reveal
              slidePercent: slidePercent,
              slideUpdateStream: slideUpdateStream,
              vsync: this,
            );
            //also next page is active page
            nextPageIndex = activeIndex;
          }
          //Run the animation
          animatedPageDragger.run();

        }
        //when animating
        else if(event.updateType == UpdateType.animating){

          slideDirection = event.direction;
          slidePercent = event.slidePercent;

        }
        //done animating
        else if(event.updateType == UpdateType.doneAnimating){

          activeIndex = nextPageIndex;

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;

          //disposing the animation controller
          animatedPageDragger.dispose();

        }
      });
    });
  }

  /**
   * Build method
   */

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      //Stack is used to place components over one another.
      body: new Stack(
        children: <Widget>[
          new Page(
            pageViewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),  //Pages
          new PageReveal( //next page reveal
            revealPercent: slidePercent,
            child: new Page(
              pageViewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ), //PageReveal
          new PagerIndicator( //bottom page indicator
            viewModel: new PagerIndicatorViewModel(
                pages,
                activeIndex,
                slideDirection,
                slidePercent,
            ),
          ), //PagerIndicator
          new PageDragger( //Used for gesture control
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),//PageDragger
        ], //Widget
      ), //Stack
    );  //Scaffold
  }
}
