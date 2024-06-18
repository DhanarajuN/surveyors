import 'package:flutter/material.dart';
import 'package:Surveyors/view/login_screens/dashboard_screen.dart';
import 'package:Surveyors/view/login_screens/sign_in_otp.dart';

import 'otp_screen.dart';

class SignInPasswordScreen extends StatefulWidget {
  const SignInPasswordScreen({super.key});

  @override
  State<SignInPasswordScreen> createState() => _SignInPasswordScreenState();
}

class _SignInPasswordScreenState extends State<SignInPasswordScreen> {
  final Color customColor = Color(0xFF0078FF);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  // RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: customColor,
        body: Container(
          margin: const EdgeInsets.all(30.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'images/rectangle_logo.png', // Replace with your logo image path
                width: 75.0,
                height: 75.0,
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
                    'ZOV',
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
                    color: Colors.white, fontSize: 12, fontFamily: 'OpenSans'),
              ),
              const SizedBox(height: 45.0),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: const [
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
                controller: _userName,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter email address',
                  hintStyle: TextStyle(
                    color: Colors.white,
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
                  if (value == null || value.isEmpty) {
                    return 'Please enter Valid Emailid';
                  } else if (emailRegex.hasMatch(value.trim()) == false) {
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
                    'PASSWORD',
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
                controller: _phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    color: Colors.white,
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
                  print('phone $value ');
                  if (value == null || value.isEmpty) {
                    return 'Please enter Password ';
                    // } else if ((phoneRegex.hasMatch(value.trim()) == false)||(value.length!=10)) {
                    //   return 'Please enter a valid Password';
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  final isValid = _formKey.currentState?.validate();
                  print(
                      'valid $isValid user$_userName.text.trim()  ph $_phoneNumber.text');
                  if (isValid == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DashBoardPage(
                                //mobileNumber: _phoneNumber.text,
                                )));
                    // Map<String, dynamic> parms = {
                    //   "email_id": _userName.text.trim(),
                    //   "password": _phoneNumber.text.trim()
                    // };
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Change button color here
                  minimumSize: const Size(
                      double.infinity, 50), // Increase button size here
                ),
                child: const Text(
                  'Sign IN',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // const Text(
                  //   "Already have an account?",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  const SizedBox(width: 3.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInOtpScreen()));
                    },
                    child: const Text(
                      'Login With OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
