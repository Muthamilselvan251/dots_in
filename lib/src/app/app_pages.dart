import 'package:dots_in/src/app/routes/app_routes.dart';
import 'package:dots_in/src/features/home/bindings/home_binding.dart';
import 'package:dots_in/src/features/home/pages/phenotype_overview_page.dart';
import 'package:dots_in/src/features/organ_detail/bindings/organ_detail_binding.dart';
import 'package:dots_in/src/features/organ_detail/pages/organ_detail_page.dart';
import 'package:dots_in/src/features/metric_detail/bindings/metric_detail_binding.dart';
import 'package:dots_in/src/features/metric_detail/pages/metric_detail_page.dart';
import 'package:get/get.dart';

class AppPages {
  AppPages._();

  static const _pageTransition = Transition.fadeIn;
  static const _transitionDuration = Duration(milliseconds: 360);

  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const PhenotypeOverviewPage(),
      binding: HomeBinding(),
      transition: _pageTransition,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.organDetail,
      page: () => const OrganDetailPage(),
      binding: OrganDetailBinding(),
      transition: _pageTransition,
      transitionDuration: _transitionDuration,
    ),
    GetPage(
      name: AppRoutes.metricDetail,
      page: () => const MetricDetailPage(),
      binding: MetricDetailBinding(),
      transition: _pageTransition,
      transitionDuration: _transitionDuration,
    ),
  ];

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const PhenotypeOverviewPage(),
    binding: HomeBinding(),
    transition: _pageTransition,
    transitionDuration: _transitionDuration,
  );
}
