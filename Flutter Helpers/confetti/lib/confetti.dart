import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';


class Confetti extends StatefulWidget {
  final int numberOfConfetti;
  final double size;

  Confetti(this.numberOfConfetti, [this.size = 13.0]);

  @override
  _ConfettiState createState() => _ConfettiState();
}

class _ConfettiState extends State<Confetti> {
  final Random random = Random();

  final List<ConfettiModel> Confettis = [];

  @override
  void initState() {
    List.generate(widget.numberOfConfetti, (index) {
      Confettis.add(ConfettiModel(random, widget.size));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateConfetti,
      builder: (context, time) {
        return CustomPaint(
          painter: ConfettiPainter(Confettis, time),
        );
      },
    );
  }

  _simulateConfetti(Duration time) {
    Confettis.forEach((particle) => particle.maintainRestart(time));
  }
}

class ConfettiModel {
  Animatable tween;
  double size;
  double width;
  double height;
  Color color;
  double _ratio = 1.61803398875;
  AnimationProgress animationProgress;
  Random random;

  static List<Color> _colors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.white,
    Colors.black,
    Colors.amber,
    Colors.indigo,
    Colors.cyan,
    Colors.grey,
    Colors.lime,
  ];

  ConfettiModel(this.random, this.size) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(1.2 - (1.4 * random.nextDouble()), -0.2);
    final endPosition = Offset(1.2 - (1.4 * random.nextDouble()), 1.2);
    final duration = Duration(milliseconds: 4181 + random.nextInt(6765));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);

    animationProgress = AnimationProgress(duration: duration, startTime: time);

    height = size;
    width = size * _ratio;
    color = _colors[random.nextInt(_colors.length)];
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}

class ConfettiPainter extends CustomPainter {
  List<ConfettiModel> Confettis;
  Duration time;

  ConfettiPainter(this.Confettis, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    
    Confettis.forEach((particle) {
      final paint = Paint()..color = particle.color;
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);

      canvas.drawRect(Rect.fromLTWH(position.dx, position.dy, particle.width, particle.height), paint);

    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
