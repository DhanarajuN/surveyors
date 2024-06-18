import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/image_constants.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:Surveyors/view/login_screens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userId = "";

  @override
  void initState() {
    super.initState();
    getUserId();
    Future.delayed(const Duration(seconds: 4), () {
      if (userId.isNotEmpty) {
        GoRouter.of(context).go(RoutesList.dashBoard);
      } else {
        GoRouter.of(context).go(RoutesList.login);
      }
    });
  }

  getUserId() async {
    var id = await readTheData('userId');
    setState(() {
      userId = id!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.appColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.white,
              child: Image.asset(
                ImageConstants.login_logo,
                width: 120.0,
               // height: 100.0,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'WELCOME TO',
            style: TextStyle(
                color: Colors.white, fontSize: 16.0, letterSpacing: 6),
          ),
          const Text(
            '${ApiConstants.appName}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 6),
          ),
        ],
      ),
    );
  }
}
