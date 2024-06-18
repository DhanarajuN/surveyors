import 'package:flutter/material.dart';
import 'package:Surveyors/view/login_screens/otp_screen.dart';
import 'package:Surveyors/view/login_screens/sign_in_password.dart';

class SignInOtpScreen extends StatelessWidget {
  final Color customColor = Color(0xFF0078FF);
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

  SignInOtpScreen({Key? key}) : super(key: key);

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

              // Email Address
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
                  print('value $value');
                  if (value == null || value.isEmpty) {
                    return 'Please enter Valid Emailid';
                  } else if ((emailRegex.hasMatch(value.trim()) == false)) {
                    return 'Please enter a valid email id';
                  }
                },
              ),
              const SizedBox(height: 20.0),
              Row(children: [
                Container(
                  height: 1,
                  color: Colors.white,
                  width: (MediaQuery.of(context).size.width / 2) - 46,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  'OR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  height: 1,
                  color: Colors.white,
                  width: (MediaQuery.of(context).size.width / 2) - 46,
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              // Mobile Number
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'MOBILE NUMBER',
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
                maxLength: 10,
                controller: _phoneNumber,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Enter your mobile number',
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
                  print('phone $value ');
                  if (value == null || value.isEmpty) {
                    return 'Please enter Phone Number ';
                  } else if ((phoneRegex.hasMatch(value.trim()) == false) ||
                      (value.length != 10)) {
                    return 'Please enter a valid Phone Number';
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
                            builder: (context) => OtpScreen(
                                  mobileNumber: _phoneNumber.text,
                                )));
                    // Map<String, dynamic> parms = {
                    //   "email_id": _userName.text.trim(),
                    //   "password": _phoneNumber.text.trim()
                    // };
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Change button color here
                  minimumSize:
                      Size(double.infinity, 50), // Increase button size here
                ),
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // const Text(
                  //   "Don't have an account?",
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
                              builder: (context) =>
                                  const SignInPasswordScreen()));
                    },
                    child: const Text(
                      'Login With Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      counterStyle: const TextStyle(color: Colors.white),
      // prefixIcon: prefixIcon,
      // suffixIcon: suffixIcon
      //     ? IconButton(
      //         onPressed: () {
      //           setState(() {
      //             passwordVisible = !passwordVisible;
      //           });
      //         },
      //         icon: Icon(
      //           passwordVisible ? Icons.visibility : Icons.visibility_off,
      //           color: Colors.white,
      //         ))
      //     : null,
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      fillColor: Colors.white,
    );
  }
}
