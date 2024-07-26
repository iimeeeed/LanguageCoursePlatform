import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../pages/goals.dart';


class Signin extends StatefulWidget {
  final TextStyle headerStyle;
  final TextStyle subheaderStyle;

  Signin({required this.headerStyle, required this.subheaderStyle});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final _formGlobalKey = GlobalKey<FormState>();

  FirebaseAuthServices _auth = FirebaseAuthServices();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }



  bool _containsSpecialCharactersOrNumbers(String value) {
    // Define the pattern of special characters and numbers to disallow
    RegExp specialCharOrNumberRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>\d]');
    return specialCharOrNumberRegex.hasMatch(value);
  }

  bool isValidEmail(String email) {
  // Regex pattern for a valid email address
  // This pattern allows for a wide range of characters before the @ symbol,
  // but enforces that the domain has at least one period and that the entire
  // email address is between 6 and 320 characters long.
  final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
  return regex.hasMatch(email);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            
            child: Container(
              margin: EdgeInsets.only(top: 150),
              child: Column(
                
                children: [
                  Container(margin: EdgeInsets.only(bottom: 10),child: Text("Sign in to your account",style: widget.headerStyle)),
                  Text("Continue learning !",style: widget.subheaderStyle),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          
          Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formGlobalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  

                      TextFormField(controller: _email,decoration: InputDecoration(label: Text("Email",style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16
                      )
                      ,)
                      ,),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.length == 0 ) {
                        return "You must enter an email";
                      }
                      else if (!isValidEmail(value)){
                        return "You must enter a valid email";
                      }
                     
                      else {return null;}
                      },
                      ),
                      SizedBox(height: 12),

                      TextFormField(controller: _password,decoration: InputDecoration(label: Text("Password",style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16
                      )
                      ,)
                      ,),
                      obscureText: true,
                      
                      validator: (value) {
                        if (value == null || value.length == 0) {
                        return "You must enter a password";
                      }
                      if (value.length < 8 ) {
                        return "Your password must contain at least 8 characters";
                      }
                      
                      else {return null;}
                      },
                      ),
                  SizedBox(height: 100),
                  Container(
                    width: 366,
                    height: 50,
                    child: FilledButton(onPressed: () {
                     if (_formGlobalKey.currentState!.validate()) {
                          _Signin();
                          
                        }
                        }, child: Text("Sign in",style: TextStyle(fontFamily: 'Arial',fontSize: 18),),
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFF686BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ) 
                    
                    ),
                    ),
                  ),

                  
                ],

              ),
            ),
          ),

        ],
      ),
    );
  }

  void _Signin() async {
    try {
      User? user = await _auth.signUInithEmailAndPassword(_email.text, _password.text);

      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Goals()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to sign in. Please check your credentials and try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred: $e")),
      );
    }
  }
}

