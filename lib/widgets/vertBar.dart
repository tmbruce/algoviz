//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VertBar extends StatelessWidget {
  final int id;
  final double containerHeight;
  final bool active;

  VertBar(this.id, this.containerHeight, [this.active]);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        height: containerHeight * (id / 1000),
        color: active == null
            ? Colors.green
            : active
                ? Colors.red
                : Colors.blue,
      ),
    );
  }
}
