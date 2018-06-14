import 'package:flutter/material.dart';

//view model for pages

class PageViewModel{
  final Color color;
  //main image path
  final String mainImageAssetPath;
  final String title;
  final String body;
  final String iconImageAssetPath;
  final Color titleTextColor;
  final Color bodyTextColor;

  PageViewModel({
    this.color,
    this.mainImageAssetPath,
    this.title,
    this.body,
    this.iconImageAssetPath,
    this.bodyTextColor,
    this.titleTextColor,
  });


}