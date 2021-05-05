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
    _anim1 = _controller.drive(CurveTween(curve: Curves.easeInOutExpo))
      ..addListener(() {
        setState(() {});
      });
    _anim2 = _controller.drive(CurveTween(curve: Curves.bounceOut));
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
          Opacity(
              opacity: _anim1.value,
              child: ScaleTransition(
              scale: _anim1, child: UsedItem('Language', usedLanguage)),
            ),
          Opacity(
              opacity: _anim2.value,
              child: ScaleTransition(scale: _anim2,
              child: UsedItem('Framework', usedFramework))),
          Opacity(
              opacity: _anim1.value,
              child: ScaleTransition(
                  scale: _anim1, child: UsedItem('Misc', usedEtc))),
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

    double fontScale = (size.width * 0.0006) + 1;
    return Container(
      width: size.width * 0.8,
      
      padding: EdgeInsets.all(size.height*0.05),
      margin: EdgeInsets.all(size.height*0.025),
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
            textScaleFactor: fontScale*1.5,
            style: TextStyle(
                letterSpacing: 1,
                
                color: subTextColor,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(offset: Offset(2, 2), blurRadius: 2)]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(content,
          textScaleFactor: fontScale,
              style: TextStyle(
                  letterSpacing: 1,
                  
                  color: Colors.black54,
                  fontStyle: FontStyle.italic)),
        ),
      ]),
    );
  }
}
