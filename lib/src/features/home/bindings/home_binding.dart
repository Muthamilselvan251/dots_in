import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:dots_in/src/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<HealthRepository>()),
    );
  }
}
