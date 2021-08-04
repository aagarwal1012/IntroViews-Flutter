import 'package:flutter/material.dart';
import 'package:intro_views_flutter/src/helpers/constants.dart';
import 'package:intro_views_flutter/src/models/page_button_view_model.dart';

/// Skip, Next, and Back button class.
class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.onTap,
    required this.pageButtonViewModel,
    required this.child,
  }) : super(key: key);

  /// Callback for skip button.
  final VoidCallback? onTap;

  /// View model.
  final PageButtonViewModel pageButtonViewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // calculating opacity to create a fade in effect
    var opacity = 1.0;
    final textStyle = DefaultTextStyle.of(context).style;
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 2 &&
        pageButtonViewModel.slideDirection == SlideDirection.rightToLeft) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    } else if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = pageButtonViewModel.slidePercent;
    }

    return TextButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: textStyle,
          child: child,
        ),
      ),
    );
  }
}

/// Done Button class.
class DoneButton extends StatelessWidget {
  const DoneButton({
    Key? key,
    required this.onTap,
    required this.pageButtonViewModel,
    required this.child,
  }) : super(key: key);

  final VoidCallback? onTap;

  final PageButtonViewModel pageButtonViewModel;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // calculating opacity so as to create a fade in effect
    var opacity = 1.0;
    final textStyle = DefaultTextStyle.of(context).style;

    // TODO: remove this, seems like that this if clause is always evaluated as false
    if (pageButtonViewModel.activePageIndex ==
            pageButtonViewModel.totalPages - 1 &&
        pageButtonViewModel.slideDirection == SlideDirection.leftToRight) {
      opacity = 1.0 - pageButtonViewModel.slidePercent;
    }

    return TextButton(
      onPressed: onTap,
      child: Opacity(
        opacity: opacity,
        child: DefaultTextStyle.merge(
          style: textStyle,
          child: child,
        ),
      ),
    );
  }
}

class PageIndicatorButtons extends StatelessWidget {
  const PageIndicatorButtons({
    Key? key,
    required this.activePageIndex,
    required this.totalPages,
    this.onPressedDoneButton,
    required this.slideDirection,
    required this.slidePercent,
    this.onPressedSkipButton,
    this.onPressedNextButton,
    this.onPressedBackButton,
    required this.showSkipButton,
    required this.skipText,
    required this.nextText,
    required this.doneText,
    required this.textStyle,
    required this.doneButtonPersist,
    this.showNextButton = true,
    this.showBackButton = true,
    required this.backText,
  }) : super(key: key);

  final int activePageIndex;
  final int totalPages;

  final VoidCallback? onPressedDoneButton;
  final VoidCallback? onPressedNextButton;
  final VoidCallback? onPressedBackButton;
  final VoidCallback? onPressedSkipButton;
  final SlideDirection slideDirection;
  final double slidePercent;
  final bool showSkipButton;
  final bool showNextButton;
  final bool showBackButton;

  final Widget doneText;
  final Widget skipText;
  final Widget nextText;
  final Widget backText;
  final TextStyle textStyle;

  final bool doneButtonPersist;

  Widget _getDoneORNextButton() {
    if ((activePageIndex < totalPages - 1 ||
            (activePageIndex == totalPages - 1 &&
                slideDirection == SlideDirection.leftToRight)) &&
        showNextButton) {
      return DefaultButton(
        onTap: onPressedNextButton,
        pageButtonViewModel: PageButtonViewModel(
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
        child: nextText,
      );
    } else if (activePageIndex == totalPages - 1 ||
        (activePageIndex == totalPages - 2 &&
                slideDirection == SlideDirection.rightToLeft ||
            doneButtonPersist)) {
      return DoneButton(
        onTap: onPressedDoneButton,
        pageButtonViewModel: PageButtonViewModel(
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: doneButtonPersist ? 0.0 : slidePercent,
          slideDirection: slideDirection,
        ),
        child: doneText,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _getSkipORBackButton() {
    if (activePageIndex <= totalPages &&
        activePageIndex >= 1 &&
        showBackButton) {
      return DefaultButton(
        onTap: onPressedBackButton,
        pageButtonViewModel: PageButtonViewModel(
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
        child: backText,
      );
    } else if ((activePageIndex < totalPages - 1 ||
            (activePageIndex == totalPages - 1 &&
                slideDirection == SlideDirection.leftToRight)) &&
        showSkipButton) {
      return DefaultButton(
        onTap: onPressedSkipButton,
        pageButtonViewModel: PageButtonViewModel(
          activePageIndex: activePageIndex,
          totalPages: totalPages,
          slidePercent: slidePercent,
          slideDirection: slideDirection,
        ),
        child: skipText,
      );
    } else {
      return const SizedBox();
    }
  }

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
              child: _getSkipORBackButton(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: _getDoneORNextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
