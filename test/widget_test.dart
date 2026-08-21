import 'package:dots_in/src/app/app.dart';
import 'package:dots_in/src/features/home/controllers/home_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

void main() {
  tearDown(Get.reset);

  testWidgets('shows the phenotype foundation page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.text('Phenotype'), findsWidgets);
    expect(find.text('Health Conditions Overview'), findsOneWidget);

    await tester.tap(find.byTooltip('Organ metrics'));
    await tester.pumpAndSettle();

    expect(Get.find<HomeController>().isOrganPanelOpen.value, isTrue);
    expect(find.text('Organ Metrics'), findsOneWidget);
    expect(find.text('Blood Metrics'), findsOneWidget);

    await tester.tap(find.text('Heart'));
    await tester.pumpAndSettle();

    expect(find.text('Heart Conditions Overview'), findsOneWidget);

    await tester.tap(find.text('View in Details →'));
    await tester.pumpAndSettle();

    expect(find.text('Heart Attack (Myocardial Infarction)'), findsOneWidget);

    await tester.tap(find.byTooltip('Organ metrics'));
    await tester.pumpAndSettle();

    expect(find.text('Organ Metrics'), findsOneWidget);
    expect(find.byKey(const ValueKey('organ_tile_heart')), findsOneWidget);
    expect(find.text('Heart Attack (Myocardial Infarction)'), findsOneWidget);

    await tester.tap(find.text('Lungs'));
    await tester.pumpAndSettle();

    expect(find.text('Lungs Conditions Overview'), findsOneWidget);
    expect(find.text('Lungs Condition'), findsOneWidget);

    await tester.tap(find.byTooltip('Organ metrics'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Blood Metrics'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Blood Metrics'));
    await tester.pumpAndSettle();

    expect(find.text('Mentzer'), findsOneWidget);
    expect(find.text('RANGES'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('ABOUT LDL CHOLESTEROL'), 400);
    expect(find.text('ABOUT LDL CHOLESTEROL'), findsOneWidget);
  });

  testWidgets('opens genomic overview and another organ detail', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Genotype'));
    await tester.pumpAndSettle();

    expect(find.text('Genomic Health Overview'), findsOneWidget);
    expect(find.text('Important Genomic Markers'), findsOneWidget);

    await tester.tap(find.text('Phenotype').last);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Organ metrics'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Brain'));
    await tester.pumpAndSettle();

    expect(find.text('Brain Conditions Overview'), findsOneWidget);
    expect(find.text('Brain Condition'), findsOneWidget);
  });
}
