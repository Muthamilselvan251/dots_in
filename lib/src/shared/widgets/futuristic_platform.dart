import 'dart:math' as math;

import 'package:flutter/material.dart';

class FuturisticPlatform extends StatelessWidget {
  const FuturisticPlatform({this.height = 82, super.key});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -10),
      child: SizedBox(
        height: height + 34,
        width: double.infinity,
        child: const CustomPaint(painter: _PlatformPainter()),
      ),
    );
  }
}

class _PlatformPainter extends CustomPainter {
  const _PlatformPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.68);
    final platformWidth = math.min(size.width * 0.72, 270.0);
    final outerRect = Rect.fromCenter(
      center: center,
      width: platformWidth,
      height: size.height * 0.72,
    );

    final energyRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 72),
      width: platformWidth * 0.82,
      height: 190,
    );
    canvas.drawOval(
      energyRect,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.88),
            const Color(0xFFBDF7FF).withValues(alpha: 0.48),
            Colors.transparent,
          ],
          stops: const [0, 0.38, 1],
        ).createShader(energyRect),
    );

    canvas.drawOval(
      outerRect,
      Paint()
        ..color = const Color(0xFF0754CF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7,
    );

    final innerRect = Rect.fromCenter(
      center: center,
      width: platformWidth * 0.72,
      height: size.height * 0.48,
    );
    canvas.drawOval(
      innerRect,
      Paint()
        ..shader = const RadialGradient(
          colors: [Color(0xFFD4FCFF), Color(0xFF20C8FF), Color(0xFF0752DE)],
        ).createShader(innerRect),
    );

    canvas.drawArc(
      outerRect.deflate(9),
      -1.2,
      2.25,
      false,
      Paint()
        ..color = const Color(0xFFFF9B4A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 5,
    );

    final linePaint = Paint()
      ..color = const Color(0xFF4ADFFF).withValues(alpha: 0.8)
      ..strokeWidth = 1;
    for (var i = 0; i < 16; i++) {
      final angle = math.pi * 2 * i / 16;
      canvas.drawLine(
        Offset(
          center.dx + math.cos(angle) * platformWidth * 0.25,
          center.dy + math.sin(angle) * size.height * 0.15,
        ),
        Offset(
          center.dx + math.cos(angle) * platformWidth * 0.42,
          center.dy + math.sin(angle) * size.height * 0.28,
        ),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
