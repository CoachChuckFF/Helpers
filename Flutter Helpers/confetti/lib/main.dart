import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

void main() => runApp(ConfettiRunner());

class ConfettiRunner extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confetti Runner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Confetti(1000)
    );
  }
}


