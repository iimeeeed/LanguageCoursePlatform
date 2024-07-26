import 'package:flutter/material.dart';
import 'level.dart';

class Goals extends StatefulWidget {
  const Goals({Key? key}) : super(key: key);



  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  List<MyContainer> goallist = [
    MyContainer(myicon: Icon(Icons.mic), mytext: Text("Practice speaking")),
    MyContainer(myicon: Icon(Icons.bed), mytext: Text("Sleep Learning")),
    MyContainer(myicon: Icon(Icons.speaker), mytext: Text("Improve my accent")),
    MyContainer(myicon: Icon(Icons.animation_outlined), mytext: Text("Watch Anime")),
    MyContainer(myicon: Icon(Icons.book), mytext: Text("Learn from scratch")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Text(
            "Choose your goal",
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color(0xFF525F7F),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "What are your mind goals? We will help you achieve them",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF98A3C7),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: goallist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: goallist[index],
                  );
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Level()),
                          );
              },
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF686BFF),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class MyContainer extends StatefulWidget {
  final Text mytext;
  final Icon myicon;

  MyContainer({required this.myicon, required this.mytext});

  @override
  _MyContainerState createState() => _MyContainerState();
}
class _MyContainerState extends State<MyContainer> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = !_isPressed;
        });
      },
      child: Container(
        width: 100,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _isPressed ? Color(0xFF4664EA) : Color.fromARGB(255, 225, 227, 231),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                widget.myicon.icon,
                color: _isPressed ? Colors.white : Colors.black, 
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  widget.mytext.data!,
                  style: TextStyle(
                    color: _isPressed ? Colors.white : Colors.black, 
                    fontSize: widget.mytext.style?.fontSize ?? 16,
                    fontWeight: widget.mytext.style?.fontWeight ?? FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
