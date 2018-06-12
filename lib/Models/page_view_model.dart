import 'package:flutter/material.dart';

//view model for pages

class PageViewModel{
  final Color color;
  //main image path
  final String heroAssetPath;
  final String title;
  final String body;
  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.iconAssetPath
  );


}