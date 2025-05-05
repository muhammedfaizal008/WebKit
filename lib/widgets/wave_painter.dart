// First, create a custom wave painter
import 'dart:math';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final Color color;
  final double amplitude;

  WavePainter({
    required this.color,
    this.amplitude = 20.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    
    // Start from bottom left
    path.moveTo(0, size.height);
    
    // Draw bottom line
    path.lineTo(0, size.height * 0.65);
    
    // Draw the first wave
    for (int i = 0; i < size.width.toInt(); i++) {
      final x = i.toDouble();
      final amplitude = this.amplitude;
      final period = size.width * 0.7;
      final y = size.height * 0.65 - amplitude * sin((2 * pi * x) / period);
      path.lineTo(x, y);
    }
    
    // Draw the line to bottom right corner
    path.lineTo(size.width, size.height * 0.65);
    path.lineTo(size.width, size.height);
    
    // Close the path
    path.close();
    
    // Draw the path
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}