import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final PageViewModel pageViewModel;

  ///percent visible of page
  final double percentVisible;

  //Constructor
  Page({
    this.pageViewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.all(8.0),
      width: double.infinity,
      color: pageViewModel.pageColor,
      child: new Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: new OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _PortraitPage(
                  pageViewModel: pageViewModel,
                  percentVisible: percentVisible,
                )
              : _LandscapePage(
                  pageViewModel: pageViewModel,
                  percentVisible: percentVisible,
                );
        }),
      ),
    );
  }
}
/// Body for the Page.
class _BodyPageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;
  const _BodyPageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: const EdgeInsets.only(bottom: 75.0, left: 10.0, right: 10.0),
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
    );
  }
}

class _ImagePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;
  const _ImagePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 50.0 * (1 - percentVisible), 0.0),
      child: new Padding(
          padding: new EdgeInsets.only(bottom: 30.0),
          child: (pageViewModel.mainImageAssetPath != null &&
                  pageViewModel.mainImageAssetPath != "")
              ? new Image.asset(
                  pageViewModel.mainImageAssetPath,
                  width: 285.0,
                  height: 285.0,
                  alignment: Alignment.center,
                )
              : new Container(
                  height: 285.0,
                  width: 285.0,
                ) //Loading main icon
          ), //Padding
    );
  }
}
/// if Device is Landscape reorder with row and column
class _LandscapePage extends StatelessWidget {
  //page details
  final PageViewModel pageViewModel;

  //percent visible of page
  final double percentVisible;

  //Constructor
  const _LandscapePage({Key key, this.pageViewModel, this.percentVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel), //Transform

        new Flexible(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new _TitlePageTransform(
                  percentVisible: percentVisible,
                  pageViewModel: pageViewModel), //Transform
              new _BodyPageTransform(
                  percentVisible: percentVisible,
                  pageViewModel: pageViewModel), //Tran
            ],
          ) // column,
        )
      ],
    ); //row
  }
}
/// when device is Portraint place title, image and body in a column 
class _PortraitPage extends StatelessWidget {
  //page details
  final PageViewModel pageViewModel;

  //percent visible of page
  final double percentVisible;

  //Constructor
  const _PortraitPage({Key key, this.pageViewModel, this.percentVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new _TitlePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel), //Transform
        new _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel), //Transform
        new _BodyPageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel), //Transform
      ],
    ); //column
  }
}
/// Title for the Page
class _TitlePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;
  const _TitlePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
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
    );
  }
}
