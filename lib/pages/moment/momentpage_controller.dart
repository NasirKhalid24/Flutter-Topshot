import 'package:get/get.dart';
import 'package:topshot_scan/models/Moment.dart';
import 'package:topshot_scan/models/TSet.dart';
import 'package:topshot_scan/repositories/Codex_repo.dart';
import 'package:topshot_scan/repositories/Moment_repo.dart';

class MomentPageController extends GetxController {
  static MomentPageController get to => Get.find();

  MomentPageController(this._moment_repo);

  // ignore: non_constant_identifier_names
  final Moment_repo _moment_repo;

  var loading = true.obs;
  var m = Moment.fromMap({}).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    loading.value = true;
    m.value = Moment.fromMap({});
    super.onClose();
  }

  fetchAll(setID, playID) async {
    loading.value = true;
    m.value = Moment.fromMap({});
    var result = await _moment_repo.dataFetch(setID, playID);
    m.value = Moment.fromMap(result);
    loading.toggle();
  }
}
