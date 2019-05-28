import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:serpentario/Signos.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serpentário',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Signos(), // MyHomePage(title: 'Serpentário'),
    );
  }
}
