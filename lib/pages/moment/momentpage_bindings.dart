import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/modules/PriceSerialNumberChart/priceserialnumberchart_controller.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';

import 'momentpage_controller.dart';

class MomentPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.create<MomentPageController>(
        () => MomentPageController(Get.find<Moment_repo>()));
    // Get.lazyPut<MomentPageController>(
    //     () => MomentPageController(Get.find<Moment_repo>()));

    Get.create<PriceSerialNumberChartController>(
        () => PriceSerialNumberChartController());
    // Get.lazyPut<PriceSerialNumberChartController>(
    //     () => PriceSerialNumberChartController());
  }
}
