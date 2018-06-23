import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Constants/constants.dart';

/// This is view model for the skip and done buttons.

class PageButtonViewModel {
  final double slidePercent;
  final int totalPages;
  final int activePageIndex;
  final SlideDirection slideDirection;
  final String fontFamily;
  final double pageButtonTextSize;
  final Color pageButtonColor;

  PageButtonViewModel({
    this.slidePercent,
    this.totalPages,
    this.activePageIndex,
    this.slideDirection,
    this.fontFamily,
    this.pageButtonTextSize = 18.0,
    this.pageButtonColor = Colors.white,
  });
}
