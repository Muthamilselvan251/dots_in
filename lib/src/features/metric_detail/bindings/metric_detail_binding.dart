import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:dots_in/src/features/metric_detail/controllers/metric_detail_controller.dart';
import 'package:get/get.dart';

class MetricDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MetricDetailController>(
      () => MetricDetailController(Get.find<HealthRepository>()),
    );
  }
}
