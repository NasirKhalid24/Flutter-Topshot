import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/models/SearchQuery.dart';
import 'package:topshot_scan/models/TSet.dart';
import 'package:topshot_scan/models/UserD.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';

import 'local_widgets/searchcontainer.dart';

class SearchBarController extends GetxController {
  static SearchBarController get to => Get.find();
  static HomePageController c = Get.find<HomePageController>();
  static Users_repo users_repo = Get.find<Users_repo>();

  var searchresults = {"Players": [], "Teams": [], "Sets": [], "Users": []}.obs;

  var searching = false.obs;

  var headers = [].obs;

  @override
  void onInit() {
    super.onInit();
    UpdateSearchResults();
  }

  UpdateSearchResults() {
    for (var i in searchresults.keys) {
      headers.add(SearchContainer(i, true, () => {}));
      for (var j in searchresults[i]) {
        if (j is UserD) {
          headers.add(
              SearchContainer("${j.username}", false, () => print(j.username)));
        } else if (j is TSet) {
          headers.add(SearchContainer(
              "${j.flowName}",
              false,
              () => Get.toNamed('/results',
                  arguments: SearchQuery.fromMap({
                    "bySets": [c.set_name_id_map[j.flowName].toString()],
                    "byListingType": ["BY_USERS"],
                    "orderBy": "UPDATED_AT_DESC",
                    "searchInput": {
                      "cursor": "",
                      "direction": "RIGHT",
                      "limit": 12
                    },
                  }))));
        } else {
          if (i == "Players") {
            headers.add(SearchContainer(
                j,
                false,
                () => Get.toNamed('/results',
                    arguments: SearchQuery.fromMap({
                      "byPlayers": [c.player_codex[j].toString()],
                      "byListingType": ["BY_USERS"],
                      "orderBy": "UPDATED_AT_DESC",
                      "searchInput": {
                        "cursor": "",
                        "direction": "RIGHT",
                        "limit": 12
                      },
                    }))));
          } else if (i == "Teams") {
            headers.add(SearchContainer(
                j,
                false,
                () => Get.toNamed('/results',
                    arguments: SearchQuery.fromMap({
                      "byTeams": [c.team_codex[j].toString()],
                      "byListingType": ["BY_USERS"],
                      "orderBy": "UPDATED_AT_DESC",
                      "searchInput": {
                        "cursor": "",
                        "direction": "RIGHT",
                        "limit": 12
                      },
                    }))));
          } else {
            headers.add(SearchContainer(j, false, () => {print(i)}));
          }
        }
      }
    }
  }

  fetchQuery(query) async {
    searchresults = RxMap<String, List<dynamic>>(
        {"Players": [], "Teams": [], "Sets": [], "Users": []});

    headers = RxList<dynamic>([]);

    if (query.toString().length < 2) {
      searching.toggle();
      UpdateSearchResults();
      searching.toggle();
    } else {
      searching.toggle();

      // User Search
      var user_res = await users_repo.dataFetch(query);
      if (user_res["username"] != null) {
        searchresults["Users"].add(UserD.fromMap(user_res));
      }

      // Player Search
      for (var player in c.player_codex.keys) {
        if (player.toLowerCase().contains(query.toLowerCase())) {
          searchresults["Players"].add(player);
        }
      }

      // Team Search
      for (var team in c.team_codex.keys) {
        if (team.toLowerCase().contains(query.toLowerCase())) {
          searchresults["Teams"].add(team);
        }
      }

      // Set Search
      for (var ts_set in c.set_codex) {
        if (ts_set.flowName.toLowerCase().contains(query.toLowerCase())) {
          searchresults["Sets"].add(ts_set);
        }
      }

      searching.toggle();
      UpdateSearchResults();
    }
  }
}
