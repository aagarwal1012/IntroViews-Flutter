import 'package:intro_views_flutter/src/helpers/constants.dart';

/// Model for slide update.
class SlideUpdate {
  const SlideUpdate(
    this.direction,
    this.slidePercent,
    this.updateType,
  );

  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;
}
