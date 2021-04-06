import 'package:intro_views_flutter/src/constants/constants.dart';
import 'package:intro_views_flutter/src/models/page_view_model.dart';

/// View model for page indicator.
class PagerIndicatorViewModel {
  const PagerIndicatorViewModel(
    this.pages,
    this.activeIndex,
    this.slideDirection,
    this.slidePercent,
  );

  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;
}
