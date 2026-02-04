import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SquareAnimation(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() => _SquareAnimationState();
}

class _SquareAnimationState extends State<SquareAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pont mozgása négyzetben')),
      body: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final t = controller.value;
            const size = 200.0;

            double x = 0, y = 0;

            if (t < 0.25) {
              x = size * (t / 0.25);
            } else if (t < 0.5) {
              x = size;
              y = size * ((t - 0.25) / 0.25);
            } else if (t < 0.75) {
              x = size * (1 - (t - 0.5) / 0.25);
              y = size;
            } else {
              y = size * (1 - (t - 0.75) / 0.25);
            }

            return CustomPaint(
              painter: SquarePainter(x, y),
              child: const SizedBox(width: size, height: size),
            );
          },
        ),
      ),
    );
  }
}

class SquarePainter extends CustomPainter {
  final double x, y;
  SquarePainter(this.x, this.y);

  @override
  void paint(Canvas canvas, Size size) {
    final square = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final point = Paint()..color = Colors.red;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      square,
    );
    canvas.drawCircle(Offset(x, y), 6, point);
  }

  @override
  bool shouldRepaint(_) => true;
}
