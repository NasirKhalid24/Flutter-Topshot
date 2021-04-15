import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/modules/PriceSerialNumberChart/priceserialnumberchart_controller.dart';
import 'package:topshot_scan/pages/results/results_controller.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';
import 'package:topshot_scan/repositories/Search_repo.dart';

class ResultsPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultsPageController>(
        () => ResultsPageController(Get.find<Search_repo>()));
  }
}
