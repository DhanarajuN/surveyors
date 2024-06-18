import 'package:Surveyors/res/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  BaseScaffold(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.web});
  final Widget mobile;
  final Widget tablet;
  final Widget web;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.app_bg_color,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 650) {
            return mobile;
          } else if (constraints.maxWidth < 900) {
            return tablet;
          } else {
            return web;
          }
        },
      ),
    );
  }
}
