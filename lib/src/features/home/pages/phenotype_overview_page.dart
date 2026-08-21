import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:dots_in/src/app/routes/app_routes.dart';
import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/features/home/controllers/home_controller.dart';
import 'package:dots_in/src/features/home/widgets/health_body_overview.dart';
import 'package:dots_in/src/features/home/widgets/hormone_chart.dart';
import 'package:dots_in/src/features/home/widgets/genomic_health_section.dart';
import 'package:dots_in/src/shared/widgets/condition_gauge.dart';
import 'package:dots_in/src/shared/widgets/organ_metrics_panel.dart';
import 'package:dots_in/src/shared/widgets/phenotype_header.dart';
import 'package:dots_in/src/shared/widgets/recommendation_card.dart';
import 'package:dots_in/src/shared/widgets/segmented_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhenotypeOverviewPage extends GetView<HomeController> {
  const PhenotypeOverviewPage({super.key});

  static const _strengths = [
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
  ];
  static const _weaknesses = [
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
    'HCV Antibody',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.45, -0.55),
            radius: 1.15,
            colors: [Color(0xFF124509), AppColors.pageBackground, Colors.black],
            stops: [0, 0.5, 1],
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

            if (controller.errorMessage.isNotEmpty) {
              return _ErrorView(controller: controller);
            }

            final tabIndex = controller.tabIndex.value;
            final selectedHormoneIndex = controller.selectedHormoneIndex.value;
            final isOrganPanelOpen = controller.isOrganPanelOpen.value;
            final selectedOrganId = controller.selectedOrganId.value;
            final selectedMetricSection =
                controller.selectedMetricSection.value;

            return LayoutBuilder(
              builder: (context, constraints) {
                final panelWidth = (constraints.maxWidth * 0.58)
                    .clamp(245.0, 300.0)
                    .toDouble();
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: PhenotypeHeader(
                            title: tabIndex == 0 ? 'Genotype' : 'Phenotype',
                            onOrganMenuTap: controller.toggleOrganPanel,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.md,
                            AppSpacing.sm,
                            AppSpacing.md,
                            AppSpacing.xl,
                          ),
                          sliver: SliverList.list(
                            children: [
                              SegmentedSelector(
                                labels: const ['Genotype', 'Phenotype'],
                                selectedIndex: tabIndex,
                                onSelected: controller.setTab,
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              if (tabIndex == 0)
                                const GenomicHealthSection()
                              else ...[
                                Text(
                                  'Health Conditions Overview',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                const HealthBodyOverview(),
                                const SizedBox(height: AppSpacing.lg),
                                SegmentedSelector(
                                  labels: const ['Dopamine', 'Serotonin'],
                                  selectedIndex: selectedHormoneIndex,
                                  activeColor: AppColors.darkGreen,
                                  onSelected: controller.selectHormone,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                HormoneChart(
                                  selectedIndex: selectedHormoneIndex,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                const _AboutSection(),
                                const SizedBox(height: AppSpacing.xl),
                                Text(
                                  'Immune system strength',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: AppSpacing.md),
                                ConditionGauge(
                                  value:
                                      controller.wellnessScore.value?.value ??
                                      30,
                                  color: const Color(0xFFFF3158),
                                ),
                                const SizedBox(height: AppSpacing.lg),
                                RecommendationCard(
                                  title: 'Immune System Recommendation:',
                                  intro:
                                      'Maintaining a strong immune system is essential for '
                                      'overall health and protection against illness.\nWe recommend:',
                                  bullets: const [
                                    'Eating a balanced diet rich in fruits, vegetables, and proteins.',
                                    'Staying hydrated and getting enough sleep (7-8 hours).',
                                    'Regular exercise to boost immunity and reduce stress.',
                                  ],
                                  strengths: _strengths,
                                  weaknesses: _weaknesses,
                                ),
                              ],
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
                            controller.selectOrgan(organId);
                            final organExists = controller.organs.any(
                              (organ) => organ.id == organId,
                            );
                            if (organExists) {
                              controller.closeOrganPanel();
                              Get.toNamed(
                                AppRoutes.organDetail.replaceFirst(
                                  ':id',
                                  organId,
                                ),
                              );
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
            );
          }),
        ),
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * 0.42;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: imageWidth,
              height: 200,
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: const Color(0xFF061026),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  const Text(
                    'Hyperprolactinemia Score',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                  const Spacer(),
                  Image.asset(
                    AppAssets.dna,
                    width: 500,
                    height: 108,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  Text('95%', style: Theme.of(context).textTheme.headlineSmall),
                  const Text('Based on Hormone', style: TextStyle(fontSize: 9)),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ABOUT Hyperprolactinemia',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Text(
                    'This condition is characterized by abnormally high levels '
                    'of prolactin in the blood, which can result from various '
                    'factors, including dopamine dysfunction, certain medications, '
                    'or tumors of the pituitary gland.',
                    style: TextStyle(color: AppColors.mutedText, height: 1.35),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(controller.errorMessage.value, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            FilledButton(
              onPressed: controller.loadOverview,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
