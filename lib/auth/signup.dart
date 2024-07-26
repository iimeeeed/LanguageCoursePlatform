import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/goals.dart';

class Signup extends StatefulWidget {
  final TextStyle headerStyle;
  final TextStyle subheaderStyle;

  Signup({required this.headerStyle, required this.subheaderStyle});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formGlobalKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  bool _containsSpecialCharactersOrNumbers(String value) {
    RegExp specialCharOrNumberRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>\d]');
    return specialCharOrNumberRegex.hasMatch(value);
  }

  bool isValidEmail(String email) {
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
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Text("Create a Profile", style: widget.headerStyle),
                  ),
                  Text("Choose your account", style: widget.subheaderStyle),
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
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      label: Text("Name", style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16,
                      )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You must enter a name";
                      } else if (_containsSpecialCharactersOrNumbers(value)) {
                        return "Name must not contain special characters or numbers";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      label: Text("Username", style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16,
                      )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You must enter a username";
                      } else if (_containsSpecialCharactersOrNumbers(value)) {
                        return "Username must not contain special characters or numbers";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _email,
                    decoration: InputDecoration(
                      label: Text("Email", style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16,
                      )),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You must enter an email";
                      } else if (!isValidEmail(value)) {
                        return "You must enter a valid email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      label: Text("Password", style: TextStyle(
                        color: Color(0xFF98A3C7),
                        fontFamily: 'Arial',
                        fontSize: 16,
                      )),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "You must enter a password";
                      } else if (value.length < 8) {
                        return "Your password must contain at least 8 characters";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 100),
                  Container(
                    width: 366,
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        if (_formGlobalKey.currentState!.validate()) {
                          _signUp();
                        }
                      },
                      child: Text("Sign up", style: TextStyle(fontFamily: 'Arial', fontSize: 18)),
                      style: FilledButton.styleFrom(
                        backgroundColor: Color(0xFF686BFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
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

  Future<void> _signUp() async {
    try {
      // Create user with Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );

      // Check if user is created
      if (userCredential.user != null) {
        final data = {
          'name': _name.text,
          'username': _username.text,
        };

        final url = 'http://10.0.2.2/mycourseplatformAPI/register.php';

        final response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          if (responseData['status'] == 'success') {
            // Navigate to the Goals page if registration is successful
            Navigator.push(context, MaterialPageRoute(builder: (context) => Goals()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(responseData['message'])),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Request failed with status: ${response.statusCode}")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to sign up with Firebase. Please check your credentials and try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An unexpected error occurred: $e")),
      );
    }
  }
}
