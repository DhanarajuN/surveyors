import 'dart:io';

import 'package:Surveyors/data/bae_api_client.dart';
import 'package:Surveyors/model/login_payload.dart';
import 'package:Surveyors/repository/login_repository.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../push_notification.dart';

class LoginViewModel with ChangeNotifier {
  final _loginRepository = LoginRepository();
  int _couter = 0;
  int get couter => this._couter;
  DatabaseReference ref = FirebaseDatabase.instance.ref("CggUsers/");

  set couter(int value) => this._couter = value;

  loginTheUser(String userName, String password, BuildContext context) async {
//UPDATE
// await ref.child().update({
//   //"age": 21,
//   "number":9099999
// });

//ADD
    await ref.child("sai").set({
      "name": "sai",
      "age": 15,
      "address": {"line1": "100 Mountain View"}
    });

    AppLoader.showLoader(message: "login...");
    final loginRequestPayload = LoginPayload(
        iMEI: "45646346",
        deviceId: "564858457848",
        password: password,
        username: userName);
    final result = await _loginRepository.loginTheUser(loginRequestPayload);
    AppLoader.hideLoader();
    if (result.statusCode == ApiErrorCodes.success) {
      //context.go('/details');
      GoRouter.of(context).go(RoutesList.dashBoard);
    } else if (result.statusCode == ApiErrorCodes.invalid) {
      //alert with message
      //result.statusMessage
      showToast(result.statusMessage ?? "");
    } else {}
    notifyListeners();
  }

  addDataToFirStore() {
    CollectionReference users =
        FirebaseFirestore.instance.collection('CggUsers');
    users
        .add({
          'full_name': "sai", // John Doe
          'company': "cgg", // Stokes and Sons
          'age': 22 // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  getUsers() {
    FirebaseFirestore.instance
        .collection('testing')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc);
      });
    });
  }

  updateUser() {}
  deleteUser() {}

  setUpTheFirebase(BuildContext context) async {
    await FirebaseMessaging.instance.subscribeToTopic('12345');

    LocalNotificationService.initialize(context);
    final fcmToken = await FirebaseMessaging.instance.getToken();

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        // Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }

      LocalNotificationService.display(message);
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      // final routeFromMessage = message.data["route"];

//      Navigator.of(context).pushNamed(routeFromMessage);
    });
  }
}
