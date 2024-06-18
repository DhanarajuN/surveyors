import 'package:Surveyors/res/components/base_scafflod.dart';
import 'package:Surveyors/view/login_mobile_view.dart';
import 'package:Surveyors/view_model/login_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewModel>(context);
    loginProvider.setUpTheFirebase(context);
    return BaseScaffold(
      mobile: LoginMobileView(),
      tablet: Container(color: Colors.blue),
      web: Container(color: Colors.green),
    );
  }
}

//view->view_model->repository->baseClients
