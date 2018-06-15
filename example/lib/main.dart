import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

/**
 * This is the main method of app, from here execution starts.
 */
void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IntroViews Flutter',  //title of app
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),  //theme
      home: new IntroViewsFlutter(), //home page
    );
  }
}