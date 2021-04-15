import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:topshot_scan/main_controller.dart';
import 'package:topshot_scan/models/MomentSquare.dart';
import 'package:topshot_scan/repositories/Search_repo.dart';

class LatestListingsController extends GetxController {
  static LatestListingsController get to => Get.find();

  LatestListingsController(this._search_repo);

  // ignore: non_constant_identifier_names
  final Search_repo _search_repo;
  final MainAppController _mc = Get.find<MainAppController>();

  // ignore: non_constant_identifier_names
  var latest_moments = [].obs;
  var loading = false.obs;

  fetchAll(v) async {
    loading.toggle();
    latest_moments.clear();
    var result = await _search_repo.dataFetch(v);
    if (result["error"] == "maintenance") {
      _mc.down.value = true;
    } else {
      _mc.down.value = false;
      for (var m in result["data"]["data"]) {
        latest_moments.add(MomentSquare.fromMap(m));
      }
      loading.toggle();
    }
  }
}
