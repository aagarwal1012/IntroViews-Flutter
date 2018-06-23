import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_button_view_model.dart';

/**
 * Skip button class
 */

class SkipButton extends StatelessWidget {
  //callback for skip button
  VoidCallback onTap;
  //view model
  PageButtonViewModel pageButtonViewModel;

  //Constructor
  SkipButton({
    this.onTap,
    this.pageButtonViewModel,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity to create a fade in effect
    double opacity = 1.0;

    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 2 &&
        pageButtonViewModel.slideDirection == SlideDirection.rightToLeft) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    } else if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = pageButtonViewModel.slidePercent;
    }

    return new FlatButton(
      onPressed: onTap,
      child: new Opacity(
        opacity: opacity,
        child: new Text(
          "SKIP",
          style: new TextStyle(
            color: pageButtonViewModel.pageButtonColor,
            fontSize: pageButtonViewModel.pageButtonTextSize,
            fontFamily: pageButtonViewModel.fontFamily,
          ), //TextStyle
        ), //Text
      ), //Opacity
    ); //FlatButton
  }
}

/**
 * Done Button class
 */

class DoneButton extends StatelessWidget {
  //Callback
  VoidCallback onTap;
  //View Model
  PageButtonViewModel pageButtonViewModel;

  //Constructor
  DoneButton({
    this.onTap,
    this.pageButtonViewModel,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity so as to create a fade in effect
    double opacity = 1.0;

    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return new FlatButton(
      onPressed: onTap,
      child: new Opacity(
        opacity: opacity,
        child: new Text(
          "DONE",
          style: new TextStyle(
            color: pageButtonViewModel.pageButtonColor,
            fontSize: pageButtonViewModel.pageButtonTextSize,
            fontFamily: pageButtonViewModel.fontFamily,
          ), //TextStyle
        ), //Text
      ), //Opacity
    ); //FlatButton
  }
}

class PageIndicatorButtons extends StatelessWidget {
  //Some variables
  final int acitvePageIndex;
  final int totalPages;
  VoidCallback onPressedDoneButton; //Callback for Done Button
  VoidCallback onPressedSkipButton; //Callback for Skip Button
  SlideDirection slideDirection;
  final double slidePercent;
  final Color pageButtonsColor;
  final bool showSkipButton;
  final String fontFamily;
  final double pageButtonTextSize;

  //Constructor
  PageIndicatorButtons({
    this.acitvePageIndex,
    this.totalPages,
    this.onPressedDoneButton,
    this.slideDirection,
    this.slidePercent,
    this.onPressedSkipButton,
    this.pageButtonsColor = const Color(0x88FFFFFF),
    this.showSkipButton = true,
    this.fontFamily,
    this.pageButtonTextSize = 18.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ((acitvePageIndex < totalPages - 1 ||
                              (acitvePageIndex == totalPages - 1 &&
                                  slideDirection ==
                                      SlideDirection.leftToRight)) &&
                          showSkipButton)
                      ? new SkipButton(
                          onTap: onPressedSkipButton,
                          pageButtonViewModel: new PageButtonViewModel(
                            //View Model
                            activePageIndex: acitvePageIndex,
                            totalPages: totalPages,
                            slidePercent: slidePercent,
                            slideDirection: slideDirection,
                            fontFamily: fontFamily,
                            pageButtonColor: pageButtonsColor,
                            pageButtonTextSize: pageButtonTextSize,
                          ),
                        )
                      : new Container(),
                ],
              ), //Row
            ), //Padding
          ],
        ), //Column
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (acitvePageIndex == totalPages - 1 ||
                          (acitvePageIndex == totalPages - 2 &&
                              slideDirection == SlideDirection.rightToLeft))
                      ? new DoneButton(
                          onTap: onPressedDoneButton,
                          pageButtonViewModel: new PageButtonViewModel(
                            //view Model
                            activePageIndex: acitvePageIndex,
                            totalPages: totalPages,
                            slidePercent: slidePercent,
                            slideDirection: slideDirection,
                            fontFamily: fontFamily,
                            pageButtonColor: pageButtonsColor,
                            pageButtonTextSize: pageButtonTextSize,
                          ),
                        )
                      : new Container(),
                ],
              ), //Row
            ), //Padding
          ],
        ), //Column
      ],
    ); //Stack
  }
}
