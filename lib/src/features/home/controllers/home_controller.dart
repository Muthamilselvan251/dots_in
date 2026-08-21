import 'package:dots_in/src/core/data/models/organ_model.dart';
import 'package:dots_in/src/core/data/models/score_model.dart';
import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  HomeController(this.repo);

  final HealthRepository repo;

  final RxInt tabIndex = 1.obs;
  final RxInt selectedHormoneIndex = 1.obs;
  final Rx<ScoreModel?> wellnessScore = Rx(null);
  final RxList<OrganModel> organs = <OrganModel>[].obs;
  final RxBool loading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isOrganPanelOpen = false.obs;
  final RxString selectedOrganId = 'heart'.obs;
  final RxString selectedMetricSection = 'organ'.obs;

  @override
  void onInit() {
    super.onInit();
    loadOverview();
  }

  Future<void> loadOverview() async {
    loading.value = true;
    errorMessage.value = '';
    try {
      final results = await Future.wait([
        repo.fetchWellnessScore(),
        repo.fetchOrgans(),
      ]);
      wellnessScore.value = results[0] as ScoreModel;
      organs.assignAll(results[1] as List<OrganModel>);
    } catch (_) {
      errorMessage.value = 'Unable to load health information.';
    } finally {
      loading.value = false;
    }
  }

  void setTab(int i) => tabIndex.value = i;
  void selectHormone(int index) => selectedHormoneIndex.value = index;

  void toggleOrganPanel() => isOrganPanelOpen.toggle();

  void closeOrganPanel() => isOrganPanelOpen.value = false;

  void selectOrgan(String organId) {
    selectedOrganId.value = organId;
    selectedMetricSection.value = 'organ';
  }

  void selectMetricSection(String section) {
    selectedMetricSection.value = section;
  }
}
