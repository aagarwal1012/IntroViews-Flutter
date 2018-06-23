import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

/// This is the class which contains the Page UI.

class Page extends StatelessWidget {
  //page details
  final PageViewModel pageViewModel;

  //percent visible of page
  final double percentVisible;

  //Constructor
  Page({
    this.pageViewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: pageViewModel.pageColor,
      child: new Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Transform(
              //Used for vertical transformation
              transform: new Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: new Padding(
                padding: new EdgeInsets.only(
                    top: 60.0, bottom: 30.0, left: 10.0, right: 10.0),
                child: new Text(
                  pageViewModel.title,
                  style: (pageViewModel.pageTitleBold)
                      ? new TextStyle(
                          color: pageViewModel.titleTextColor,
                          fontFamily: pageViewModel.fontFamily,
                          fontWeight: FontWeight.bold,
                          fontSize: pageViewModel.titleTextSize,
                        )
                      : new TextStyle(
                          color: pageViewModel.titleTextColor,
                          fontFamily: pageViewModel.fontFamily,
                          fontSize: pageViewModel.titleTextSize,
                        ), //TextStyle
                ), //Text
              ), //Padding
            ), //Transform
            new Transform(
              //Used for vertical transformation
              transform: new Matrix4.translationValues(
                  0.0, 50.0 * (1 - percentVisible), 0.0),
              child: new Padding(
                  padding: new EdgeInsets.only(bottom: 30.0),
                  child: (pageViewModel.mainImageAssetPath != null &&
                          pageViewModel.mainImageAssetPath != "")
                      ? new Image.asset(
                          pageViewModel.mainImageAssetPath,
                          width: 285.0,
                          height: 285.0,
                        )
                      : new Container(
                          height: 285.0,
                          width: 285.0,
                        ) //Loading main icon
                  ), //Padding
            ), //Transform
            new Transform(
              //Used for vertical transformation
              transform: new Matrix4.translationValues(
                  0.0, 30.0 * (1 - percentVisible), 0.0),
              child: new Padding(
                padding: const EdgeInsets.only(
                    bottom: 75.0, left: 10.0, right: 10.0),
                child: new Text(
                  pageViewModel.body,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: pageViewModel.bodyTextColor,
                    fontSize: pageViewModel.bodyTextSize,
                    fontFamily: pageViewModel.fontFamily,
                  ), //TextStyle
                ), //Text
              ), //Padding
            ), //Transform
          ],
        ), //Column
      ), //Opacity
    ); //Container
  }
}
