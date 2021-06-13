import 'package:flutter/material.dart';
import 'package:intro_views_flutter/src/helpers/constants.dart';
import 'package:intro_views_flutter/src/helpers/extensions.dart';
import 'package:intro_views_flutter/src/models/page_bubble_view_model.dart';
import 'package:intro_views_flutter/src/models/pager_indicator_view_model.dart';
import 'package:intro_views_flutter/src/ui/page_bubble.dart';

/// This class contains the UI elements associated with bottom page indicator.
class PagerIndicator extends StatelessWidget {
  const PagerIndicator({
    required this.viewModel,
  });

  final PagerIndicatorViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    // extracting page bubble information from page view model
    final bubbles = <PageBubble>[];
    final numOfPages = viewModel.pages.length;

    // calculates the width of the bubble to avoid the overflowing render issue #96
    final bubbleWidth = BUBBLE_WIDTH * numOfPages > context.screenWidth
        ? (context.screenWidth / numOfPages)
        : BUBBLE_WIDTH;

    for (var i = 0; i < numOfPages; i++) {
      final page = viewModel.pages[i];

      // calculating percent active
      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      // checking is that bubble hollow
      final isHollow = i > viewModel.activeIndex ||
          (i == viewModel.activeIndex &&
              viewModel.slideDirection == SlideDirection.leftToRight);

      // adding to the list
      bubbles.add(PageBubble(
        width: bubbleWidth,
        viewModel: PageBubbleViewModel(
          iconAssetPath: page.iconImageAssetPath,
          iconColor: page.iconColor,
          isHollow: isHollow,
          activePercent: percentActive,
          bubbleBackgroundColor: page.bubbleBackgroundColor,
          bubbleInner: page.bubble,
        ),
      ));
    }

    // calculating the translation value of pager indicator while sliding
    final baseTranslation =
        ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
    var translation = baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);

    if (viewModel.slideDirection == SlideDirection.leftToRight) {
      translation += BUBBLE_WIDTH * viewModel.slidePercent;
    } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
      translation -= BUBBLE_WIDTH * viewModel.slidePercent;
    }
    // UI
    return Column(
      children: <Widget>[
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform(
              // used for horizontal transformation
              transform: Matrix4.translationValues(translation, 0.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bubbles,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
