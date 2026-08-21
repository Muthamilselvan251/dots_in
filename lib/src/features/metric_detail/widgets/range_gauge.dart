import 'dart:math' as math;

import 'package:dots_in/src/core/data/models/score_model.dart';
import 'package:flutter/material.dart';

class RangeGauge extends StatelessWidget {
  const RangeGauge({required this.score, required this.metricValue, super.key});

  final ScoreModel score;
  final double metricValue;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, progress, child) {
        return SizedBox(
          height: 205,
          child: CustomPaint(
            painter: _RangeGaugePainter(score, progress),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 2),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: const Color(0xFFFFD600)),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '${score.label} ${metricValue.toStringAsFixed(1)}',
                  style: const TextStyle(
                    color: Color(0xFFFFD600),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _RangeGaugePainter extends CustomPainter {
  const _RangeGaugePainter(this.score, this.progress);

  final ScoreModel score;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 52);
    final radius = math.min(size.width * 0.34, 120.0);
    final gaugeRect = Rect.fromCircle(center: center, radius: radius);

    for (final zone in score.zones) {
      final start = math.pi + math.pi * zone.from / 100;
      final sweep = math.pi * (zone.to - zone.from) / 100;
      canvas.drawArc(
        gaugeRect,
        start,
        sweep + 0.006,
        false,
        Paint()
          ..color = Color(zone.colorValue)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12,
      );
    }

    final needleAngle =
        math.pi + math.pi * score.value.clamp(0, 100) * progress / 100;
    final needleEnd = Offset(
      center.dx + math.cos(needleAngle) * (radius - 17),
      center.dy + math.sin(needleAngle) * (radius - 17),
    );
    canvas.drawLine(
      center,
      needleEnd,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawCircle(
      center,
      10,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      center,
      10,
      Paint()
        ..color = Colors.black45
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant _RangeGaugePainter oldDelegate) {
    return oldDelegate.score != score || oldDelegate.progress != progress;
  }
}
