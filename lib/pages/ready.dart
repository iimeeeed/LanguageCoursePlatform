import 'package:flutter/material.dart';
import 'freeTrial.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _controller.addListener(() {
      setState(() {
        _percentage = _controller.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Freetrial()));
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final TextStyle _style = TextStyle(
    fontFamily: 'Arial',
    fontSize: 30,
    color: Color(0xFF525F7F),
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Center(
            child: CustomPaint(
              painter: MyCircle(),
              size: Size(200, 200),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/fox.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: Column(
              children: [
                Text('Preparing your', style: _style,),
                Text('Suuuuper course!', style: _style),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Center(
            child: CustomPaint(
              painter: MyLine(percentage: _percentage),
              size: Size(320, 10),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCircle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = Color(0xFFEEF0F7);
    canvas.drawCircle(Offset(size.width/2, size.height/2), 60, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MyLine extends CustomPainter {
  final double percentage;

  MyLine({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintRRect = Paint()
      ..color = Color(0xFFEEF0F7)
      ..style = PaintingStyle.fill;

    Paint paintRRectFill = Paint()
      ..color = Color(0xFF71E9AF)
      ..style = PaintingStyle.fill;

    RRect rrect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(size.width/2, size.height/2),
        width: size.width,
        height: size.height,
      ),
      Radius.circular(20.0),
    );

    RRect rrectFill = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width * percentage, size.height),
      Radius.circular(20.0),
    );

    canvas.drawRRect(rrect, paintRRect);
    canvas.drawRRect(rrectFill, paintRRectFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

