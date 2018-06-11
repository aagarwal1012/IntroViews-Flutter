import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/pager_indiactor_view_model.dart';

class PagerIndicator extends StatelessWidget {

  final PagerIndicatorViewModel pagerIndicatorViewModel;


  PagerIndicator(
      this.pagerIndicatorViewModel
      );

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Expanded(child: new Container()),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                width: 20.0,
                height: 20.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x88FFFFFF),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                width: 50.0,
                height: 50.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x88FFFFFF),
                ),
                child: new Image.asset(
                  "assets/wallet.png",
                  color: Colors.blue,
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                width: 20.0,
                height: 20.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: new Border.all(
                    color: const Color(0x88FFFFFF),
                    width: 3.0,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
