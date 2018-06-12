import 'package:flutter/material.dart';

// View Model for page bubble

class PageBubbleViewModel{
  final String iconAssetPath;
  final Color color;
  final bool isHollow;
  final double activePercent;

  PageBubbleViewModel(
      this.iconAssetPath,
      this.color,
      this.isHollow,
      this.activePercent,);


}