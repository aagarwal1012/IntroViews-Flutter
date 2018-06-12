import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

/**
 * This is the class which contains the Page UI.
 */

class Page extends StatelessWidget {

  //page details
  final PageViewModel pageViewModel;

  //percent visible of page
  double percentVisible = 1.0;

  //Constructor
  Page({
    this.pageViewModel,
    this.percentVisible,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: pageViewModel.color,
      child: new Opacity(       //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Transform(      //Used for vertical transformation
              transform : new Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0) ,
              child: new Padding(
                  padding: new EdgeInsets.only(bottom: 20.0),
                  child: new Image.asset(pageViewModel.heroAssetPath, width: 200.0, height: 200.0,)   //Loading main icon
              ), //Padding
            ),  //Transform
            new Transform(      //Used for vertical transformation
              transform : new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0) ,
              child: new Padding(
                padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: new Text(
                  pageViewModel.title,
                  style: new TextStyle(
                    color: Colors.white,
                    fontFamily: "FlamanteRoma",
                    fontSize: 34.0,
                  ),  //TextStyle
                ),  //Text
              ),//Padding
            ),  //Transform
            new Transform(      //Used for vertical transformation
              transform : new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0) ,
              child: new Padding(
                padding: const EdgeInsets.only(bottom: 75.0),
                child: new Text(
                  pageViewModel.body,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),  //TextStyle
                ),  //Text
              ),  //Padding
            ),  //Transform
          ],

        ),  //Column
      ),  //Opacity
    );  //Container
  }
}
