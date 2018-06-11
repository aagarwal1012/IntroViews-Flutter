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
        width: 50.0,
        height: 50.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0x88FFFFFF),
        ),
        child: new Image.asset(
          viewModel.iconAssetPath,
          color: viewModel.color,
        ),
      ),
    );
  }
}
