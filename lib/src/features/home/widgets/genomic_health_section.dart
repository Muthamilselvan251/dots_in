import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/shared/widgets/condition_gauge.dart';
import 'package:dots_in/src/shared/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';

class GenomicHealthSection extends StatelessWidget {
  const GenomicHealthSection({super.key});

  static const _markers = [
    _GenomicMarker('Cardiovascular response', 'Favorable', true),
    _GenomicMarker('Vitamin D metabolism', 'Needs attention', false),
    _GenomicMarker('Muscle recovery', 'Favorable', true),
    _GenomicMarker('Caffeine sensitivity', 'Moderate', false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Genomic Health Overview',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF071A2F), Color(0xFF08110C)],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.cyan.withValues(alpha: 0.55)),
          ),
          child: Column(
            children: [
              Image.asset(
                AppAssets.dna,
                width: 500,
                height: 108,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Your genomic health profile',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Your DNA markers help explain how your body may respond to '
                'nutrition, exercise and everyday health habits.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.mutedText, height: 1.4),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Important Genomic Markers',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.md),
        ..._markers.map((marker) => _GenomicMarkerCard(marker: marker)),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Genomic wellness score',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        const ConditionGauge(value: 84, color: AppColors.cyan),
        const SizedBox(height: AppSpacing.lg),
        const RecommendationCard(
          title: 'Personalized Genomic Recommendation :',
          intro:
              'enomic profile can support practical lifestyle decisions. '
              'These results are wellness guidance and not a medical diagnosis.',
          bullets: [
            'Maintain regular cardiovascular and strength-based activity.',
            'Discuss vitamin D testing and supplementation with a health professional.',
            'Keep caffeine intake moderate, especially later in the day.',
          ],
          strengths: ['Heart response', 'Muscle recovery', 'Endurance'],
          weaknesses: ['Vitamin D', 'Caffeine', 'Sleep response'],
        ),
      ],
    );
  }
}

class _GenomicMarkerCard extends StatelessWidget {
  const _GenomicMarkerCard({required this.marker});

  final _GenomicMarker marker;

  @override
  Widget build(BuildContext context) {
    final color = marker.positive
        ? AppColors.neonGreen
        : const Color(0xFFFFA000);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.65)),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(Icons.hub_outlined, color: color),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              marker.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            marker.result,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _GenomicMarker {
  const _GenomicMarker(this.name, this.result, this.positive);

  final String name;
  final String result;
  final bool positive;
}
