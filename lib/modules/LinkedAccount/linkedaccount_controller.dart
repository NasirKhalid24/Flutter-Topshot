import 'package:get/get.dart';
import 'package:topshot_scan/models/UserD.dart';
import 'package:topshot_scan/pages/homepage/homepage_controller.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';

class LinkedAccountController extends GetxController {
  static LinkedAccountController get to => Get.find();

  LinkedAccountController(this._user_repo);

  Users_repo _user_repo = Get.find<Users_repo>();
  var loadinguser = false.obs;
  var deletinguser = false.obs;
  Rx<UserD> dapperuser = UserD().obs;

  @override
  void onInit() {
    super.onInit();
  }

  void GetDapperAcc(u) async {
    loadinguser.toggle();
    var t = await _user_repo.dataFetch(u);
    dapperuser.value = UserD.fromMap(t);
    loadinguser.toggle();
  }
}
