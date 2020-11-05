import 'package:flutter/material.dart';
import 'package:tetris/model/border/boardConfig.dart';
import 'package:tetris/model/border/borderIndex.dart';
import 'package:tetris/model/gameController.dart';




class GameBoard extends StatefulWidget {

  GameBoard(
      this.borderController
  );
  final GameController borderController;

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  BoardConfig.boardSize.height,
      width: BoardConfig.boardSize.width,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              width: 2
          )
      ),
      child: Table(
        border: TableBorder.all(
          color: Colors.grey
        ),
        children: List.generate(
            BoardConfig.columns,
             (column) => TableRow(
                children: List.generate(
                    BoardConfig.rows,
                    (row) => square (
                      BorderIndex(
                          row,
                          column
                      )
                    )
                )
            )
        )
      ),
    );
  }

  Widget square (BorderIndex index) {
    return AnimatedBuilder(
        animation: this.widget.borderController,
        builder: (context, child) {
          final block = this.widget.borderController.blocks.findBlock(index);
          return SizedBox(
            width: BoardConfig.squareSize,
            height: BoardConfig.squareSize,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: block?.color ?? Colors.white,
                ),
              ),
            )
          );
        }
      );
  }
}
