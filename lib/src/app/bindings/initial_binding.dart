import 'package:dots_in/src/core/datasources/local_json_datasource.dart';
import 'package:dots_in/src/core/repositories/health_repository.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalJsonDataSource>(() => LocalJsonDataSource(), fenix: true);
    Get.lazyPut<HealthRepository>(
      () => HealthRepository(Get.find<LocalJsonDataSource>()),
      fenix: true,
    );
  }
}
