import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_button_view_model.dart';

/// Skip button class

class SkipButton extends StatelessWidget {
  //callback for skip button
  final VoidCallback onTap;
  //view model
  final PageButtonViewModel pageButtonViewModel;
  final Text child;
  //Constructor
  SkipButton({
    this.onTap,
    this.pageButtonViewModel,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity to create a fade in effect
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
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
        child: DefaultTextStyle.merge(
          style: style,
          child: child,
        ), //Text
      ), //Opacity
    ); //FlatButton
  }
}

/// Done Button class

class DoneButton extends StatelessWidget {
  //Callback
  final VoidCallback onTap;
  //View Model
  final PageButtonViewModel pageButtonViewModel;
  final Text child;
  //Constructor
  DoneButton({
    this.onTap,
    this.pageButtonViewModel,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    //Calculating opacity so as to create a fade in effect
    double opacity = 1.0;
    final TextStyle style = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return new FlatButton(
      onPressed: onTap,
      child: new Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: style,
          child: child, //Text
        ),
      ), //Opacity
    ); //FlatButton
  }
}

class PageIndicatorButtons extends StatelessWidget {
  //Some variables
  final int acitvePageIndex;
  final int totalPages;
  final VoidCallback onPressedDoneButton; //Callback for Done Button
  final VoidCallback onPressedSkipButton; //Callback for Skip Button
  final SlideDirection slideDirection;
  final double slidePercent;
  final bool showSkipButton;

  final Text endText;
  final Text startText;
  final TextStyle textStyle;
  //Constructor
  PageIndicatorButtons({
    @required this.acitvePageIndex,
    @required this.totalPages,
    this.onPressedDoneButton,
    this.slideDirection,
    this.slidePercent,
    this.onPressedSkipButton,
    this.showSkipButton = true,
    this.startText,
    this.endText,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: DefaultTextStyle(
        style: textStyle,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ((acitvePageIndex < totalPages - 1 ||
                          (acitvePageIndex == totalPages - 1 &&
                              slideDirection == SlideDirection.leftToRight)) &&
                      showSkipButton)
                  ? new SkipButton(
                      child: startText,
                      onTap: onPressedSkipButton,
                      pageButtonViewModel: new PageButtonViewModel(
                        //View Model
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : new Container(), //Row
            ), //Padding

            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: (acitvePageIndex == totalPages - 1 ||
                      (acitvePageIndex == totalPages - 2 &&
                          slideDirection == SlideDirection.rightToLeft))
                  ? new DoneButton(
                      child: endText,
                      onTap: onPressedDoneButton,
                      pageButtonViewModel: new PageButtonViewModel(
                        //view Model
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : new Container(), //Row
            ),
          ],
        ),
      ),
    );
  }
}
