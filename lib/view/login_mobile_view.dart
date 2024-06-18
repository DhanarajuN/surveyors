import 'package:Surveyors/res/components/button_component.dart';
import 'package:Surveyors/res/components/inputTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/login_view_mode.dart';

class LoginMobileView extends StatelessWidget {
  LoginMobileView({super.key});
  final TextEditingController _emailController =
      TextEditingController(text: "Rekha_Mobile");
  final TextEditingController _passwordController =
      TextEditingController(text: "PQMS@2022");

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginViewModel>(context);

    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: Colors.red,
                )),
            SingleChildScrollView(
              child: Column(
                children: [
                  AppInputTextField(
                      prefixIcon: const Icon(Icons.email),
                      controller: _emailController,
                      hintText: "Please enter email"),
                  AppInputTextField(
                      prefixIcon: const Icon(Icons.email),
                      controller: _passwordController,
                      hintText: "Please enter password"),
                  AppButton(
                    text: "Login ${loginProvider.couter}",
                    onPressed: () {
                      loginProvider.couter++;
                      loginProvider.loginTheUser(_emailController.text,
                          _passwordController.text, context);
                    },
                  ),
                  AppButton(
                    text: "Add User To Collection",
                    onPressed: () {
                      loginProvider.couter++;
                      loginProvider.addDataToFirStore();
                    },
                  ),
                  AppButton(
                    text: "Get Collection",
                    onPressed: () {
                      loginProvider.couter++;
                      loginProvider.getUsers();
                    },
                  )
                ],
              ),
            )
          ]),
    );
  }
}
