//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VertBar extends StatelessWidget {
  final int id;
  final double containerHeight;
  final bool active;

  VertBar(this.id, this.containerHeight, [this.active]);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: containerHeight * (id / 1000),
      //curve: Curves.bounceIn,
      duration: Duration(milliseconds: 1),
      color: active == null
          ? Colors.green
          : active
              ? Colors.red
              : Colors.blueGrey,
      //color: active ? Colors.red : Colors.blueGrey,
      width: 4,
    );
  }
}
