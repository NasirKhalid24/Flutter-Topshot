import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/main_controller.dart';
import 'package:topshot_scan/models/AppUser.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';
import 'package:topshot_scan/theme/color_theme.dart';

import 'local_widgets/customdrawerheader.dart';
import '../../modules/LinkedAccount/linkedaccount.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _DrawerState createState() => _DrawerState();
}

class _DrawerState extends State<HomeDrawer> {
  MainAppController c = Get.find<MainAppController>();
  Users_repo ur = Get.find<Users_repo>();

  late String avatar_url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: SafeArea(
          child: Obx(() {
            return c.firebaseuser.value == null
                ? ListView(children: [
                    Text("Please Login to see details"),
                    IconButton(
                        icon: Icon(Icons.login), onPressed: () => c.gSign())
                  ])
                : ListView(children: [
                    Container(
                      height: 100,
                      color: MainColors.purple,
                      child: DrawerHeader(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(c.firebaseuser.value.photoURL!),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(c.firebaseuser.value.displayName!,
                                      style: TextStyle(
                                          fontFamily: "Lexend",
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ),
                          ])),
                    ),
                    InkWell(child: SizedBox(height: 10), onTap: () => c.gLog()),
                    CustomDrawerHeader(
                        Icons.account_circle_outlined, "Linked Account"),
                    LinkedAccountOption(c.userdata),
                    SizedBox(height: 10),
                    CustomDrawerHeader(Icons.alarm, "Your Alerts"),
                    SizedBox(height: 10),
                    InkWell(
                        onTap: () => c.gLog(),
                        child: CustomDrawerHeader(Icons.logout, "Logout"))
                  ]);
          }),
        ),
      ),
    );
  }
}
