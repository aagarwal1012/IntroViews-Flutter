import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_button_view_model.dart';
import 'package:intro_views_flutter/Models/slide_update_model.dart';

class SkipButton extends StatelessWidget {

  VoidCallback onTap;
  PageButtonViewModel pageButtonViewModel;

  SkipButton({
    this.onTap,
    this.pageButtonViewModel,
  });

  @override
  Widget build(BuildContext context) {

    double opacity = 1.0;

    if(pageButtonViewModel.activePageIndex == pageButtonViewModel.totalPages - 2 && pageButtonViewModel.slideDirection == SlideDirection.rightToLeft){
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }
    else if(pageButtonViewModel.activePageIndex == pageButtonViewModel.totalPages - 1 && pageButtonViewModel.slideDirection == SlideDirection.leftToRight){
      opacity = pageButtonViewModel.slidePercent;
    }

    return new FlatButton(
      onPressed: onTap,
      child: new Opacity(
        opacity: opacity,
        child: new Text(
          "SKIP",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: "FlamanteRoma",
          ),
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {

  VoidCallback onTap;
  PageButtonViewModel pageButtonViewModel;

  DoneButton({
    this.onTap,
    this.pageButtonViewModel,
  });

  @override
  Widget build(BuildContext context) {

    double opacity = 1.0;

    if(pageButtonViewModel.activePageIndex == pageButtonViewModel.totalPages - 1 && pageButtonViewModel.slideDirection == SlideDirection.leftToRight){
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return new FlatButton(
      onPressed: onTap,
      child: new Opacity(
        opacity: opacity,
        child: new Text(
          "DONE",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: "FlamanteRoma",
          ),
        ),
      ),
    );
  }
}

class PageIndicatorButtons extends StatelessWidget {

  final int acitvePageIndex;
  final int totalPages;
  VoidCallback onPressedDoneButton;
  VoidCallback onPressedSkipButton;
  SlideDirection slideDirection;
  final double slidePercent;

  PageIndicatorButtons({
    this.acitvePageIndex,
    this.totalPages,
    this.onPressedDoneButton,
    this.slideDirection,
    this.slidePercent,
    this.onPressedSkipButton,
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
                  (acitvePageIndex < totalPages - 1 || (acitvePageIndex == totalPages - 1 && slideDirection == SlideDirection.leftToRight))
                      ? new SkipButton(
                          onTap: onPressedSkipButton,
                          pageButtonViewModel: new PageButtonViewModel(
                            activePageIndex: acitvePageIndex,
                            totalPages: totalPages,
                            slidePercent: slidePercent,
                            slideDirection: slideDirection,
                          ),
                      )
                      : new Container(),
                ],
              ),
            )
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (acitvePageIndex == totalPages - 1 || (acitvePageIndex == totalPages - 2 && slideDirection == SlideDirection.rightToLeft))
                      ? new DoneButton(
                        onTap: onPressedDoneButton,
                        pageButtonViewModel: new PageButtonViewModel(
                          activePageIndex: acitvePageIndex,
                          totalPages: totalPages,
                          slidePercent: slidePercent,
                          slideDirection: slideDirection,
                        ),
                      )
                      : new Container(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


