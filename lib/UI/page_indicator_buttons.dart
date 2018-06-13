import 'package:flutter/material.dart';

class SkipButton extends StatelessWidget {

  VoidCallback onTap;

  SkipButton({
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 0.0,right: 40.0),
      child: new FlatButton(
        onPressed: onTap,
        child: new Text(
          "SKIP",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: "FlamanteRoma",
          ),
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
    return new Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 0.0),
      child: new FlatButton(
        onPressed: onTap,
        child: new Text(
          "DONE",
          style: new TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: "FlamanteRoma",
          ),
        ),
      ),
    );
  }
}

