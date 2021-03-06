import 'dart:html';

import 'package:fintro/resources/const.dart';
import 'package:fintro/resources/widgets.dart';
import 'package:flutter/material.dart';

import 'discription_area.dart';
import 'image_area.dart';
import 'used_area.dart';


class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool minwidth = false;
  bool _isStart = false;

  int _activeNum = 0;
  bool isReactive = false;

  int get activeNum => _activeNum;

  setActiveNum(i) {
    setState(() {
      _activeNum = i;
      isReactive = true;
    });
  }

  bool get isStart => _isStart;
  setIsStart() {
    setState(() {
      _isStart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    if (mq.size.width < 700) {
      minwidth = true;
    } else {
      minwidth = false;
    }
    return Container(
      foregroundDecoration:
          BoxDecoration(color: minwidth ? Color(0x80FFFFFF) : null),
      child: Scaffold(
        floatingActionButton: Container(
          height: 70,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.grey.shade100,
            onPressed: () {
              window.history.back();
            },
            label: Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: 50,
                ),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "BACK",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.black54),
                    )),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: minwidth
            ? Stack(
                children: [
                  Container(
                    width: (mq.size.width * 0.1) + 100,
                    height: mq.size.height,
                    color: leftBarColor,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: mq.size.width * 0.015,
                              vertical: mq.size.height * 0.05),
                          child: Text("FlutterWeb",
                              textScaleFactor: (mq.size.width * 0.001) + 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic)),
                        ),
                        Divider(
                          indent: (mq.size.width * 0.04) + 30,
                          endIndent: (mq.size.width * 0.04) + 30,
                          thickness: 5,
                        ),
                        Padding(
                            padding: EdgeInsets.all(mq.size.height * 0.03),
                            child: Text("LANGLE",
                                textScaleFactor: (mq.size.width * 0.0007) + 1,
                                style: TextStyle(color: Colors.blue))),
                        Padding(
                            padding: EdgeInsets.all(mq.size.height * 0.03),
                            child: Text("Mari",
                                textScaleFactor: (mq.size.width * 0.0007) + 1,
                                style: TextStyle(color: Colors.black45))),
                        Padding(
                            padding: EdgeInsets.all(mq.size.height * 0.03),
                            child: Text("YOLO_Mark",
                                textScaleFactor: (mq.size.width * 0.0007) + 1,
                                style: TextStyle(color: Colors.black45))),
                        Divider(
                          indent: (mq.size.width * 0.04) + 30,
                          endIndent: (mq.size.width * 0.04) + 30,
                          thickness: 5,
                        ),
                        Padding(
                            padding: EdgeInsets.all(mq.size.height * 0.03),
                            child: Text("Used",
                                textScaleFactor: (mq.size.width * 0.0007) + 1,
                                style: TextStyle(color: Colors.black45))),
                        RepaintBoundary(
                          child: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(mq.size.height * 0.05),
                              child: CustomPaint(
                                painter: LogoPainter(
                                    logo: Logo.Round, msize: mq.size),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  Center(
                      child: Text("this page for PC. scale up!",
                          style: TextStyle(
                              fontSize: 30,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)))
                ],
              )
            : MainBody(),
      ),
    );
  }
}

class GlobalS extends InheritedWidget {
  final _MainBodyState state;

  GlobalS(this.state, {Widget child}) : super(child: child);
  static _MainBodyState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalS>().state;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  bool _isStart = false;

  int _activeNum = 0;
  bool isReactive = false;

  int get activeNum => _activeNum;

  setActiveNum(i) {
    setState(() {
      _activeNum = i;
      isReactive = true;
    });
  }

  bool get isStart => _isStart;
  setIsStart() {
    setState(() {
      _isStart = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlobalS(
      this,
      child: Row(
        children: [
          LeftBar(),
          Flexible(
            child: _activeNum == 3
                ? UsedArea()
                : MediaQuery.of(context).size.width > 1200
                    ? SingleChildScrollView(
                        child: Row(
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                  child: HVRatioImageArea()),
                            ),
                            Flexible(
                              child: SingleChildScrollView(
                                  child: HVRatiodiscriptionArea(false)),
                            ),
                          ],
                        ),
                      )
                    : Scrollbar(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              HVRatioImageArea(),
                              HVRatiodiscriptionArea(true)
                            ],
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class HVRatioImageArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int activeNum = GlobalS.of(context).activeNum;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: activeNum == 0
          ? ImageArea(
              "images/book-splash.png",
              'https://play.google.com/store/apps/details?id=com.ayeons.favorite_word',
              false)
          : activeNum == 1
              ? ImageArea("images/foodD.mp4", '', true)
              : activeNum == 2
                  ? ImageArea('images/st.jpg',
                      'https://github.com/ayeons/yolo_mark_lite_python', false)
                  : SizedBox.shrink(),
    );
  }
}

class HVRatiodiscriptionArea extends StatelessWidget {
  final bool isv;
  HVRatiodiscriptionArea(this.isv);
  @override
  Widget build(BuildContext context) {
    int activeNum = GlobalS.of(context).activeNum;
    return activeNum == 0
        ? DiscriptionText(isv, 'LANGLE', langleText,
            'https://play.google.com/store/apps/details?id=com.ayeons.favorite_word')
        : activeNum == 1
            ? DiscriptionText(isv, 'Mari', mariText, '')
            : activeNum == 2
                ? DiscriptionText(isv, 'YOLO_Mark', yoloText,
                    'https://github.com/ayeons/yolo_mark_lite_python')
                : SizedBox.shrink();
  }
}

class LeftBar extends StatefulWidget {
  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation _anim;

  AnimationController xcontroller;
  AnimationController ycontroller;
  AnimationController _ocontroller;
  Animation _oanim;
  @override
  void initState() {
    xcontroller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
      upperBound: 4,
      lowerBound: -5,
    );
    ycontroller = AnimationController(
        duration: Duration(milliseconds: 500),
        vsync: this,
        upperBound: 1,
        lowerBound: -5);
    xcontroller.addListener(() {
      setState(() {
        if (xcontroller.isCompleted) {
          var gs = GlobalS.of(context);
          gs.setIsStart();
          gs.setActiveNum(gs.activeNum);
        }
        if (xcontroller.isDismissed) {
          print('fff');
        }
      });
    });

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   var gs = GlobalS.of(context);
    //   gs.setIsStart();
    //   gs.setActiveNum(gs.activeNum);
    // });

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _controller.addListener(() {
      setState(() {});
    });
    _anim = _controller
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(Tween(begin: 0, end: 40));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    _controller.forward();
    _ocontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _oanim = CurveTween(curve: Curves.easeOut).animate(_ocontroller);
    _ocontroller
      ..addListener(() {
        setState(() {});
      });

    xcontroller.animateWith(IntroSimul(IntroSimulationPath.Sin));
    ycontroller.animateWith(IntroSimul(IntroSimulationPath.Cos));
    _ocontroller.forward();

    super.initState();
  }

  @override
  void dispose() {
    xcontroller.dispose();
    ycontroller.dispose();
    _controller.dispose();
    _ocontroller.dispose();
    super.dispose();
  }

  void controllerGo(int i) {
    GlobalS.of(context).setActiveNum(i);
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Opacity(
      opacity: _oanim.value,
      child: Container(
        width: (mq.size.width * 0.1) + 100,
        height: mq.size.height,
        color: leftBarColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mq.size.width * 0.015,
                    vertical: mq.size.height * 0.12),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        window.location.reload();
                      },
                      child: Text("FlutterWeb",
                          textScaleFactor: (mq.size.width * 0.001) + 1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ),
                    Align(alignment: Alignment.topCenter,
                        child: Transform(
                                                  transform: Matrix4.translationValues(mq.size.width*0.005, mq.size.height*-0.05, 0),
                                                  child: RepaintBoundary(
                            child: GlobalS.of(context).isStart
                                ? CustomPaint(
                                    painter: LogoPainter(
                                        logo: Logo.Edge,
                                        penColor: Color(0xF0504030),
                                        msize: mq.size))
                                : Transform(
                                    transform: Matrix4.translationValues(
                                        xcontroller.value * 0.1 * mq.size.width +
                    (mq.size.width * 0.5),
                                        ycontroller.value * 0.1 * mq.size.height +
                    (mq.size.height * 0.5),
                                        0),
                                    child: CustomPaint(
                                      painter: LogoPainter(
                                          logo: Logo.Edge, msize: mq.size),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              RepaintBoundary(
                child: CustomPaint(
                  painter: GlobalS.of(context).activeNum == 0
                      ? ActivePainter(_anim.value)
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.015,
                        vertical: mq.size.height * 0.03),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0x150000FF))),
                        onPressed: () {
                          controllerGo(0);
                        },
                        child: Text("LANGLE",
                            textScaleFactor: (mq.size.width * 0.0005) + 1,
                            style: TextStyle(
                                color: GlobalS.of(context).activeNum == 0
                                    ? Colors.blueAccent.shade200
                                    : Colors.brown.shade600))),
                  ),
                ),
              ),
              RepaintBoundary(
                child: CustomPaint(
                  painter: GlobalS.of(context).activeNum == 1
                      ? ActivePainter(_anim.value)
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.015,
                        vertical: mq.size.height * 0.03),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0x150000FF))),
                        onPressed: () {
                          controllerGo(1);
                        },
                        child: Text("Mari",
                            textScaleFactor: (mq.size.width * 0.0005) + 1,
                            style: TextStyle(
                                color: GlobalS.of(context).activeNum == 1
                                    ? Colors.blueAccent.shade200
                                    : Colors.black45))),
                  ),
                ),
              ),
              RepaintBoundary(
                child: CustomPaint(
                  painter: GlobalS.of(context).activeNum == 2
                      ? ActivePainter(_anim.value)
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.015,
                        vertical: mq.size.height * 0.03),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0x150000FF))),
                        onPressed: () {
                          controllerGo(2);
                        },
                        child: Text("YOLO_Mark",
                            textScaleFactor: (mq.size.width * 0.0005) + 1,
                            style: TextStyle(
                                color: GlobalS.of(context).activeNum == 2
                                    ? Colors.blueAccent.shade200
                                    : Colors.black45))),
                  ),
                ),
              ),
              Divider(
                indent: (mq.size.width * 0.04) + 30,
                endIndent: (mq.size.width * 0.04) + 30,
                thickness: 5,
              ),
              RepaintBoundary(
                child: CustomPaint(
                  painter: GlobalS.of(context).activeNum == 3
                      ? ActivePainter(_anim.value)
                      : null,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.015,
                        vertical: mq.size.height * 0.03),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0x150000FF))),
                        onPressed: () {
                          controllerGo(3);
                        },
                        child: Text("Used",
                            textScaleFactor: (mq.size.width * 0.0005) + 1,
                            style: TextStyle(
                                color: GlobalS.of(context).activeNum == 3
                                    ? Colors.blueAccent.shade200
                                    : Colors.black45))),
                  ),
                ),
              ),
              RepaintBoundary(
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.size.width * 0.015,
                        vertical: mq.size.height * 0.05),
                    child: CustomPaint(
                      painter: LogoPainter(logo: Logo.Round, msize: mq.size),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
