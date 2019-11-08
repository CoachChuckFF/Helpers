import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main(){
  print("I dedicate this program to all of my fellow Confetti Lovers!");

  runApp(ConfettiRunner());
}

class ConfettiRunner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'It\'s Just Confetti!',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Confetti(1597, 8.0)
    );
  }
}


