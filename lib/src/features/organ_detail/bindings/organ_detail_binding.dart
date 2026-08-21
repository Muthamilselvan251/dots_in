import 'package:get/get.dart';
import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:dots_in/src/features/organ_detail/controllers/organ_detail_controller.dart';

class OrganDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrganDetailController(Get.find<HealthRepository>()));
  }
}
