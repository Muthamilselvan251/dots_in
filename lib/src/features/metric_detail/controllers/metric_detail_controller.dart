import 'package:dots_in/src/core/data/models/metric_model.dart';
import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:get/get.dart';

class MetricDetailController extends GetxController {
  MetricDetailController(this.repo);

  final HealthRepository repo;
  final Rx<MetricModel?> metric = Rx(null);
  final RxBool loading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadMetric();
  }

  Future<void> loadMetric() async {
    final metricId = Get.parameters['id'];
    if (metricId == null || metricId.isEmpty) {
      loading.value = false;
      errorMessage.value = 'Metric information is unavailable.';
      return;
    }

    loading.value = true;
    errorMessage.value = '';
    try {
      metric.value = await repo.fetchMetricById(metricId);
    } catch (_) {
      errorMessage.value = 'Unable to load metric information.';
    } finally {
      loading.value = false;
    }
  }
}
