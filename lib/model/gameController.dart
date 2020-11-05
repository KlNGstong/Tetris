import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:tetris/model/border/blocks.dart';
import 'package:tetris/model/border/boardConfig.dart';
import 'package:tetris/model/border/borderIndex.dart';
import 'package:tetris/model/figure/figureException.dart';
import 'package:tetris/model/gesture.dart';
import 'package:tetris/model/layersRemover.dart';
import 'figure/figure.dart';
import 'figure/figureType.dart';

class GameController extends ChangeNotifier {
  Blocks blocks = Blocks();
  LayersRemover layersRemover;
  Gesture gesture = Gesture();
  Duration gameSpeed = Duration(milliseconds: 200);

  List<Figure> nextFigureStack = [];

  void onBlockShift() {
    layersRemover.remove();
    blocks.createBlocks();

    notifyListeners();
  }

  void onTap() {
    blocks.figureStack.last.rotate(blocks.blockList);
    onBlockShift();
  }

  void onLongPress() {
    blocks.figureStack.last.moveBottom(blocks.blockList);
    blocks.figureStack.add(Figure.create());
    onBlockShift();
  }

  void onDrag(type) {
    if (type != Gesture.NONE) {
      if (type == Gesture.LEFT)
        blocks.figureStack.last.moveLeft(blocks.blockList);
      else
        blocks.figureStack.last.moveRight(blocks.blockList);
      onBlockShift();
    }
  }

  void gameAction() async {
    await Future.delayed(gameSpeed);
    blocks.figureStack.last.moveDown(blocks.blockList);
    if (FigureException.none == blocks.figureStack.last.exception) {
      blocks.createBlocks();
    } else {
      if (blocks.isGameEnd()) {
        blocks.figureStack.clear();
      }
      blocks.figureStack.add(Figure.create());
    }
    onBlockShift();
    gameAction();
  }

  void start() {
    blocks.figureStack.add(Figure.create());
    layersRemover = LayersRemover(blocks);
    gameAction();
  }
}
