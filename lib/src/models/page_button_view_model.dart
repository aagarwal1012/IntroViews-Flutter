import 'package:intro_views_flutter/src/helpers/constants.dart';

/// This is view model for the skip and done buttons.
class PageButtonViewModel {
  const PageButtonViewModel({
    required this.slidePercent,
    required this.totalPages,
    required this.activePageIndex,
    required this.slideDirection,
  });

  final double slidePercent;
  final int totalPages;
  final int activePageIndex;
  final SlideDirection slideDirection;
}
