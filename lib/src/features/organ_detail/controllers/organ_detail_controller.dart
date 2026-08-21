import 'package:dots_in/src/core/data/models/organ_model.dart';
import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:get/get.dart';

class OrganDetailController extends GetxController {
  final HealthRepository repo;
  OrganDetailController(this.repo);

  final Rx<OrganModel?> organ = Rx(null);
  final RxInt selectedRiskVariant = (-1).obs;
  final RxBool loading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isOrganPanelOpen = false.obs;
  final RxString selectedMetricSection = 'organ'.obs;
  final RxString selectedOrganId = ''.obs;
  bool _changingOrgan = false;

  @override
  void onInit() {
    super.onInit();
    if (Get.parameters['risk'] == '1') {
      selectedRiskVariant.value = 0;
    }
    final organId = Get.parameters['id'];
    if (organId == null || organId.isEmpty) {
      loading.value = false;
      errorMessage.value = 'Organ information is unavailable.';
      return;
    }
    selectedOrganId.value = organId;
    loadOrgan(organId);
  }

  Future<void> loadOrgan(String id) async {
    loading.value = true;
    errorMessage.value = '';
    try {
      organ.value = await repo.fetchOrganById(id);
    } catch (_) {
      errorMessage.value = 'Unable to load organ information.';
    } finally {
      loading.value = false;
    }
  }

  void selectRiskVariant(int index) => selectedRiskVariant.value = index;

  void showMainCondition() => selectedRiskVariant.value = -1;

  void toggleOrganPanel() => isOrganPanelOpen.toggle();

  void closeOrganPanel() => isOrganPanelOpen.value = false;

  void selectMetricSection(String section) {
    selectedMetricSection.value = section;
  }

  void selectOrgan(String organId) {
    selectedOrganId.value = organId;
    selectedMetricSection.value = 'organ';
  }

  Future<void> changeOrgan(String organId) async {
    if (_changingOrgan || organId == organ.value?.id) return;

    _changingOrgan = true;
    try {
      final nextOrgan = await repo.fetchOrganById(organId);
      selectedOrganId.value = organId;
      selectedMetricSection.value = 'organ';
      selectedRiskVariant.value = -1;
      organ.value = nextOrgan;
    } finally {
      _changingOrgan = false;
    }
  }

  void retry() {
    final organId = selectedOrganId.value.isNotEmpty
        ? selectedOrganId.value
        : Get.parameters['id'];
    if (organId != null && organId.isNotEmpty) {
      loadOrgan(organId);
    }
  }
}
