import 'package:get/get.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/models/MomentSquare.dart';
import 'package:topshot_scan/models/SearchQuery.dart';
import 'package:topshot_scan/repositories/Search_repo.dart';

class ResultsPageController extends GetxController {
  static ResultsPageController get to => Get.find();

  ResultsPageController(this._search_repo);

  // ignore: non_constant_identifier_names
  final Search_repo _search_repo;

  var loaded_moments = [].obs;
  var loading = false.obs;
  var loading_additional = false.obs;
  var pagination = "";
  var limit = false.obs;

  fetchAll(v, pag) async {
    if (pag) {
      loading_additional.toggle();
      var q = v.toMap();
      q["searchInput"] = {
        "cursor": pagination,
        "direction": "RIGHT",
        "limit": 12
      };

      var result = await _search_repo.dataFetch(SearchQuery.fromMap(q));
      if (result["error"] == "maintenance") {
        fetchAll(v, true);
      } else {
        if (result["data"]["size"] == 0) {
          limit.toggle();
          return;
        }

        if (pagination == result["pagination"]["rightCursor"]) {
          loading_additional.toggle();
          return;
        }

        for (var m in result["data"]["data"]) {
          loaded_moments.add(MomentSquare.fromMap(m));
        }
        pagination = result["pagination"]["rightCursor"];
        loading_additional.toggle();
        return;
      }
    } else {
      loading.toggle();
      loaded_moments.clear();

      var result = await _search_repo.dataFetch(v);
      if (result["error"] == "maintenance") {
        fetchAll(v, false);
      } else {
        for (var m in result["data"]["data"]) {
          loaded_moments.add(MomentSquare.fromMap(m));
        }
        pagination = result["pagination"]["rightCursor"];
        loading.toggle();
        return;
      }
    }
  }
}
