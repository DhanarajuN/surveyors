import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../bottom_view/all_claims.dart';
import '../bottom_view/dashboard_status.dart';
import '../bottom_view/reoprts.dart';

class NavigationAppBar extends StatefulWidget {
  final String name;
  NavigationAppBar({required this.name, Key? key}) : super(key: key);

  @override
  State<NavigationAppBar> createState() => _NavigationAppBarState();
}

class _NavigationAppBarState extends State<NavigationAppBar> {
  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (widget.name == 'Reports') {
      screen = ReoprtsScreen();
    } else if (widget.name == 'Claims') {
      screen = AllClaimsScreen();
    } else if (widget.name == 'Dashboard') {
      screen = DashboardStatus();
    } else {
      screen = Placeholder();
    }

    return Scaffold(
    appBar: AppBar(
        backgroundColor: KColors.appColor,
        title: Text('${widget.name}',style: KTextStyle.appTitleFontStyle,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: screen, // Display the selected screen
    );
  }
}
