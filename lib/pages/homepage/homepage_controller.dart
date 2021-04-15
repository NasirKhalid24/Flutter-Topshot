import 'package:get/get.dart';
import 'package:topshot_scan/main_controller.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/models/TSet.dart';
import 'package:topshot_scan/repositories/Codex_repo.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';

class HomePageController extends GetxController {
  static HomePageController get to => Get.find();

  HomePageController(this._codex_repo, this._moment_repo);

  // ignore: non_constant_identifier_names
  final Codex_repo _codex_repo;
  final Moment_repo _moment_repo;
  final MainAppController _mc = Get.find<MainAppController>();

  var player_codex = {}.obs;
  var team_codex = {}.obs;
  var set_codex = [].obs;
  var set_name_id_map = {}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAll();
  }

  fetchAll() async {
    var result = await _codex_repo.dataFetch();
    if (result["error"] == "maintenance") {
      _mc.down.value = true;
    } else {
      _mc.down.value = false;
      for (var player in result["allPlayers"]["data"]) {
        player_codex[player["name"]] = player["id"];
      }
      for (var team in result["allTeams"]["data"]) {
        team_codex[team["name"]] = team["id"];
      }
      for (var ts_set in result["searchSets"]["searchSummary"]["data"]
          ["data"]) {
        set_codex.add(TSet.fromMap(ts_set));
      }

      for (var ts in set_codex) {
        set_name_id_map[ts.flowName] = ts.id;
      }
    }
  }
}
