import 'package:dots_in/src/app/routes/app_routes.dart';
import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/shared/widgets/futuristic_platform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthBodyOverview extends StatefulWidget {
  const HealthBodyOverview({super.key});

  @override
  State<HealthBodyOverview> createState() => _HealthBodyOverviewState();
}

class _HealthBodyOverviewState extends State<HealthBodyOverview>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1250),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _openOrgan(String organId) {
    final route = AppRoutes.organDetail.replaceFirst(':id', organId);
    Get.toNamed('$route?risk=1');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 350;
        final bodyWidth = compact ? 180.0 : 205.0;
        return SizedBox(
          height: compact ? 405 : 445,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 650),
            curve: Curves.easeOutCubic,
            builder: (context, entrance, child) => Opacity(
              opacity: entrance,
              child: Transform.translate(
                offset: Offset(0, 12 * (1 - entrance)),
                child: child,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: compact ? 325 : 365,
                  child: Center(
                    child: Container(
                      width: bodyWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.neonGreen.withValues(alpha: 0.18),
                            blurRadius: 70,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppAssets.humanBody,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: FuturisticPlatform(height: 76),
                ),
                Positioned(
                  top: 45,
                  left: constraints.maxWidth / 2 + bodyWidth * 0.22,
                  child: _Callout(
                    text: 'Recovery slight\npain in the left\nside neck.',
                    isPositive: true,
                    anchorOnLeft: true,
                    pulse: _pulseController,
                    onTap: () => _openOrgan('overall-health'),
                  ),
                ),
                Positioned(
                  top: compact ? 92 : 100,
                  right: constraints.maxWidth / 2 + bodyWidth * 0.18,
                  child: _Callout(
                    text: 'Chronics Lungs\nProblem',
                    isPositive: false,
                    anchorOnLeft: false,
                    pulse: _pulseController,
                    onTap: () => _openOrgan('overall-health'),
                  ),
                ),
                Positioned(
                  top: compact ? 235 : 255,
                  right: constraints.maxWidth / 2 + bodyWidth * 0.08,
                  child: _Callout(
                    text: 'Knee Problem',
                    isPositive: false,
                    anchorOnLeft: false,
                    pulse: _pulseController,
                    onTap: () => _openOrgan('overall-health'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({
    required this.text,
    required this.isPositive,
    required this.anchorOnLeft,
    required this.pulse,
    required this.onTap,
  });

  final String text;
  final bool isPositive;
  final bool anchorOnLeft;
  final Animation<double> pulse;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppColors.neonGreen : const Color(0xFFFF5A36);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (anchorOnLeft) _Anchor(color: color, pulse: pulse),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(11),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 140),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.78),
                border: Border.all(color: color),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: const TextStyle(fontSize: 11, height: 1.15),
                  ),
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
              ),
            ),
          ),
        ),
        if (!anchorOnLeft) _Anchor(color: color, pulse: pulse),
      ],
    );
  }
}

class _Anchor extends StatelessWidget {
  const _Anchor({required this.color, required this.pulse});

  final Color color;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) => SizedBox(
        width: 22,
        height: 28,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 1,
              width: 22,
              color: color.withValues(alpha: 0.7),
            ),
            Transform.scale(
              scale: 1 + pulse.value * 0.35,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.12),
                ),
              ),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
