import 'package:flutter/material.dart';

// View Model for page bubble

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color iconColor;
  final bool isHollow;
  final double activePercent;
  Color bubbleBackgroundColor;

  PageBubbleViewModel(
      this.iconAssetPath, this.iconColor, this.isHollow, this.activePercent,
      {this.bubbleBackgroundColor}) {
    if (bubbleBackgroundColor == null)
      bubbleBackgroundColor = const Color(0x88FFFFFF);
  }
}
