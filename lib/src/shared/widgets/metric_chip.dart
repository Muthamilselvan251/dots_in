import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class MetricChip extends StatelessWidget {
  const MetricChip({required this.label, required this.isPositive, super.key});

  final String label;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppColors.neonGreen : AppColors.danger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '0.05',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 9.5, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class MetricGrid extends StatelessWidget {
  const MetricGrid({
    required this.title,
    required this.values,
    required this.isPositive,
    super.key,
  });

  final String title;
  final List<String> values;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        LayoutBuilder(
          builder: (context, constraints) {
            const spacing = 8.0;
            final columns = constraints.maxWidth < 320 ? 2 : 3;
            final itemWidth =
                (constraints.maxWidth - spacing * (columns - 1)) / columns;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: values
                  .map(
                    (value) => SizedBox(
                      width: itemWidth,
                      child: MetricChip(label: value, isPositive: isPositive),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
