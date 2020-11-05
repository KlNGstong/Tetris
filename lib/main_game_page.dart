import 'package:flutter/material.dart';
import 'package:tetris/model/gameController.dart';
import 'package:tetris/widget/gameBoard.dart';

class MainGamePage extends StatefulWidget {
  @override
  _MainGamePageState createState() => _MainGamePageState();
}

class _MainGamePageState extends State<MainGamePage> {

  GameController gameController = GameController();

  @override
  void initState() {
    gameController.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: gameController.gesture.reset,
      onLongPress: gameController.onLongPress,
      onHorizontalDragUpdate: (details) => gameController.onDrag(
          gameController.gesture.get(details)
      ),
      onTap: gameController.onTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: GameBoard(
              gameController
            )
        ),
      ),
    );
  }
}
