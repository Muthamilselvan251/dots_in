import 'dart:math' as math;
import 'package:flutter/material.dart';

class ConditionGauge extends StatelessWidget {
  const ConditionGauge({required this.value, required this.color, super.key});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 260,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: const Duration(milliseconds: 850),
          curve: Curves.easeOutCubic,
          builder: (context, animatedValue, child) {
            return CustomPaint(
              painter: _GaugePainter(value: animatedValue, color: color),
              child: Center(
                child: Text(
                  '${animatedValue.round()}%',
                  style: const TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final normalizedValue = value.clamp(0, 100).toDouble();
    final center = size.center(Offset.zero);
    final radius = size.shortestSide / 2 - 14;
    final outerPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, outerPaint);

    final tickPaint = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..strokeWidth = 1;
    for (var i = 0; i < 40; i++) {
      final angle = math.pi * 0.75 + i * math.pi * 1.5 / 39;
      final outer = Offset(
        center.dx + math.cos(angle) * (radius - 7),
        center.dy + math.sin(angle) * (radius - 7),
      );
      final innerLength = i % 5 == 0 ? 15.0 : 10.0;
      final inner = Offset(
        center.dx + math.cos(angle) * (radius - innerLength),
        center.dy + math.sin(angle) * (radius - innerLength),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }

    final progressRect = Rect.fromCircle(center: center, radius: radius - 32);
    canvas.drawArc(
      progressRect,
      math.pi * 0.75,
      math.pi * 1.5,
      false,
      Paint()
        ..color = Colors.white12
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawArc(
      progressRect,
      math.pi * 0.75,
      math.pi * 1.5 * normalizedValue / 100,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13
        ..strokeCap = StrokeCap.round,
    );

    final needleAngle = math.pi * 0.75 + math.pi * 1.5 * normalizedValue / 100;
    canvas.drawLine(
      center,
      Offset(
        center.dx + math.cos(needleAngle) * (radius - 53),
        center.dy + math.sin(needleAngle) * (radius - 53),
      ),
      Paint()
        ..color = Colors.white
        ..strokeWidth = 2.4
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(center, 5, Paint()..color = Colors.white);

    canvas.drawCircle(
      center,
      radius - 57,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.black, color.withValues(alpha: 0.13)],
        ).createShader(Rect.fromCircle(center: center, radius: radius - 57)),
    );
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}
