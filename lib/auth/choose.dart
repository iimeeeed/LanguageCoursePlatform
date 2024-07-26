import 'package:flutter/material.dart';
import 'signin.dart';
import 'signup.dart';


class Choose extends StatelessWidget {
  final TextStyle headerStyle = TextStyle(
    fontFamily: 'Arial',
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xFF525F7F),
  );

  final TextStyle subheaderStyle = TextStyle(
    fontFamily: 'Arial',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color(0xFF98A3C7),
  );

  ButtonStyle buttonStyle(Color backgroundColor, Color foregroundColor, Color borderColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: borderColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Already have an account?", style: headerStyle),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text("Continue where we left off", style: subheaderStyle),
                ),
                Container(
                  margin: EdgeInsets.only(top: 45),
                  width: 328,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(headerStyle: headerStyle,
      subheaderStyle: subheaderStyle,)));
                    },
                    child: Text("Sign in"),
                    style: buttonStyle(
                      Color(0xFF686BFF),
                      Colors.white,
                      Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 25),
              child: CustomPaint(
                
                painter: MyPainter(),
                size: Size(MediaQuery.of(context).size.width,2),

              ),
            ),
            Text("Are you new here?", style: headerStyle),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text("Start learning today!", style: subheaderStyle),
            ),
            Container(
              width: 328,
              height: 50,
              margin: EdgeInsets.only(top: 45),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup(headerStyle: headerStyle,
      subheaderStyle: subheaderStyle,)));                  
                },
                child: Text("Sign up"),
                style: buttonStyle(
                  Colors.white,
                  Color(0xFF686BFF),
                  Color(0xFF686BFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.strokeWidth = 2.0;
    paint.color = Colors.grey;
    canvas.drawLine(Offset.zero, Offset(size.width, 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
  
}

