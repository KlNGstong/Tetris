


import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:tetris/model/screenManage.dart';

class BoardConfig {

    static int columns = 20;
    static int rows = 10;

    static double maxWidth = screenManage.width * .6 ;

    static Size boardSize = Size(
        maxWidth,
        squareSize * columns
    );

    static double squareSize = maxWidth / rows;

}