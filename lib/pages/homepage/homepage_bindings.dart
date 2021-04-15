import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/modules/LatestListings/latestlistings_controller.dart';
import 'package:topshot_scan/modules/LinkedAccount/linkedaccount_controller.dart';
import 'package:topshot_scan/modules/searchbar/searchbar_controller.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/repositories/Codex_repo.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';
import 'package:topshot_scan/repositories/Search_repo.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';

class HomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Codex_repo>(() => Codex_repo());
    Get.lazyPut<Moment_repo>(() => Moment_repo());
    Get.lazyPut<Search_repo>(() => Search_repo());

    Get.lazyPut<LinkedAccountController>(
        () => LinkedAccountController(Get.find<Users_repo>()));

    Get.lazyPut<HomePageController>(() =>
        HomePageController(Get.find<Codex_repo>(), Get.find<Moment_repo>()));

    Get.lazyPut<LatestListingsController>(
        () => LatestListingsController(Get.find<Search_repo>()));

    Get.lazyPut<SearchBarController>(() => SearchBarController());
  }
}
