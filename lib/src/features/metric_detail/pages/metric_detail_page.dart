import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/core/data/models/metric_model.dart';
import 'package:dots_in/src/features/metric_detail/controllers/metric_detail_controller.dart';
import 'package:dots_in/src/features/metric_detail/widgets/range_gauge.dart';
import 'package:dots_in/src/features/metric_detail/widgets/range_legend.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MetricDetailPage extends GetView<MetricDetailController> {
  const MetricDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.25, -0.8),
            radius: 1.1,
            colors: [Color(0xFF6A3C08), Color(0xFF120D04), Colors.black],
            stops: [0, 0.4, 1],
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.loading.value) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFFFFD600)),
              );
            }

            final metric = controller.metric.value;
            if (controller.errorMessage.isNotEmpty || metric == null) {
              return _ErrorView(
                message: controller.errorMessage.value,
                onRetry: controller.loadMetric,
              );
            }

            return ListView(
              padding: const EdgeInsets.fromLTRB(
                14,
                AppSpacing.md,
                14,
                AppSpacing.xl,
              ),
              children: [
                Text(
                  metric.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      metric.value.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        metric.unit,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'optimal',
                  style: TextStyle(color: AppColors.mutedText),
                ),
                RangeGauge(score: metric.gauge, metricValue: metric.value),
                const SizedBox(height: AppSpacing.md),
                Text('RANGES', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),
                const RangeLegend(),
                const SizedBox(height: 46),
                Text(
                  'Parameters that are generally impacted by ${metric.title}:',
                  style: const TextStyle(color: AppColors.mutedText),
                ),
                const SizedBox(height: AppSpacing.md),
                ...metric.impactedParameters.map(
                  (parameter) => _ImpactedParameterCard(parameter: parameter),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  metric.aboutTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  metric.aboutBody,
                  style: const TextStyle(
                    color: AppColors.mutedText,
                    height: 1.45,
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _ImpactedParameterCard extends StatelessWidget {
  const _ImpactedParameterCard({required this.parameter});

  final ImpactedParameter parameter;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      color: const Color(0xFF121212),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        childrenPadding: const EdgeInsets.fromLTRB(64, 0, 16, 14),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A3225),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            Icons.health_and_safety_outlined,
            color: Color(0xFFFFB000),
          ),
        ),
        title: Text(
          parameter.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          parameter.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 9, color: AppColors.mutedText),
        ),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              parameter.subtitle,
              style: const TextStyle(color: AppColors.mutedText, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
