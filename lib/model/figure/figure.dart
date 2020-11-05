import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/model/border/blocks.dart';
import 'package:tetris/model/border/boardConfig.dart';
import 'package:tetris/model/figure/figureException.dart';
import '../border/borderIndex.dart';
import 'figureCompCreator.dart';
import 'figureType.dart';
import 'dart:math' as math;

class Figure {
  Figure({this.color, this.currentShift, this.matrix});

  FigureMatrix matrix;
  BorderIndex currentShift;
  FigureException exception = FigureException.none;
  final Color color;
  static List _availableColor = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink
  ];

  List<BorderIndex> get figureComp => matrix.toFigureComp(currentShift);

  static Figure create() {
    final startIndex = BorderIndex(2, -3);

    final randomType =
        FigureType.values[Random().nextInt(FigureType.values.length)];

    final randomColor =
        _availableColor[math.Random().nextInt(_availableColor.length)];

    final createdFigureMatrixList = FigureCompCreator.getByType(randomType);

    int matrixSize = randomType == FigureType.I ? 4 : 3;

    if (randomType == FigureType.O) {
      matrixSize = 2;
    }

    return Figure(
        color: randomColor,
        currentShift: startIndex,
        matrix: FigureMatrix.create(
            figureComp: createdFigureMatrixList, size: matrixSize));
  }

  void moveDown(
    List<Block> blocks,
  ) {
    final BorderIndex shift = currentShift + BorderIndex(0, 1);
    final isOverflow = this.isOverflow(shift);
    final isCross = this.isCross(shift: shift, allBlocks: blocks);

    if (!isOverflow && !isCross)
      currentShift = shift;
    else
      exception = FigureException.downMove;
  }

  void moveBottom(List<Block> blocks) {
    exception = FigureException.none;

    while (exception != FigureException.downMove) {
      moveDown(blocks);
    }
  }

  void moveRight(List<Block> blocks) {
    final BorderIndex shift = currentShift + BorderIndex(1, 0);

    final isOverflow = this.isOverflow(shift);
    final isCross = this.isCross(shift: shift, allBlocks: blocks);

    if (!isOverflow && !isCross)
      currentShift = shift;
    else
      exception = FigureException.sideMove;
  }

  void moveLeft(List<Block> blocks) {
    final BorderIndex shift = currentShift + BorderIndex(-1, 0);

    final isOverflow = this.isOverflow(shift);
    final isCross = this.isCross(shift: shift, allBlocks: blocks);

    if (!isOverflow && !isCross)
      currentShift = shift;
    else
      exception = FigureException.sideMove;
  }

  void rotate(List<Block> blocks) {
    List<BorderIndex> rotatedComp = [];
    List.generate(matrix.matrixList.length, (column) {
      final matrixSize = matrix.matrixList.length - 1;
      List.generate(matrix.matrixList.length, (row) {
        if (matrix.matrixList[column][row] != null) {
          rotatedComp.add(BorderIndex(matrixSize - column, row));
        }
      });
    });

    final createdMatrix = FigureMatrix.create(
        figureComp: rotatedComp, size: matrix.matrixList.length);

    final isFigureCross = isCross(
      allBlocks: blocks,
      newMatrix: createdMatrix,
    );

    if (!isOverflow(null, createdMatrix) && !isFigureCross) {
      matrix = createdMatrix;
    }
  }

  bool isOverflow([BorderIndex shift, FigureMatrix newMatrix]) {
    return (newMatrix ?? matrix)
        .toFigureComp(shift ?? currentShift)
        .map((e) => e.isOverflow())
        .toList()
        .contains(false);
  }

  bool isCross(
      {BorderIndex shift,
      @required List<Block> allBlocks,
      FigureMatrix newMatrix}) {
    final List<BorderIndex> allBlockIndexes =
        allBlocks.map((e) => e.index).toList();

    final List<bool> crossList = (newMatrix ?? matrix)
        .toFigureComp(shift ?? currentShift)
        .map((figure) =>
            allBlockIndexes
                .map((block) => block.index).toList()
                .contains(figure.index) &&
            !(newMatrix ?? matrix)
                .toFigureComp(currentShift)
                .map((e) => e.index)
                .contains(figure.index))
        .toList();
    final result = crossList.contains(true);
    if (newMatrix != null)
      print(result.toString() + '         ' + DateTime.now().toString());
    exception = !result ? FigureException.none : exception;
    return result;
  }
}

class FigureMatrix {
  List<List<BorderIndex>> matrixList;

  FigureMatrix(this.matrixList);

  static FigureMatrix create({List<BorderIndex> figureComp, int size}) {
    final matrixList = List.generate(size, (column) {
      return List.generate(size, (row) {
        final borderIndex = BorderIndex(row, column);
        bool isContain = figureComp
            .map((index) => index.index)
            .toList()
            .contains(borderIndex.index);
        return isContain ? borderIndex : null;
      });
    });
    return FigureMatrix(matrixList);
  }

  void matrixDeformer(List<BorderIndex> list, BorderIndex shift) {
    final curIndexList = list.map((e) => e.index).toList();
    List.generate(matrixList.length, (row) {
      List.generate(matrixList[row].length, (el) {
        if (matrixList[row][el] != null &&
            curIndexList.contains((matrixList[row][el] + shift).index)) {
          matrixList[row][el] = null;
        }
      });
    });
  }

  void drawTheMatrix() {
    matrixList.forEach((matrixRow) {
      print(matrixRow.map((e) => e == null ? 'H' : 'o').toList());
    });
    print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
  }

  List<BorderIndex> toFigureComp(BorderIndex shift) {
    final List<BorderIndex> result = [];
    matrixList.forEach((row) {
      row.forEach((index) {
        if (index != null) {
          result.add(index + shift);
        }
      });
    });
    return result;
  }
}
