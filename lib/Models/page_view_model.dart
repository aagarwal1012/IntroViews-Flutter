import 'package:flutter/material.dart';

//view model for pages

class PageViewModel{
  final Color pageColor;
  //main image path
  final String mainImageAssetPath;
  final String title;
  final String body;
  final String iconImageAssetPath;
  final Color titleTextColor;
  final Color bodyTextColor;
  Color iconColor;
  final Color bubbleBackgroundColor;
  final String fontFamily;
  final bool pageTitleBold;

  PageViewModel({
    this.pageColor,
    this.mainImageAssetPath,
    this.title,
    this.body,
    this.iconImageAssetPath,
    this.bodyTextColor = const Color(0x88FFFFFF),
    this.titleTextColor = const Color(0x88FFFFFF),
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
    this.iconColor,
    this.fontFamily,
    this.pageTitleBold = false,
  }){
    if(iconColor == null){
      iconColor = pageColor;
    }
  }


}