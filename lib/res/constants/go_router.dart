import 'package:Surveyors/model/recommended_policies_model.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:Surveyors/view/DashBoard/appbar.dart';
import 'package:Surveyors/view/bottom_view/nav_items.dart';
import 'package:Surveyors/view/bottom_view/reoprts.dart';
import 'package:Surveyors/view/dash_board.dart';
import 'package:Surveyors/view/general/amount_range.dart';
import 'package:Surveyors/view/general/basic_location.dart';
import 'package:Surveyors/view/general/interests.dart';
import 'package:Surveyors/view/login_screens/dashboard_screen.dart';
import 'package:Surveyors/view/login_screens/sign_in_screen.dart';
import 'package:Surveyors/view/login_screens/sign_up_screen.dart';
import 'package:Surveyors/view/login_screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view/bottom_view/dashboard_status.dart';


final GoRouter routes = GoRouter(
  initialLocation: RoutesList.splashPage,
  routes: <RouteBase>[
    GoRoute(
        path: RoutesList.splashPage,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        }),
    GoRoute(
      path: RoutesList.dashBoard,
      builder: (BuildContext context, GoRouterState state) {
        return const DashBoardPage();
      },
    ),
    GoRoute(
      path: RoutesList.login,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: RoutesList.homePage,
      builder: (BuildContext context, GoRouterState state) {
        return const DashBoardPage();
      },
    ),
    GoRoute(
      path: RoutesList.interestsPage,
      builder: (context, state) {
        return const InterestsScreen();
      },
    ),
    GoRoute(
      path: RoutesList.bascicDetails,
      builder: (context, state) {
        return const BasicLocationDetailsScreen();
      },
    ),
    GoRoute(
      path: RoutesList.basicDetailsRange,
      builder: (context, state) {
        return const AmountRangeScreen();
      },
    ),
    GoRoute(
      path: RoutesList.childScreen,
      builder: (context, state) {
        final status = state.queryParams['status'];
        final value=state.queryParams['value'];
        final jobtype=state.queryParams['type'];
        print('jobtype::::${jobtype}');
        return ChildScreen(status: '${status}',value: '${value}',jobtype: '${jobtype}',);
      },
    ),
     GoRoute(
      path: RoutesList.navigation,
      builder: (context, state) {
        final name = state.queryParams['name'];
        return NavigationAppBar(name: '${name}');}
    ),
    GoRoute(
      path: RoutesList.dashboardStatus,
      builder: (context, state) {
        return DashboardStatus();
      },
    ),
     GoRoute(
      path: RoutesList.reports,
      builder: (context, state) {
        return ReoprtsScreen();
      },
    ),
    // GoRoute(
    //   path: RoutesList.recommendedPoliciesPage,
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const RecommendedScreen();
    //   },
    // ),
  ],
);
