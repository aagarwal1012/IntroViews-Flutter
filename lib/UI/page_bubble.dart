import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  //view model
  final PageBubbleViewModel viewModel;

  //Constructor
  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 55.0,
      height: 65.0,
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            width: lerpDouble(
                20.0,
                45.0,
                viewModel
                    .activePercent), //This method return in between values according to active percent.
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              //Alpha is used to create fade effect for background color
              color: viewModel.isHollow
                  ? viewModel.bubbleBackgroundColor
                      .withAlpha((0x88 * viewModel.activePercent).round())
                  : const Color(0x88FFFFFF),
              border: new Border.all(
                color: viewModel.isHollow
                    ? viewModel.bubbleBackgroundColor.withAlpha(
                        (0x88 * (1 - viewModel.activePercent)).round())
                    : Colors.transparent,
                width: 3.0,
              ), //Border
            ), //BoxDecoration
            child: new Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != "")
                  // ignore: conflicting_dart_import
                  ? new Image.asset(
                      viewModel.iconAssetPath,
                      color: viewModel.iconColor,
                    )
                  : new Container(),
            ), //opacity
          ), //Container
        ), //Padding
      ), //Center
    ); //Container
  }
}
