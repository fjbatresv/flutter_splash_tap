import 'package:flutter/material.dart';
import 'splash.dart';

void main() => runApp(MaterialApp(
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
  // This widget is the root of your application.
}

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Splash(
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                  child: Center(
                    child: Text("CLICK ME PLEASE"),
                  ),
                ),
                onTap: (){print("tap");},
              ),
              Splash(
                child: Icon(Icons.close),
                onTap: (){},
              )
            ],
          ),
        ),
      )
    );
  }

}