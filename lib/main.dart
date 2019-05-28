import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:serpentario/page_selector.dart';


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
      home: PageSelectorDemo(), // MyHomePage(title: 'Serpentário'),
    );
  }
}
