import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_bubble_view_model.dart';

class PageBubble extends StatelessWidget {

  final PageBubbleViewModel viewModel;


  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: 65.0,
      height: 65.0,
      child: new Center(
        child: new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            width: lerpDouble(20.0, 45.0, viewModel.activePercent),
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: viewModel.isHollow ? const Color(0x88FFFFFF).withAlpha((0x88 * viewModel.activePercent).round()) : const Color(0x88FFFFFF),
              border: new Border.all(
                color: viewModel.isHollow ? const Color(0x88FFFFFF).withAlpha((0x88 * (1 - viewModel.activePercent)).round()) : Colors.transparent,
                width: 3.0,
              )
            ),
            child: new Opacity(
              opacity: viewModel.activePercent,
              // ignore: conflicting_dart_import
              child: new Image.asset(
                viewModel.iconAssetPath,
                color: viewModel.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
