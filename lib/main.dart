import 'package:flutter/material.dart';
import 'package:intro_views_flutter/UI/pages.dart';
import 'Animation/page_reveal.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IntroViews Flutter',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Page(
              pageViewModel: pages[0],
            percentVisible: 1.0,
          ),
          new PageReveal(
            revealPercent: 0.4,
            child: new Page(
              pageViewModel: pages[1],
              percentVisible: 1.0,
            ),
          ),
          new Column(
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
          ),
        ],
      ),

    );
  }
}
