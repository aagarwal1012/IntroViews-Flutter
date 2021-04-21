import 'package:flutter/material.dart';

/// View model for pages.
class PageViewModel {
  const PageViewModel({
    this.pageColor,
    this.pageBackground = const SizedBox(),
    this.iconImageAssetPath,
    this.bubbleBackgroundColor = const Color(0x88FFFFFF),
    this.iconColor,
    this.title = const SizedBox(),
    this.body = const SizedBox(),
    this.mainImage = const SizedBox(),
    this.bubble,
    this.textStyle,
    this.titleTextStyle = const TextStyle(color: Colors.white, fontSize: 50.0),
    this.bodyTextStyle = const TextStyle(color: Colors.white, fontSize: 24.0),
  });

  /// Page background color.
  ///
  /// [pageColor] has priority over [pageBackground].
  final Color? pageColor;

  /// Widget shown in the background and can be used instead of [pageColor] or
  /// for the full customization of the page, e.g. having a gradient background
  /// or adding a background image.
  ///
  /// [pageColor] has priority over [pageBackground].
  final Widget pageBackground;

  /// Icon image path.
  final String? iconImageAssetPath;

  /// Icon color.
  final Color? iconColor;

  /// Color for background of progress bubbles.
  ///
  /// Defaults to light grey: `Color(0x88FFFFFF)`.
  final Color bubbleBackgroundColor;

  /// Widget for the title.
  ///
  /// _Typically a [Text] widget_.
  ///
  /// Omitted by default.
  final Widget title;

  /// Widget for the body.
  ///
  /// _Typically a [Text] widget_.
  ///
  /// Omitted by default.
  final Widget body;

  /// Sets TextStyle for [titleTextStyle] and [bodyTextStyle].
  ///
  /// [titleTextStyle] defaults to `TextStyle(color: Colors.white, fontSize: 50.0)`.
  ///
  /// [bodyTextStyle] defaults to `TextStyle(color: Colors.white, fontSize: 24.0)`.
  final TextStyle? textStyle;

  /// Set TextStyle for [title].
  ///
  /// Defaults to `TextStyle(color: Colors.white, fontSize: 50.0)`.
  final TextStyle titleTextStyle;

  /// Sets TextStyle for [body].
  ///
  /// Defaults to `TextStyle(color: Colors.white, fontSize: 24.0)`.
  final TextStyle bodyTextStyle;

  /// Main widget.
  ///
  /// _Typically an [Image] widget_.
  ///
  /// Omitted by default.
  final Widget mainImage;

  /// Inner bubble widget.
  ///
  /// _Typically an [Image] widget_.
  ///
  /// Gets overridden by [iconImageAssetPath].
  final Widget? bubble;

  TextStyle get mergedTitleTextStyle {
    return const TextStyle(color: Colors.white, fontSize: 50.0)
        .merge(textStyle)
        .merge(titleTextStyle);
  }

  TextStyle get mergedBodyTextStyle {
    return const TextStyle(color: Colors.white, fontSize: 24.0)
        .merge(textStyle)
        .merge(bodyTextStyle);
  }
}
