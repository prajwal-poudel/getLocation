import 'package:flutter/material.dart';
import 'package:half_roject/listViewWidget.dart';
import 'package:half_roject/liveData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.purple, fontFamily: "FuzzyBubbles"),
      home: LiveData(),
    );
  }
}
