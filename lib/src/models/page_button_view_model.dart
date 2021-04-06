import 'package:intro_views_flutter/src/constants/constants.dart';

/// This is view model for the skip and done buttons.
class PageButtonViewModel {
  const PageButtonViewModel({
    this.slidePercent,
    this.totalPages,
    this.activePageIndex,
    this.slideDirection,
  });

  final double slidePercent;
  final int totalPages;
  final int activePageIndex;
  final SlideDirection slideDirection;
}
