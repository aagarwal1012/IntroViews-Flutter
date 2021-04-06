import 'package:flutter/material.dart';

/// View model for page bubble.
class PageBubbleViewModel {
  const PageBubbleViewModel({
    this.bubbleInner,
    this.iconAssetPath,
    this.iconColor,
    required this.isHollow,
    required this.activePercent,
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
  });

  final String? iconAssetPath;
  final Color? iconColor;
  final bool isHollow;
  final double activePercent;
  final Color bubbleBackgroundColor;
  final Widget? bubbleInner;
}
