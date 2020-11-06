import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './screens/home.dart';

void main() => runApp(AlgoViz());

class AlgoViz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ProviderScope(
      child: MaterialApp(
        initialRoute: HomeScreen.id,
        routes: {HomeScreen.id: (context) => HomeScreen()},
      ),
    );
  }
}
