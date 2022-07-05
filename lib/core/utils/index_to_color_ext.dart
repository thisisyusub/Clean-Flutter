import 'package:flutter/material.dart';

final _colors = <Color>[
  Colors.amberAccent,
  Colors.yellowAccent,
  Colors.tealAccent,
  Colors.redAccent,
  Colors.purpleAccent,
  Colors.pinkAccent,
  Colors.blueAccent,
  Colors.orangeAccent,
  Colors.limeAccent,
  Colors.indigoAccent,
];

extension IndexToColorExt on int {
  Color get convertToColor {
    return _colors[this - 1];
  }
}
