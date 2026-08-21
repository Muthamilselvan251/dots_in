import 'package:dots_in/src/core/constants/app_assets.dart';
import 'package:dots_in/src/core/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class PhenotypeHeader extends StatelessWidget {
  const PhenotypeHeader({
    super.key,
    this.title = 'Phenotype',
    this.onOrganMenuTap,
    this.onBackTap,
  });

  final String title;
  final VoidCallback? onOrganMenuTap;
  final VoidCallback? onBackTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                onPressed: () {
                  if (onBackTap != null) {
                    onBackTap!();
                    return;
                  }
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                icon: const Icon(Icons.arrow_back, size: 30),
              ),
            ),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: onOrganMenuTap,
                tooltip: 'Organ metrics',
                icon: Image.asset(
                  AppAssets.humanIcon,
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
