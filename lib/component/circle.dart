import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key? key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff24573F);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, 149),
        height: size.height / 2,
        width: size.width,
      ),
      math.pi,
      -math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CircleCounter extends CustomPainter {
  int counter = 0;
  int target = 0;

  CircleCounter({required int counter, required int target}) {
    this.counter = counter;
    this.target = target;
  }

  static lastCountColor(int lastCount, int target) {
    var percentage = lastCount / target * 100;
    if (percentage > 0 && percentage <= 33) return Color(0xffE8F0EF);
    if ((percentage > 33 && percentage <= 66))
      return Color(0xffAF9C4D);
    else
      return Color(0xff24573F);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // draw the circle indicator
    final rect = Rect.fromLTRB(-70, -70, 70, 70);
    final startAngle = -math.pi / 2;
    final sweepAngle = ((math.pi * 2) / (target / counter * 100) * 100);
    final useCenter = false;
    final paint1 = Paint()
      ..color = lastCountColor(counter, target)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
    final paint2 = Paint()
      ..color = Color(0xffE4E4E4)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;
    canvas.drawArc(rect, startAngle, math.pi * 2, useCenter, paint2);
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint1);

    // draw the number of counter inside Arc
    final textStyle = TextStyle(
      color: Color(0xff2F6149),
      fontSize: 40,
      fontWeight: FontWeight.bold,
    );
    final textSpan = TextSpan(
      text: counter.toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 50, maxWidth: 100);
    Offset drawPosition =
        Offset(-(textPainter.width / 2), -(textPainter.height / 2));
    textPainter.paint(canvas, drawPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
