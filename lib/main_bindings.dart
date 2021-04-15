import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';

import 'main_controller.dart';
import 'repositories/Users_repo.dart';

class MainAppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Users_repo>(() => Users_repo());

    Get.lazyPut<MainAppController>(
        () => MainAppController(Get.find<Users_repo>()));
  }
}
