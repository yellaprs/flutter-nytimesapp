import 'package:flutter/material.dart';
import 'package:nytimes_app/home_page.dart';
import 'package:flutter/rendering.dart';

void main() {

  runApp(new MyApp());
  //debugPaintSizeEnabled=true;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
 

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new MaterialApp(
    
     //title: new Image.asset("assets/newyorktime.jpg", fit: BoxFit.cover),
     //icon: image: new AssetImage(planet.image),
     theme: new ThemeData(
        // This is the theme of your application.
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primaryColor: Colors.yellowAccent,
        fontFamily: 'Poppins',
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black,
          displayColor: Colors.black87
        ),

      ),
     home: HomePage(),
     
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
