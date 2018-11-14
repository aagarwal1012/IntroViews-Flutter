import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';
import 'package:intro_views_flutter/Models/page_button_view_model.dart';

/// Skip button class

class SkipButton extends StatelessWidget {
  //callback for skip button
  final VoidCallback onTap;
  //view model
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;
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

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
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
  final Widget child;
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

    return FlatButton(
      onPressed: onTap,
      child: Opacity(
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

  final Widget doneText;
  final Widget skipText;
  final TextStyle textStyle;

  final bool doneButtonPersist;

  //Constructor
  PageIndicatorButtons({
    @required this.acitvePageIndex,
    @required this.totalPages,
    this.onPressedDoneButton,
    this.slideDirection,
    this.slidePercent,
    this.onPressedSkipButton,
    this.showSkipButton = true,
    this.skipText,
    this.doneText,
    this.textStyle,
    this.doneButtonPersist,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: DefaultTextStyle(
        style: textStyle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ((acitvePageIndex < totalPages - 1 ||
                          (acitvePageIndex == totalPages - 1 &&
                              slideDirection == SlideDirection.leftToRight)) &&
                      showSkipButton)
                  ? SkipButton(
                      child: skipText,
                      onTap: onPressedSkipButton,
                      pageButtonViewModel: PageButtonViewModel(
                        //View Model
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : Container(), //Row
            ), //Padding
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: (acitvePageIndex == totalPages - 1 ||
                      (acitvePageIndex == totalPages - 2 &&
                              slideDirection == SlideDirection.rightToLeft ||
                          doneButtonPersist))
                  ? DoneButton(
                      child: doneText,
                      onTap: onPressedDoneButton,
                      pageButtonViewModel: PageButtonViewModel(
                        //view Model
                        activePageIndex: acitvePageIndex,
                        totalPages: totalPages,
                        slidePercent: doneButtonPersist ? 0.0 : slidePercent,
                        slideDirection: slideDirection,
                      ),
                    )
                  : Container(), //Row
            ),
          ],
        ),
      ),
    );
  }
}
