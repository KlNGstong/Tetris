

import 'boardConfig.dart';

class BorderIndex {

  final int column;
  final int row;



  BorderIndex operator -(BorderIndex index) => BorderIndex(
    row - index.row,
    column - index.column
  );

  BorderIndex operator +(BorderIndex index) => BorderIndex(
    row + index.row,
    column + index.column
  );

  static BorderIndex get zero => BorderIndex(
    10 * 20 * 30 * 40 * 50,
    10 * 20 * 30 * 40 * 50
  );

  int get index => row + column * 100;

  BorderIndex(
    this.row,
    this.column
  );

  bool isOverflow () {
    return row >= 0 && column < BoardConfig.columns && row < BoardConfig.rows;
  }
}