import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:topshot_scan/main_controller.dart';
import 'package:topshot_scan/models/UserD.dart';
import 'package:topshot_scan/modules/LinkedAccount/linkedaccount_controller.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';
import 'package:topshot_scan/theme/color_theme.dart';

class LinkedAccountOption extends StatefulWidget {
  var user_acc;

  LinkedAccountOption(this.user_acc);

  @override
  _LinkedAccountOptionState createState() => _LinkedAccountOptionState();
}

class _LinkedAccountOptionState extends State<LinkedAccountOption> {
  TextEditingController tc = TextEditingController();
  LinkedAccountController lc = Get.find<LinkedAccountController>();
  MainAppController mc = Get.find<MainAppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.user_acc.value == null
          ? SpinKitWave(
              color: MainColors.purple,
              size: 30,
            )
          : widget.user_acc.value.account.dapperID == null
              ? InkWell(
                  onTap: () async {
                    await SetAccountDialog(context);
                  },
                  child: Container(
                      height: 50,
                      child: Row(children: [
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () async {
                              await SetAccountDialog(context);
                            }),
                        Text(
                          "Tap to link",
                          style: TextStyle(
                              fontFamily: "Lexend",
                              fontWeight: FontWeight.w200),
                        ),
                      ])),
                )
              : Container(
                  color: MainColors.black.shade800,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: lc.deletinguser.isFalse
                            ? [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(widget
                                          .user_acc
                                          .value
                                          .account
                                          .profileImageUrl),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      "${widget.user_acc.value.account.username}",
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                IconButton(
                                    enableFeedback: false,
                                    splashRadius: 2,
                                    color: MainColors.purple.shade300,
                                    iconSize: 29,
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.close),
                                    onPressed: () async {
                                      FocusScope.of(context).unfocus();
                                      lc.deletinguser.toggle();
                                      await mc.setaccountonuser(UserD());
                                      lc.deletinguser.toggle();
                                    })
                              ]
                            : [Text("Deleting User...")]),
                  ),
                );
    });
  }

  Future<void> SetAccountDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Enter your dapper username",
                      style: TextStyle(
                          fontFamily: "Lexend",
                          fontWeight: FontWeight.w400,
                          color: MainColors.white)),
                  SizedBox(height: 20),
                  TextField(
                    controller: tc,
                  ),
                  SizedBox(height: 20),
                  Container(
                    color: MainColors.purple,
                    child: TextButton(
                        style: ButtonStyle(),
                        onPressed: () => {
                              FocusScope.of(context).unfocus(),
                              lc.GetDapperAcc(tc.text)
                            },
                        child: Text("Get Account",
                            style: TextStyle(
                                fontFamily: "Lexend",
                                fontWeight: FontWeight.w200,
                                color: MainColors.white))),
                  ),
                  Obx(() {
                    return lc.loadinguser.isTrue
                        ? Column(children: [
                            SizedBox(height: 40),
                            SpinKitWave(
                              color: MainColors.purple,
                              size: 30,
                            )
                          ])
                        : lc.dapperuser.value.dapperID == null
                            ? SizedBox.shrink()
                            : Column(children: [
                                SizedBox(height: 20),
                                Container(
                                  color: MainColors.black.shade800,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(lc
                                                    .dapperuser
                                                    .value
                                                    .profileImageUrl!),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "${lc.dapperuser.value.username}",
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          IconButton(
                                              enableFeedback: false,
                                              splashRadius: 2,
                                              iconSize: 32,
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(Icons.add),
                                              onPressed: () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                Navigator.pop(context);
                                                await mc.setaccountonuser(
                                                    lc.dapperuser.value);
                                              })
                                        ]),
                                  ),
                                )
                              ]);
                  })
                ],
              ),
            );
          });
        });
  }
}
