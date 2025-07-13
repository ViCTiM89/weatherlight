import 'package:flutter/material.dart';

class ColorIdentityPie extends StatelessWidget {
  final List<String> colors;

  ColorIdentityPie({super.key, required this.colors});

  final Map<String, Color> colorMap = {
    'W': Colors.white,
    'U': Colors.blue,
    'B': Colors.black,
    'R': Colors.red,
    'G': Colors.green,
  };

  @override
  Widget build(BuildContext context) {
    final preferredOrder = ['W', 'U', 'B', 'R', 'G'];

    List<String> sortedColors = List<String>.from(colors);
    sortedColors.sort((a, b) =>
        preferredOrder.indexOf(a).compareTo(preferredOrder.indexOf(b)));

    // Map letters to colors
    List<Color> wedgeColors =
        sortedColors.map((c) => colorMap[c] ?? Colors.grey).toList();

    return CustomPaint(
      size: const Size(0, 0),
      painter: PiePainter(wedgeColors),
    );
  }
}

class PiePainter extends CustomPainter {
  final List<Color> colors;

  PiePainter(this.colors);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final sweepAngle = 2 * 3.141592653589793 / colors.length;
    double startAngle = -3.141592653589793 / 2; // start at top (12 o'clock)

    for (var color in colors) {
      paint.color = color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true, // use center (pie slice)
        paint,
      );
      startAngle += sweepAngle;
    }

    // Optional: Draw a black border circle around the pie
    final borderPaint = Paint()
      ..color = Colors.black26
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
