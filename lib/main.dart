import 'package:flutter/material.dart';
import 'package:optr/components/frame.dart';
import 'package:optr/helpers/sound_effect.dart';
import 'package:optr/screens/home.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen('Flutter Demo Home Page'),
    );
  }
}
