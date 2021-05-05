import 'package:fintro/main_page/main_page.dart';
import 'package:fintro/resources/const.dart';
import 'package:flutter/material.dart';

class UsedArea extends StatefulWidget {
  @override
  _UsedAreaState createState() => _UsedAreaState();
}

class _UsedAreaState extends State<UsedArea>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _anim1;
  Animation _anim2;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _anim1 = _controller.drive(CurveTween(curve: Curves.bounceOut))
      ..addListener(() {
        setState(() {});
      });
    _anim2 = _controller.drive(CurveTween(curve: Curves.easeIn));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (GlobalS.of(context).isReactive) {
      _controller.reset();
      _controller.forward();
    }
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: GlobalS.of(context).isStart,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Center(
              child: Opacity(
            opacity: _anim1.value,
            child: SizeTransition(
                sizeFactor: _anim1, child: UsedItem('Language', usedLanguage)),
          )),
          Opacity(
              opacity: _anim2.value,
              child: UsedItem('Framework', usedFramework)),
          Opacity(
              opacity: _anim1.value,
              child: SizeTransition(
                  sizeFactor: _anim1, child: UsedItem('Misc', usedEtc))),
        ],
      )),
    );
  }
}

class UsedItem extends StatelessWidget {
  final String sub;
  final String content;
  UsedItem(this.sub, this.content);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double fontSize = (size.width + size.width) * 0.01;
    return Container(
      width: size.width * 0.8,
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.all(13),
      decoration: BoxDecoration(
          color: Color(0xFFFFFDFD),
          borderRadius: BorderRadius.circular(
            50,
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 4),
                blurRadius: 1,
                spreadRadius: 1,
                color: Color(0xAA000000))
          ]),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            sub,
            style: TextStyle(
                letterSpacing: 1,
                fontSize: fontSize * 1.5,
                color: subTextColor,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(offset: Offset(1, 1), blurRadius: 1)]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(content,
              style: TextStyle(
                  letterSpacing: 1,
                  fontSize: fontSize,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic)),
        ),
      ]),
    );
  }
}
