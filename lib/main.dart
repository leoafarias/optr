import 'package:flutter/material.dart';

import 'package:optr/screens/home.screen.dart';
import 'package:optr/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme(),
      home: HomeScreen('Flutter Demo Home Page'),
    );
  }
}
