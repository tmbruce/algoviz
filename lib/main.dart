import 'package:flutter/material.dart';
import './screens/home.dart';

void main() => runApp(AlgoViz());

class AlgoViz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomeScreen.id,
      routes: {HomeScreen.id: (context) => HomeScreen()},
    );
  }
}
