import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/core/data/models/risk_item_model.dart';
import 'package:flutter/material.dart';

class RiskAssessmentCard extends StatelessWidget {
  const RiskAssessmentCard({required this.item, super.key});

  final RiskItemModel item;

  @override
  Widget build(BuildContext context) {
    final color = switch (item.status) {
      RiskStatus.low => const Color(0xFF00D264),
      RiskStatus.moderate => const Color(0xFFFF9800),
      RiskStatus.high => const Color(0xFFF23D43),
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.2), const Color(0xFF101812)],
        ),
        border: Border.all(color: color.withValues(alpha: 0.75)),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 12),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(Icons.health_and_safety_outlined, color: color),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  item.subtitle,
                  style: const TextStyle(color: AppColors.mutedText),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            item.score.toStringAsFixed(item.score % 1 == 0 ? 0 : 1),
            style: TextStyle(
              color: color,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
