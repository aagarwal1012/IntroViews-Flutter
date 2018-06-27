import 'package:flutter/material.dart';

//view model for pages

class PageViewModel {
  /// Page BackGround Color
  final Color pageColor;

  ///icon image path
  final String iconImageAssetPath;

  /// iconColor
  final Color iconColor;

  /// color for background of progress bubbles
  /// 
  /// @Default `const Color(0x88FFFFFF)`
  final Color bubbleBackgroundColor;

  /// Text widget for the title
  /// 
  /// @Default style `color: Colors.white , fontSize: 50.0`
  final Text title;

  /// Text widget for the title
  /// 
  /// @Default style `color: Colors.white, fontSize: 24.0`
  final Text body;

  /// set default TextStyle for both title and body
  final TextStyle textStyle;

  /// Image Widget
  final Image mainImage;

  PageViewModel(
      {this.pageColor,
      this.iconImageAssetPath,
      this.bubbleBackgroundColor = const Color(0x88FFFFFF),
      this.iconColor,
      @required this.title,
      @required this.body,
      @required this.mainImage,
      this.textStyle});

  TextStyle get titleTextStyle {
    return new TextStyle(color: Colors.white, fontSize: 50.0)
        .merge(this.textStyle);
  }

  TextStyle get bodyTextStyle {
    return new TextStyle(color: Colors.white, fontSize: 24.0)
        .merge(this.textStyle);
  }
}
