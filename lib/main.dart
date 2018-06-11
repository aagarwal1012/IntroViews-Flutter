import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/pager_indicator_view_model.dart';
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Page(
              pageViewModel: pages[0],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: 1.0,
            child: new Page(
              pageViewModel: pages[1],
              percentVisible: 1.0,
            ),
          ),
          new PagerIndicator(
            viewModel: new PagerIndicatorViewModel(
                pages, 1, SlideDirection.none, 0.0,
            ),
          ),
        ],
      ),

    );
  }
}
