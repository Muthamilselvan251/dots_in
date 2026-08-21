import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class RecoveryRecommendationCard extends StatelessWidget {
  const RecoveryRecommendationCard({
    required this.organName,
    required this.recommendations,
    super.key,
  });

  final String organName;
  final List<String> recommendations;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF510606), Color(0xFF170303), Colors.black],
        ),
        border: Border.all(color: const Color(0xFF8B2A2A)),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x5500D9FF),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personalized $organName health recommendations:',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(height: 1.35),
          ),
          const SizedBox(height: AppSpacing.md),
          ...List.generate(
            recommendations.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 22, child: Text('${index + 1}.')),
                  Expanded(
                    child: Text(
                      recommendations[index],
                      style: const TextStyle(fontSize: 12, height: 1.45),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
