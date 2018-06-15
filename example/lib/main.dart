import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

/**
 * This is the main method of app, from here execution starts.
 */
void main() => runApp(new App());

class App extends StatelessWidget {
  // This widget is the root of your application.

  final pages = [
    new PageViewModel(
      pageColor: const Color(0xFF678FB4),
      mainImageAssetPath: '',
      title: 'Hotels',
      body: 'All hotels and hostels are sorted by hospitality rating',
      iconImageAssetPath: '',
      titleTextColor: Colors.white,
      bodyTextColor: Colors.white,
    ),
    new PageViewModel(
      pageColor: const Color(0xFF65B0B4),
      mainImageAssetPath: '',
      title: 'Banks',
      body: 'We carefully verify all banks before adding them into the app',
      iconImageAssetPath: '',
      titleTextColor: Colors.white,
      bodyTextColor: Colors.white,
    ),
    new PageViewModel(
      pageColor: const Color(0xFF9B90BC),
      mainImageAssetPath: '',
      title: 'Store',
      body: 'All local stores are categorized for your convenience',
      iconImageAssetPath: '',
      titleTextColor: Colors.white,
      bodyTextColor: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IntroViews Flutter',  //title of app
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),  //theme
      home: new IntroViewsFlutter(
        pages,
      ), //home page
    );
  }
}