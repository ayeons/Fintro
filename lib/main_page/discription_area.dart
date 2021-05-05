import 'dart:html';

import 'package:fintro/resources/const.dart';
import 'package:flutter/material.dart';

import 'main_page.dart';

class DiscriptionText extends StatefulWidget {
  final bool isv;
  final String sub;
  final String text;
  final String link;

  DiscriptionText(this.isv, this.sub, this.text, this.link);
  @override
  _DiscriptionTextState createState() => _DiscriptionTextState();
}

class _DiscriptionTextState extends State<DiscriptionText>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _anim;
  double fontSize;
  TextDecoration deco;
  @override
  void initState() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _anim = _controller.drive(CurveTween(curve: Curves.decelerate));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    var gs = GlobalS.of(context);

    if (gs.isReactive) {
      _controller.reset();
      _controller.forward();
      gs.isReactive = false;
    }
    _controller.forward();
    super.didChangeDependencies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    fontSize = (size.width * 0.018)+2;
    var gs = GlobalS.of(context);
    return Visibility(
      maintainState: true,
      visible: gs.isStart,
      child: SizeTransition(
        sizeFactor: _anim,
        child: FadeTransition(
          opacity: _anim,
          child: Container(
              height: widget.isv ? size.height * 0.4 : size.height * 0.8,
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.only(left:50,right:50,bottom:50,top:30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.elliptical(200, 100)),
                  color: Color(0xFCFFFFFF),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(3, 4),
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom:20),
                        child: Center(
                            child: InkWell(
                          onHover: (value) {
                            setState(() {
                              deco = value ? TextDecoration.underline : null;
                            });
                          },
                          onTap: () {
                            window.location.href = widget.link;
                          },
                          child: Text(widget.sub,
                              style: TextStyle(
                                letterSpacing: 1,
                                  decoration: deco,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decorationColor: Colors.black38,
                                  decorationThickness: 3,
                                  fontSize: fontSize * 1.5,
                                  color: subTextColor,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(offset: Offset(1, 1), blurRadius: 1)
                                  ])),
                        )),
                      ),
                      Center(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            letterSpacing: 1,
                              fontSize: fontSize,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
