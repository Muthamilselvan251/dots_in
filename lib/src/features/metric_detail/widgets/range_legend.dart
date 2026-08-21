import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class RangeLegend extends StatelessWidget {
  const RangeLegend({super.key});

  static const _ranges = [
    _RangeItem(Color(0xFFFF5B56), '< 4.46 mcg/dL', 'VERY LOW'),
    _RangeItem(Color(0xFFFF8A73), '< 8.46 mcg/dL', 'LOW'),
    _RangeItem(Color(0xFFFFDF16), '4.46 mcg/dL', 'MODERATE'),
    _RangeItem(Color(0xFFE1E600), '< 6.46 mcg/dL', 'OPTIMAL'),
    _RangeItem(Color(0xFF9BC62B), '8.46 - 9.2 mcg/dL', 'HIGH'),
    _RangeItem(Color(0xFF3DB648), '<10.46 -22.0 mg/dL', 'VERY HIGH'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 330 ? 1 : 2;
        const spacing = 12.0;
        final itemWidth =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: 12,
          children: _ranges
              .map(
                (range) => SizedBox(
                  width: itemWidth,
                  child: _RangeLegendItem(item: range),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _RangeLegendItem extends StatelessWidget {
  const _RangeLegendItem({required this.item});

  final _RangeItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 27,
          height: 27,
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: item.color.withValues(alpha: 0.55),
                blurRadius: 11,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 3),
              Text(item.label, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}

class _RangeItem {
  const _RangeItem(this.color, this.value, this.label);

  final Color color;
  final String value;
  final String label;
}
