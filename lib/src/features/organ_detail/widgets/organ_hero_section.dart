import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/core/data/models/organ_model.dart';
import 'package:dots_in/src/shared/widgets/futuristic_platform.dart';
import 'package:flutter/material.dart';

class OrganHeroSection extends StatelessWidget {
  const OrganHeroSection({required this.organ, this.onViewDetails, super.key});

  final OrganModel organ;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final first = organ.callouts.isNotEmpty ? organ.callouts[0] : null;
    final second = organ.callouts.length > 1 ? organ.callouts[1] : null;
    final third = organ.callouts.length > 2 ? organ.callouts[2] : null;
    return Column(
      children: [
        Text(
          organ.id == 'overall-health'
              ? 'Health Conditions Overview'
              : '${organ.name} Conditions Overview',
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          height: 282,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageSize = (constraints.maxWidth * 0.72)
                  .clamp(210.0, 270.0)
                  .toDouble();
              final imageLeft = (constraints.maxWidth - imageSize) / 2;
              double anchorX(CalloutModel? callout, double fallback) =>
                  imageLeft + imageSize * (callout?.anchor.dx ?? fallback);
              double anchorY(CalloutModel? callout, double fallback) =>
                  imageSize * (callout?.anchor.dy ?? fallback);
              const calloutWithAnchor = 152.0;
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonGreen.withValues(alpha: 0.18),
                            blurRadius: 65,
                          ),
                        ],
                      ),
                      child: TweenAnimationBuilder<double>(
                        key: ValueKey(organ.id),
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 550),
                        curve: Curves.easeOutBack,
                        builder: (context, progress, child) => Opacity(
                          opacity: progress.clamp(0, 1).toDouble(),
                          child: Transform.scale(
                            scale: 0.9 + progress * 0.1,
                            child: child,
                          ),
                        ),
                        child: Image.asset(
                          organ.imageAsset,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: (anchorY(first, 0.25) - 14).clamp(8, 225).toDouble(),
                    left: (anchorX(first, 0.35) - calloutWithAnchor)
                        .clamp(0, constraints.maxWidth - calloutWithAnchor)
                        .toDouble(),
                    child: _OrganCallout(
                      text: first?.text ?? 'Condition is stable.',
                      positive: first?.isPositive ?? true,
                      anchorOnLeft: false,
                    ),
                  ),
                  Positioned(
                    top: (anchorY(third, 0.35) - 14).clamp(8, 225).toDouble(),
                    right:
                        (constraints.maxWidth -
                                anchorX(third, 0.75) -
                                calloutWithAnchor)
                            .clamp(0, constraints.maxWidth - calloutWithAnchor)
                            .toDouble(),
                    child: _OrganCallout(
                      text: third?.text ?? 'Recovery phase is improving.',
                      positive: third?.isPositive ?? true,
                      showDetails: true,
                      anchorOnLeft: true,
                      onTap: onViewDetails,
                    ),
                  ),
                  Positioned(
                    top: (anchorY(second, 0.65) - 14).clamp(8, 225).toDouble(),
                    left: (anchorX(second, 0.25) - calloutWithAnchor)
                        .clamp(0, constraints.maxWidth - calloutWithAnchor)
                        .toDouble(),
                    child: _OrganCallout(
                      text: second?.text ?? 'No major concern detected.',
                      positive: second?.isPositive ?? false,
                      anchorOnLeft: false,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const FuturisticPlatform(height: 78),
      ],
    );
  }
}

class _OrganCallout extends StatelessWidget {
  const _OrganCallout({
    required this.text,
    required this.positive,
    required this.anchorOnLeft,
    this.showDetails = false,
    this.onTap,
  });

  final String text;
  final bool positive;
  final bool anchorOnLeft;
  final bool showDetails;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = positive ? AppColors.neonGreen : const Color(0xFFFF5A36);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOutBack,
      builder: (context, value, child) => Opacity(
        opacity: value.clamp(0, 1).toDouble(),
        child: Transform.scale(scale: 0.92 + value * 0.08, child: child),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (anchorOnLeft) _CalloutAnchor(color: color),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 132),
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontSize: 10.5, height: 1.2),
                    ),
                    if (showDetails) ...[
                      const SizedBox(height: 3),
                      Text(
                        'View in Details →',
                        style: TextStyle(
                          color: color,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (!anchorOnLeft) _CalloutAnchor(color: color),
        ],
      ),
    );
  }
}

class _CalloutAnchor extends StatelessWidget {
  const _CalloutAnchor({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 28,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 20, height: 1, color: color.withValues(alpha: 0.75)),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.14),
              shape: BoxShape.circle,
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}
