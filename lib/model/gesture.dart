

import 'package:flutter/cupertino.dart';

class Gesture {

  int gestureCount = 0;

  static const LEFT = 'left';
  static const RIGHT = 'right';
  static const NONE = 'none';


  void reset (details) {
    gestureCount = 0;
  }

  String get(DragUpdateDetails details) {
    if (details.delta.dx > 1 || details.delta.dx < -1) {
      gestureCount++;
    }
    if (details.delta.dx > 1 && gestureCount % 10 == 0) {
      return RIGHT;
    } else if (details.delta.dx < -1 && gestureCount % 10 == 0) {
      return LEFT;
    }
    return NONE;
  }
}