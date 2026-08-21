import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/core/constants/app_colors.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class OrganMetricsPanel extends StatelessWidget {
  const OrganMetricsPanel({
    required this.selectedOrganId,
    required this.selectedSection,
    required this.onClose,
    required this.onOrganSelected,
    required this.onSectionSelected,
    super.key,
  });

  final String selectedOrganId;
  final String selectedSection;
  final VoidCallback onClose;
  final ValueChanged<String> onOrganSelected;
  final ValueChanged<String> onSectionSelected;

  static const _organs = [
    _OrganItem('heart', 'Heart', AppAssets.heartIcon),
    _OrganItem('lungs', 'Lungs', AppAssets.lungsIcon),
    _OrganItem('kidneys', 'Kidneys', AppAssets.kidneyIcon),
    _OrganItem('brain', 'Brain', AppAssets.brainIcon),
    _OrganItem('bones', 'Bones', AppAssets.bonesIcon),
    _OrganItem('stomach', 'Stomach', AppAssets.stomachIcon),
    _OrganItem('intestine', 'Intestine', AppAssets.intestineIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF292929).withValues(alpha: 0.98),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(28),
        bottomLeft: Radius.circular(28),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 18,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Organ Metrics',
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: onClose,
                  tooltip: 'Close organ metrics',
                  visualDensity: VisualDensity.compact,
                  icon: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      color: const Color(0xFF16353B),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(Icons.keyboard_arrow_up, size: 19),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Column(
                children: [
                  ..._organs.map(
                    (organ) => _OrganTile(
                      item: organ,
                      selected:
                          selectedSection == 'organ' &&
                          selectedOrganId == organ.id,
                      onTap: () => onOrganSelected(organ.id),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionButton(
                    label: 'Blood Metrics',
                    selected: selectedSection == 'blood',
                    onTap: () => onSectionSelected('blood'),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _SectionButton(
                    label: 'Hormone',
                    selected: selectedSection == 'hormone',
                    onTap: () => onSectionSelected('hormone'),
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

class _OrganTile extends StatelessWidget {
  const _OrganTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _OrganItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Material(
        key: ValueKey('organ_tile_${item.id}'),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF151515) : Colors.transparent,
            borderRadius: BorderRadius.circular(22),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 10,
              ),
              child: Row(
                children: [
                  AnimatedScale(
                    scale: selected ? 1.08 : 1,
                    duration: const Duration(milliseconds: 180),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Image.asset(item.asset, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      item.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionButton extends StatelessWidget {
  const _SectionButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Material(
        color: selected ? AppColors.darkGreen : const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: SizedBox(
            height: 58,
            child: Center(
              child: Text(label, style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrganItem {
  const _OrganItem(this.id, this.label, this.asset);

  final String id;
  final String label;
  final String asset;
}
