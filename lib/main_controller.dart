import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topshot_scan/models/AppUser.dart';
import 'package:topshot_scan/models/UserD.dart';
import 'package:topshot_scan/repositories/Users_repo.dart';

class MainAppController extends GetxController {
  static MainAppController get to => Get.find();

  MainAppController(this.user_repo);

  final Users_repo user_repo;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseMessaging _fm = FirebaseMessaging.instance;
  final gsign = GoogleSignIn();

  Rx<User> firebaseuser = Rx<User>();
  // Rx<StreamSubscription<DocumentSnapshot>> userdata =
  //     Rx<StreamSubscription<DocumentSnapshot>>();
  Rx<AppUser> userdata = Rx<AppUser>();

  var fcmtoken = "".obs;
  var linkedaccount = {}.obs;

  var logged_in = false.obs;
  var down = false.obs;
  var logging_in = false.obs;
  var logging_out = false.obs;

  @override
  void onInit() async {
    super.onInit();

    // Bind user to auth state
    firebaseuser.bindStream(_auth.authStateChanges());

    // If user changes update the userdata binding
    _auth.authStateChanges().listen((User? user) {
      userdata.bindStream(db
          .collection('users')
          .doc(firebaseuser.value.uid)
          .snapshots()
          .map((event) => AppUser.fromMap({
                "name": event.data()!['name'],
                "email": event.data()!['email'],
                "account": event.data()!['account']
              })));
    });

    // --------------- Push Notification settings ---------------
    NotificationSettings settings = await _fm.requestPermission();

    await _fm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      fcmtoken.value = await _fm.getToken();
      print("${await _fm.getToken()}");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
    //------------------------------------------------------------
  }

  void gSign() async {
    logging_in.toggle();
    var user;

    try {
      user = await gsign.signIn();
    } catch (e) {
      Get.snackbar(
          "Error", "Issue while logging in, try restarting the application");
    }

    if (user == null) {
      logging_in.toggle();
      return;
    } else {
      final gauth = await user.authentication;
      final creds = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);

      await _auth.signInWithCredential(creds);
      try {
        db.collection('users').doc(firebaseuser.value.uid).set({
          'name': firebaseuser.value.displayName,
          'email': firebaseuser.value.email,
        }, SetOptions(merge: true));
      } catch (e) {
        print("error is creating user $e");
      }

      logging_in.toggle();
    }
  }

  void gLog() async {
    logging_out.toggle();
    await gsign.disconnect();
    await _auth.signOut();
  }

  setaccountonuser(d) async {
    db
        .collection('users')
        .doc(firebaseuser.value.uid)
        .update({"account": d.toMap()});
  }
}
