import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tetris/model/figure/figureException.dart';

import 'borderIndex.dart';
import '../figure/figure.dart';

class Blocks {
  List<Figure> figureStack = [];

  List<Block> blockList = [];

  Block findBlock(BorderIndex index) {
    final foundedIndex =
        blockList.map((e) => e.index.index).toList().indexOf(index.index);

    return foundedIndex > -1 ? blockList[foundedIndex] : null;
  }

  bool isGameEnd() {
    final isThereZeroIndex =
        figureStack.last.figureComp.map((e) => e.column < 0).contains(true);

    if (figureStack.last.exception == FigureException.downMove &&
        isThereZeroIndex) {
      return true;
    }

    return false;
  }

  void createBlocks() {
    blockList.clear();
    figureStack.forEach(
      (figure) {
        return figure.figureComp.map(
          (index) {
            blockList.add(
              Block(
                color: figure.color,
                index: index,
                isStopped: figure.exception == FigureException.downMove
              ),
            );
          },
        ).toList();
      },
    );
  }
}

class Block {
  final BorderIndex index;
  final Color color;
  final bool isStopped;

  Block({this.isStopped, this.color, this.index});
}
