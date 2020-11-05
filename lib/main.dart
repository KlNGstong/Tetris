import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'model/screenManage.dart';
import 'main_game_page.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    screenManage = ScreenManage(
        MediaQuery.of(context)
    );
    return MainGamePage();
  }
}
