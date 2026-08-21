import 'dart:math' as math;
import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class HormoneChart extends StatelessWidget {
  const HormoneChart({required this.selectedIndex, super.key});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final title = selectedIndex == 0 ? 'Dopamine' : 'Serotonin';
    return Container(
      height: 285,
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 10),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.38),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.8)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            '$title Levels During Physical Activity',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: Row(
              children: [
                const RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    'Meditation Stats',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    key: ValueKey(selectedIndex),
                    tween: Tween(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 650),
                    curve: Curves.easeOutCubic,
                    builder: (context, progress, child) {
                      return CustomPaint(
                        painter: _HormoneChartPainter(
                          selectedIndex: selectedIndex,
                          progress: progress,
                        ),
                        child: const SizedBox.expand(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HormoneChartPainter extends CustomPainter {
  const _HormoneChartPainter({
    required this.selectedIndex,
    required this.progress,
  });

  final int selectedIndex;
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    const padding = EdgeInsets.fromLTRB(28, 12, 8, 24);
    final chart = Rect.fromLTRB(
      padding.left,
      padding.top,
      size.width - padding.right,
      size.height - padding.bottom,
    );

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 1;
    for (var i = 0; i <= 5; i++) {
      final y = chart.top + chart.height * i / 5;
      canvas.drawLine(Offset(chart.left, y), Offset(chart.right, y), gridPaint);
    }
    for (var i = 0; i <= 6; i++) {
      final x = chart.left + chart.width * i / 6;
      canvas.drawLine(Offset(x, chart.top), Offset(x, chart.bottom), gridPaint);
    }

    final baselinePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 1;
    const dash = 4.0;
    final baselineY = chart.top + chart.height * 0.48;
    for (double x = chart.left; x < chart.right; x += dash * 2) {
      canvas.drawLine(
        Offset(x, baselineY),
        Offset(math.min(x + dash, chart.right), baselineY),
        baselinePaint,
      );
    }

    final dopamine = [
      0.48,
      0.16,
      0.02,
      0.26,
      0.7,
      0.42,
      0.55,
      0.28,
      0.75,
      0.08,
      0.92,
      0.63,
    ];
    final serotonin = [
      0.58,
      0.22,
      0.1,
      0.32,
      0.56,
      0.43,
      0.35,
      0.68,
      0.26,
      0.78,
      0.48,
      0.34,
    ];
    final values = selectedIndex == 0 ? dopamine : serotonin;
    final linePath = Path();
    final fillPath = Path();

    for (var i = 0; i < values.length; i++) {
      final animatedValue = 0.48 + (values[i] - 0.48) * progress;
      final point = Offset(
        chart.left + chart.width * i / (values.length - 1),
        chart.top + chart.height * animatedValue,
      );
      if (i == 0) {
        linePath.moveTo(point.dx, point.dy);
        fillPath.moveTo(point.dx, chart.bottom);
        fillPath.lineTo(point.dx, point.dy);
      } else {
        linePath.lineTo(point.dx, point.dy);
        fillPath.lineTo(point.dx, point.dy);
      }
    }
    fillPath
      ..lineTo(chart.right, chart.bottom)
      ..close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.neonGreen.withValues(alpha: 0.2),
            Colors.transparent,
          ],
        ).createShader(chart),
    );
    canvas.drawPath(
      linePath,
      Paint()
        ..shader = const LinearGradient(
          colors: [
            AppColors.neonGreen,
            Color(0xFFFFFF00),
            Color(0xFFFF312D),
            AppColors.cyan,
          ],
        ).createShader(chart)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant _HormoneChartPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.progress != progress;
  }
}
