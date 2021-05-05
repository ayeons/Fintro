import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class TrianglePaint extends CustomPainter {
  Random random = Random();
  bool sss = false;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = Color(0x90807060);
    Path path = Path();
    double a1 = random.nextDouble() * 100;
    double a2 = random.nextDouble() * 100;
    double b1 = random.nextDouble() * 100;
    double b2 = random.nextDouble() * 100;
    double c1 = random.nextDouble() * 100;
    double c2 = random.nextDouble() * 100;
    double d1 = random.nextDouble() * 100;
    double d2 = random.nextDouble() * 100;
    double e1 = random.nextDouble() * 100;
    double e2 = random.nextDouble() * 100;
    print('$a1 $a2 $b1 $b2 $c1 $c2 $d1 $d2 $e1 $e2');
    path..lineTo(a1, a2);
    path..lineTo(b1, b2);
    path..lineTo(c1, c2);
    path..lineTo(d1, d2);
    path..lineTo(e1, e2);

    path..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

enum Logo { Edge, Round }

class LogoPainter extends CustomPainter {
  Color penColor;
  Size msize;
  List<double> pathList;
  LogoPainter({@required Logo logo,this.penColor=const Color(0xF0706050),@required this.msize}){
    switch (logo.index) {
      case 0:
        pathList = [37, 77, 85, 3, 40, 71, 2.5, 60, 48, 84];
        break;
      case 1:
        pathList = [1.5, 82, 20, 21, 46, 5, 20, 1, 48, 93];
        break;
      default:
    }
  }
  @override
  void paint(Canvas canvas, Size size) {
    
    Paint pen = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..color = penColor;
    Path path = Path();
    path
      ..lineTo(pathList[0]*msize.width*0.0005, pathList[1]*msize.width*0.0005)
      ..lineTo(pathList[2]*msize.width*0.0005, pathList[3]*msize.width*0.0005)
      ..lineTo(pathList[4]*msize.width*0.0005, pathList[5]*msize.width*0.0005)
      ..lineTo(pathList[6]*msize.width*0.0005, pathList[7]*msize.width*0.0005)
      ..lineTo(pathList[8]*msize.width*0.0005, pathList[9]*msize.width*0.0005)
      ..close();
    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ActivePainter extends CustomPainter {
  double value;
  
  ActivePainter(this.value);
  @override
  void paint(Canvas canvas, Size size) {

    Paint pen = Paint()
      ..strokeWidth=8
      ..color=Color(0xFFFFFCFC)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
      
    
    // Path path = Path()
    //   ..moveTo(size.width * 0.5, size.height * 0.8)
    //   ..relativeCubicTo(-120, -30, 140, -80, -20, 5);
    Path path=Path()
    ..moveTo(size.width * 0.2, size.height * 0.7 )
    ..lineTo(size.width*0.2+value*(size.width*0.015), size.height*0.7);
    
    canvas.drawPath(path, pen);
    
  }

  @override
  bool shouldRepaint(covariant ActivePainter oldDelegate) {
    return oldDelegate.value!=value;
  }
}

// 37,77,85,3,40,71,2.5,60,48,84
// 1.5,82,20,21,46,5,20,1,48,93
enum IntroSimulationPath { Sin, Cos }

class IntroSimul extends Simulation {
  Function f;
  IntroSimul(IntroSimulationPath path) {
    switch (path) {
      case IntroSimulationPath.Sin:
        f = msin;
        break;
      case IntroSimulationPath.Cos:
        f = cos;
        break;
    }
  }
  
  double i = 0;

  double msin(num r) {
    return sin(r) * 3;
  }

  double afterDone(num s) {
    var ss = SpringSimulation(
        SpringDescription(mass: 30, damping: 1, stiffness: 1), 0, -5, 0.05);
    return ss.x(i += 0.01);
  }

  @override
  double dx(double time) {
    return time;
  }

  @override
  bool isDone(double time) {
    
    if (time >  pi* 0.5 && f != afterDone) {
      f = afterDone;
    }
    if (time > pi * 0.9) {
      return true;
    }
    return false;
  }

  @override
  double x(double time) {
    return f(time * 4);
  }
}
