import 'package:flutter/material.dart';


class Freetrial extends StatelessWidget {
  const Freetrial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF686BFF),
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).size.height - 250,
            left: 30,
            
            
            child: Image(image: AssetImage("assets/Mask.png"))
            ),

            Column(
              children: [
                
                SizedBox(height: 100,),
                Center(
                  child:Column(children: [
                      Text("Speak a new",style: TextStyle(fontSize: 30,fontFamily: "Arial",fontWeight: FontWeight.w500,color: Colors.white),),
                      Text("language now!",style: TextStyle(fontSize: 30,fontFamily: "Arial",fontWeight: FontWeight.w500,color: Colors.white)),
                  SizedBox(height: 40,),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [
                    MyContainer(text: "Unlock +2,700 lessons"),
                    MyContainer(text: "Smart Prononciation Correction"),
                    MyContainer(text: "Full Sleep Lessons Library"),
                    MyContainer(text: "20,000+ Visual Flashcards"),
                    MyContainer(text: "Voices by 90+ Native Speakers"),
                    MyContainer(text: "Everything in fluent"),
                  ],
                ),
              ),
            )
                  
                  ],),
                ),

                SizedBox(height: 90,),

                Container(
                  height: 50,
                  width: 328,
                  
                  child: FilledButton(onPressed: () {}, child: Text("Try it Free",style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Arial',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF686BFF),
                  ),),
                  style: FilledButton.styleFrom(
                    backgroundColor: Color(0xFFFFFFFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                  ),
                  
                  ),
                ),

                SizedBox(height: 20,),

                Text("3 Days free, then 5\$ per Semester",style: TextStyle(color: Color(0xFFFFFFFF),fontFamily: 'Arial',fontWeight: FontWeight.w700),),
                Text("Easily cancel anytime. You won't be charged now.",style: TextStyle(color: Color(0xFFFFFFFF),fontFamily: 'Arial'),),
              ],
            ),

            



            

        ],
      ),
    );
  }
}



class MyContainer extends StatelessWidget {
  final String text;
  MyContainer({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10), // Add vertical padding for spacing between items
      child: Row(
        children: [
          SizedBox(width: 25,),
          Image(image: AssetImage("assets/Check.png")),
          SizedBox(width: 10), 
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 20,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}