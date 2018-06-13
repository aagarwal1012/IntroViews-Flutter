import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {

  VoidCallback onTap;
  double slidePercent;

  SkipButton({
    this.onTap,
    this.slidePercent,
  });

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: onTap,
      child: new Text(
        "SKIP",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: "FlamanteRoma",
        ),
      ),
    );
  }
}

class DoneButton extends StatelessWidget {

  VoidCallback onTap;

  DoneButton({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      onPressed: onTap,
      child: new Text(
        "DONE",
        style: new TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: "FlamanteRoma",
        ),
      ),
    );
  }
}

class PageIndicatorButtons extends StatelessWidget {

  final int acitvePageIndex;
  final int totalPages;

  PageIndicatorButtons({
    this.acitvePageIndex,
    this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  (acitvePageIndex < totalPages - 1) ? new SkipButton() : new Container(),
                ],
              ),
            )
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Expanded(child: new Container()),
            new Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  (acitvePageIndex == totalPages - 1) ? new DoneButton() : new Container(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}


