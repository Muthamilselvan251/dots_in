import 'package:dots_in/src/app/routes/app_routes.dart';
import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/features/organ_detail/controllers/organ_detail_controller.dart';
import 'package:dots_in/src/features/organ_detail/widgets/organ_hero_section.dart';
import 'package:dots_in/src/features/organ_detail/widgets/risk_assessment_card.dart';
import 'package:dots_in/src/features/organ_detail/widgets/recovery_recommendation_card.dart';
import 'package:dots_in/src/shared/widgets/condition_gauge.dart';
import 'package:dots_in/src/shared/widgets/metric_chip.dart';
import 'package:dots_in/src/shared/widgets/organ_metrics_panel.dart';
import 'package:dots_in/src/shared/widgets/phenotype_header.dart';
import 'package:dots_in/src/shared/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrganDetailPage extends GetView<OrganDetailController> {
  const OrganDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.45, -0.45),
            radius: 1.1,
            colors: [Color(0xFF123E08), AppColors.pageBackground, Colors.black],
            stops: [0, 0.52, 1],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Obx(() {
            if (controller.loading.value) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.neonGreen),
              );
            }

            final organ = controller.organ.value;
            if (controller.errorMessage.isNotEmpty || organ == null) {
              return _ErrorView(
                message: controller.errorMessage.value,
                onRetry: controller.retry,
              );
            }

            final riskIndex = controller.selectedRiskVariant.value;
            final isRiskView = riskIndex >= 0;
            final selectedRisk =
                riskIndex >= 0 && riskIndex < organ.riskVariants.length
                ? organ.riskVariants[riskIndex]
                : null;
            final activeScore = selectedRisk?.score ?? organ.condition;
            final activeTitle = selectedRisk?.label ?? organ.condition.label;
            final isLungs = organ.id == 'lungs';
            final gaugeColor = isRiskView
                ? const Color(0xFFFF3158)
                : isLungs
                ? const Color(0xFFE9F000)
                : AppColors.neonGreen;
            final recommendationIntro = isLungs
                ? 'Maintaining healthy lungs is essential for '
                      'overall well-being and vitality.'
                : organ.id == 'heart'
                ? 'Maintaining a healthy heart is essential for '
                      'overall well-being and longevity.'
                : 'Maintaining healthy ${organ.name.toLowerCase()} is important '
                      'for overall well-being and long-term health.';
            final assessmentTitle = organ.id == 'overall-health'
                ? 'Overall Health Risk Assessment'
                : 'Chronic ${organ.name} Disease Risk Assessment';
            final isOrganPanelOpen = controller.isOrganPanelOpen.value;
            final selectedOrganId = controller.selectedOrganId.value;
            final selectedMetricSection =
                controller.selectedMetricSection.value;

            return PopScope(
              canPop: !isOrganPanelOpen && !isRiskView,
              onPopInvokedWithResult: (didPop, result) {
                if (didPop) return;
                if (isOrganPanelOpen) {
                  controller.closeOrganPanel();
                } else if (isRiskView) {
                  controller.showMainCondition();
                }
              },
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final panelWidth = (constraints.maxWidth * 0.58)
                      .clamp(245.0, 300.0)
                      .toDouble();
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: IgnorePointer(
                          child: AnimatedOpacity(
                            opacity: isRiskView ? 1 : 0,
                            duration: const Duration(milliseconds: 250),
                            child: const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  center: Alignment(0.4, -0.45),
                                  radius: 1.1,
                                  colors: [
                                    Color(0xFF5B1308),
                                    Color(0xFF170300),
                                    Colors.black,
                                  ],
                                  stops: [0, 0.55, 1],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: PhenotypeHeader(
                              onOrganMenuTap: controller.toggleOrganPanel,
                              onBackTap: isRiskView
                                  ? controller.showMainCondition
                                  : null,
                            ),
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(
                              12,
                              AppSpacing.sm,
                              12,
                              AppSpacing.xl,
                            ),
                            sliver: SliverList.list(
                              children: [
                                OrganHeroSection(
                                  organ: organ,
                                  onViewDetails: () =>
                                      controller.selectRiskVariant(0),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                Text(
                                  activeTitle,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                ConditionGauge(
                                  key: ValueKey(
                                    '${organ.id}-$riskIndex-${activeScore.value}',
                                  ),
                                  value: activeScore.value,
                                  color: gaugeColor,
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                if (isRiskView) ...[
                                  RecoveryRecommendationCard(
                                    organName: organ.name,
                                    recommendations:
                                        organ.recommendationBullets,
                                  ),
                                  const SizedBox(height: AppSpacing.lg),
                                  MetricGrid(
                                    title: 'Weakness :',
                                    values: organ.weaknesses,
                                    isPositive: false,
                                  ),
                                ] else
                                  RecommendationCard(
                                    title: organ.recommendationTitle,
                                    intro: recommendationIntro,
                                    bullets: organ.recommendationBullets,
                                    strengths: organ.strengths,
                                    weaknesses: organ.weaknesses,
                                  ),
                                const SizedBox(height: AppSpacing.lg),
                                Text(
                                  assessmentTitle,
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                ...organ.riskAssessment.map(
                                  (item) => RiskAssessmentCard(item: item),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IgnorePointer(
                        ignoring: !isOrganPanelOpen,
                        child: AnimatedOpacity(
                          opacity: isOrganPanelOpen ? 1 : 0,
                          duration: const Duration(milliseconds: 180),
                          child: GestureDetector(
                            onTap: controller.closeOrganPanel,
                            behavior: HitTestBehavior.opaque,
                            child: Container(color: Colors.black45),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        top: 54,
                        bottom: 0,
                        right: isOrganPanelOpen ? 0 : -panelWidth - 8,
                        width: panelWidth,
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.easeOutCubic,
                        child: IgnorePointer(
                          ignoring: !isOrganPanelOpen,
                          child: OrganMetricsPanel(
                            selectedOrganId: selectedOrganId,
                            selectedSection: selectedMetricSection,
                            onClose: controller.closeOrganPanel,
                            onOrganSelected: (organId) {
                              if (organId != organ.id) {
                                controller.closeOrganPanel();
                                controller.changeOrgan(organId);
                              }
                            },
                            onSectionSelected: (section) {
                              controller.selectMetricSection(section);
                              if (section == 'blood' || section == 'hormone') {
                                controller.closeOrganPanel();
                                Get.toNamed(
                                  AppRoutes.metricDetail.replaceFirst(
                                    ':id',
                                    section == 'blood'
                                        ? 'ldl-cholesterol'
                                        : 'prolactin',
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
        ),
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
            Text(
              message.isEmpty ? 'Heart information is unavailable.' : message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            FilledButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
