import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_bubble_view_model.dart';
import 'package:intro_views_flutter/Models/pager_indiactor_view_model.dart';
import 'package:intro_views_flutter/UI/page_bubble.dart';

class PagerIndicator extends StatelessWidget {

  final PagerIndicatorViewModel pagerIndicatorViewModel;


  PagerIndicator({
    this.pagerIndicatorViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new PageBubble(
              viewModel: new PageBubbleViewModel(
                "assets/shopping_cart.png",
                Colors.green,
                false,
                0.0,
              ),
            ),
            new PageBubble(
                viewModel: new PageBubbleViewModel(
                  "assets/shopping_cart.png",
                  Colors.green,
                  false,
                  1.0,
                ),
            ),
            new PageBubble(
              viewModel: new PageBubbleViewModel(
                "assets/shopping_cart.png",
                Colors.green,
                true,
                0.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}
