import 'package:flutter/material.dart';
import 'package:suraksha_app/Entrypage.dart';
import 'package:suraksha_app/Login.dart';
import 'package:suraksha_app/Newentry.dart';
import 'package:suraksha_app/Opening.dart';
import 'package:suraksha_app/Registeruser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Suraksha",
      home: Scaffold(
         resizeToAvoidBottomInset: false,
         body: Container(
          decoration: BoxDecoration(
            image:DecorationImage(
              image: AssetImage('assets/123.jfif'),
              fit: BoxFit.cover,
            )
          ),
           child: opening()
         ),
      ),
    );
  }
}



