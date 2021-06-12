import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/src/models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  const PageBubble({
    required this.numOfPages,
    required this.viewModel,
  });

  final int numOfPages;
  final PageBubbleViewModel viewModel;

  double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Container(
      // calculates the width of the bubble to avoid the overflowing render issue
      width: BUBBLE_WIDTH * numOfPages > getScreenWidth(context)
          ? (getScreenWidth(context) / numOfPages)
          : BUBBLE_WIDTH,
      height: 65.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            // this method returns in between values according to active percent
            width: lerpDouble(20.0, 45.0, viewModel.activePercent),
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // alpha is used to create fade effect for background color
              color: viewModel.isHollow
                  ? viewModel.bubbleBackgroundColor
                      .withAlpha((0x88 * viewModel.activePercent).round())
                  : viewModel.bubbleBackgroundColor,
              border: Border.all(
                color: viewModel.isHollow
                    ? viewModel.bubbleBackgroundColor.withAlpha(
                        (0x88 * (1 - viewModel.activePercent)).round())
                    : Colors.transparent,
                width: 3.0,
              ),
            ),
            child: Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != '')
                  ? Image.asset(
                      viewModel.iconAssetPath!,
                      color: viewModel.iconColor,
                    )
                  : viewModel.bubbleInner != null
                      ? Transform.scale(
                          scale: viewModel.activePercent.clamp(0.5, 1.0),
                          child: viewModel.bubbleInner,
                        )
                      : const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}
