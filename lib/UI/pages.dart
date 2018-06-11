import 'package:flutter/material.dart';

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: Colors.blueAccent,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(bottom: 20.0),
              child: new Image.asset("assets/hotels.png", width: 200.0, height: 200.0,)
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: new Text(
              'Hotels',
              style: new TextStyle(
                color: Colors.white,
                fontFamily: "FlamanteRoma",
                fontSize: 34.0,
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(bottom: 75.0),
            child: new Text(
              'This is the body',
              textAlign: TextAlign.center,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],

      ),
    );
  }
}
