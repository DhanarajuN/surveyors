import 'dart:convert';

import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:flutter/material.dart';
import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/model/login_data_model.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/image_constants.dart';
import 'package:Surveyors/view/login_screens/sign_in_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  String userName = '';
  String password = '';
  String? _selectedTenant;

  var role = '';
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: KColors.appColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 100,
                ),
                Container(
                  // width: 100.0,
                  // height: 100.0,
                  color: Colors.white,
                  child: Image.asset(
                    ImageConstants
                        .login_logo, // Replace with your logo image path
                    width: 120.0,
                    // height:50.0,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Sign in to ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    Text(
                      '${ApiConstants.appName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Enter your credentials to proceed',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'OpenSans'),
                ),
                const SizedBox(height: 45.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: const [
                //     Text(
                //       'Tenant',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 10,
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 8),
                // DropdownButtonFormField<String>(
                //   value: _selectedTenant,
                //   onChanged: (String? newValue) {
                //     setState(() {
                //       _selectedTenant = newValue;
                //     });
                //   },
                //   dropdownColor: Colors.white,
                //   decoration: InputDecoration(
                //     hintText:
                //         _selectedTenant == null ? 'Select a tenant' : null,
                //     hintStyle: const TextStyle(
                //       color: Colors.white,
                //     ),
                //     border: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.white,
                //       ),
                //     ),
                //     enabledBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.white,
                //       ),
                //     ),
                //     focusedBorder: const OutlineInputBorder(
                //       borderSide: BorderSide(
                //         color: Colors.white,
                //       ),
                //     ),
                //   ),
                //   icon: const Icon(Icons.arrow_drop_down,
                //       color: Colors.white), // Set dropdown icon color to white
                //   items: <String>['JCG']
                //       .map<DropdownMenuItem<String>>((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(
                //         value,
                //         style: const TextStyle(
                //           color: Colors
                //               .black, // Set dropdown item text color to black
                //         ),
                //       ),
                //     );
                //   }).toList(),
                //   style: const TextStyle(
                //     color:
                //         Colors.white, // Set selected item text color to white
                //   ),
                //   selectedItemBuilder: (BuildContext context) {
                //     return <String>['JCG']
                //         .map<Widget>((String value) {
                //       return Text(
                //         value,
                //         style: const TextStyle(
                //           color: Colors
                //               .white, // Set selected item text color to white
                //         ),
                //       );
                //     }).toList();
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please select a tenant';
                //     }
                //   },
                // ),
                // const SizedBox(height: 8),

                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'EMAIL ADDRESS',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ]),
                const SizedBox(height: 8),
                TextFormField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: _userName,
                  keyboardType: TextInputType.emailAddress,
                  //  decoration: inputDecoration('Enter email address'),
                  decoration: const InputDecoration(
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  validator: (value) {
                    userName = value!;
                    print('value $value');
                    if (value == null || value.isEmpty) {
                      return 'Please enter Valid Emailid';
                    } else if ((emailRegex.hasMatch(value.trim()) == false)) {
                      return 'Please enter a valid email id';
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                // Mobile Number
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                    // Text(
                    //   'Forgot Password?',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 10,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 8),
                TextFormField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  controller: _phoneNumber,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  validator: (value) {
                    password = value!;
                    print('password $value ');
                    if (value == null || value.isEmpty) {
                      return 'Please enter password ';
                    }
                    // else if ((phoneRegex.hasMatch(value.trim()) == false) ||
                    //     (value.length != 10)) {
                    //   return 'Please enter a valid Phone Number';
                    // }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate();
                    if (isValid == true) {
                      AppLoader.showLoader();
                      loginWithPassword(userName, password);
                      print('username:$userName  pass:$password');
                    }
                    print(
                        'valid $isValid user$_userName.text.trim()  ph $_phoneNumber.text');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Change button color here
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5.0), // Set border radius to 0.0 for a square button
                    ), // Increase button size here
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     // const Text(
                //     //   "Already have an account?",
                //     //   style: TextStyle(
                //     //     color: Colors.white,
                //     //   ),
                //     //),
                //     const SizedBox(width: 3.0),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => SignInScreen()));
                //       },
                //       child: const Text(
                //         'Login with Otp',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginWithPassword(String username, String password) async {
    var url = '${ApiConstants.baseUrl}api/v1/users/login';
    var headers = <String, String>{};
    headers['X-Tenant'] = ApiConstants.tenant;
    headers['Content-Type'] = 'application/json';
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(<String, dynamic>{
          'username': '$username',
          'password': '$password',
        }),
        headers: headers);
    Map<String, dynamic> loginResponse = jsonDecode(response.body);
    print(loginResponse);
    final String status = loginResponse['status'] as String;
    if (status == 'Success') {
      Map<String, dynamic> map = jsonDecode(response.body);
      print(map);
      LoginDataModel logininResponse = LoginDataModel.fromJson(map);
      print(
          '${logininResponse.accRoleName} ${logininResponse.username} ${logininResponse.mallId}');

      //    Navigator.pushReplacementNamed(context, '/dashboard');

      print('login response:${logininResponse.toJson()}');
      writeTheData('userName', logininResponse.name);
      // writeTheData('profileImage', logininResponse.userImagePath);
      writeTheData('userId', logininResponse.accountUserId);
      writeTheData('mallId', logininResponse.mallId);
      writeTheData('userMail', logininResponse.username);
      writeTheData('accessToken', logininResponse.accessToken);
      print('tokenn:${logininResponse.accessToken}');
      writeTheData('role', logininResponse.accRoleName);
      // if (logininResponse.accRoleName == 'HR Manager') {
      //   writeTheData('role', 'Clientele');
      //   role = 'Clientele';
      // } else if (logininResponse.accRoleName == 'Employee') {
      //   writeTheData('role', 'Employees');
      //   role = 'Employees';
      // } else {
      //   writeTheData('role', logininResponse.accRoleName);
      //   role = logininResponse.accRoleName!;
      // }

      // writeTheData('role', '${logininResponse.accRoleName}');
      //  role = '${logininResponse.accRoleName}';
      print('role:$role');
      print('mallId:${logininResponse.mallId}');
      print('Keyword:${logininResponse.username}');
      AppLoader.hideLoader();
      // var findJobId =
      //     '${ApiConstants.getMasters}type=$role&mallId=${logininResponse.mallId}&keyWord=${logininResponse.username}';
      // Map<String, dynamic> jsonData = await ServerCall.getRequest(
      //   findJobId,
      //   token: logininResponse.accessToken,
      // );
      // var status = jsonData['status'];
      // var jobs = jsonData['jobs'];
      // setState(() {
      //   if (jobs != null && jobs.toString().isNotEmpty) {
      //     var jobId = jobs[0]['id'];
      //     writeTheData('jobId', jobId);
      //   }
      // });

      GoRouter.of(context).push(RoutesList.dashBoard);
    } else {
      AppLoader.hideLoader();

      final errorMessage = loginResponse['msg'] as String;
      showToast(errorMessage);
    }
  }
}
