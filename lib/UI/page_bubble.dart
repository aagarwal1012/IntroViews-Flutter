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
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Container(
        width: lerpDouble(20.0, 45.0, viewModel.activePercent),
        height: lerpDouble(20.0, 45.0, viewModel.activePercent),
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: viewModel.isHollow ? Colors.transparent : const Color(0x88FFFFFF),
          border: new Border.all(
            color: viewModel.isHollow ? const Color(0x88FFFFFF) : Colors.transparent,
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
    );
  }
}
