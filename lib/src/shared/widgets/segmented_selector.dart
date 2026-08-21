import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SegmentedSelector extends StatelessWidget {
  const SegmentedSelector({
    required this.labels,
    required this.selectedIndex,
    required this.onSelected,
    this.activeColor = const Color(0xFF303030),
    super.key,
  });

  final List<String> labels;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.darkGreen.withValues(alpha: 0.7)),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () => onSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? activeColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.mutedText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
