import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Animation/page_dragger.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/pager_indicator_view_model.dart';
import 'package:intro_views_flutter/Models/slide_update.dart';
import 'package:intro_views_flutter/UI/pager_indicator.dart';
import 'package:intro_views_flutter/UI/pages.dart';
import 'Animation/page_reveal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IntroViews Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  StreamController<SlideUpdate> slideUpdateStream;

  int activeIndex = 0;
  int nextPageIndex = 0;
  SlideDirection slideDirection = SlideDirection.none;
  double slidePercent = 0.0;

  _MyHomePageState(){
    slideUpdateStream = new StreamController<SlideUpdate>();
    slideUpdateStream.stream.listen((SlideUpdate event){
      setState(() {
        if(event.updateType == UpdateType.dragging){
          slideDirection = event.direction;
          slidePercent = event.slidePercent;
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
        else if(event.updateType == UpdateType.doneDragging){

          if(slidePercent > 0.5){
            activeIndex = slideDirection == SlideDirection.leftToRight
                ? activeIndex - 1 : activeIndex + 1;
          }

          slideDirection = SlideDirection.none;
          slidePercent = 0.0;
        }
        slideDirection = event.direction;
        slidePercent = event.slidePercent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Page(
            pageViewModel: pages[activeIndex],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: slidePercent,
            child: new Page(
              pageViewModel: pages[nextPageIndex],
              percentVisible: slidePercent,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
                pages,
                activeIndex,
                slideDirection,
                slidePercent,
            ),
          ),
          new PageDragger(
            canDragLeftToRight: activeIndex > 0,
            canDragRightToLeft: activeIndex < pages.length - 1,
            slideUpdateStream: this.slideUpdateStream,
          ),
        ],
      ),

    );
  }
}
