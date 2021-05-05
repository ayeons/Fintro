import 'package:flutter/material.dart';

import 'main_page/main_page.dart';

void main() {
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Color(0xFFFFFCFC)
      ),
      home: MainPage(),
    );
  }
}
