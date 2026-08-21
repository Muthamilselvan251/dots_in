import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/shared/widgets/metric_chip.dart';
import 'package:flutter/material.dart';

class RecommendationCard extends StatelessWidget {
  const RecommendationCard({
    required this.title,
    required this.intro,
    required this.bullets,
    required this.strengths,
    required this.weaknesses,
    super.key,
  });

  final String title;
  final String intro;
  final List<String> bullets;
  final List<String> strengths;
  final List<String> weaknesses;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.72),
        border: Border.all(color: AppColors.cyan),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withValues(alpha: 0.2),
            blurRadius: 14,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppSpacing.sm),
          Text(intro, style: const TextStyle(height: 1.5, fontSize: 12)),
          const SizedBox(height: AppSpacing.xs),
          ...bullets.map(
            (bullet) => Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('•  '),
                  Expanded(
                    child: Text(
                      bullet,
                      style: const TextStyle(height: 1.45, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          MetricGrid(title: 'Strengths :', values: strengths, isPositive: true),
          const SizedBox(height: AppSpacing.sm),
          MetricGrid(
            title: 'Weakness :',
            values: weaknesses,
            isPositive: false,
          ),
        ],
      ),
    );
  }
}
