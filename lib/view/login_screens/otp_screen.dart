import 'dart:async';
import 'dart:convert';
//import 'dart:ffi';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/image_constants.dart';
import 'package:Surveyors/view/login_screens/dashboard_screen.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:http/http.dart' as http;
import 'package:Surveyors/model/login_data_model.dart';
import 'package:Surveyors/data/local_store_helper.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key, required this.mobileNumber});

  String mobileNumber;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  int _start = 60;
  var otp_timer = '';
  var isResendButtonEnabled = false;
  OtpFieldController otpController = OtpFieldController();
  late LoginDataModel signInData = LoginDataModel();
  String otp = '';
  String otp_text = '';
  String not_receive = '';
  var role = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: KColors.appColor,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    color: Colors.white,
                    child: Image.asset(
                      ImageConstants
                          .login_logo, // Replace with your logo image path
                       width: 120.0,
//height: 160.0,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'A verification code  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'has been sent to',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.mobileNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  const SizedBox(height: 50),
                  OTPTextField(
                    otpFieldStyle: OtpFieldStyle(
                        borderColor: Colors.white,
                        backgroundColor: Colors.white),
                    controller: otpController,
                    length: 6,
                    obscureText: true,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle
                        .box, // Use FieldStyle.box to display fields as boxes
                    outlineBorderRadius: 15,
                    style:
                        const TextStyle(fontSize: 25, color: KColors.appColor),
                    onCompleted: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                  ),

                  /*OtpTextField(
                  // controller: _otpController,
                  numberOfFields: 6,
                  fieldWidth: 15,
                ),*/
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 150, // Set the desired width of the button
                    child: ElevatedButton(
                      onPressed: () {
                        if (otp != '') {
                          AppLoader.showLoader();
                          otpValidationApi(widget.mobileNumber, otp);
                        } else {
                          showToast('Please Enter OTP');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Change button color here
                        // Increase button size here
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isResendButtonEnabled)
                    const Text(
                      "Didn't received code?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: isResendButtonEnabled
                            ? () {
                                AppLoader.showLoader();
                                setState(() {
                                  _start = 60;
                                  startTimer();
                                });
                                getSigninDataFromServer(
                                    widget.mobileNumber, '');
                              }
                            : null,
                        child: Container(
                          decoration: isResendButtonEnabled
                              ? const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.white,
                                      width:
                                          2.0, // Adjust the width of the underline here
                                    ),
                                  ),
                                )
                              : null,
                          child: Text(
                            '$otp_text',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ),
                      Text(otp_timer,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            otp_text = 'Resend again';
            isResendButtonEnabled = true;
            timer.cancel();
            otp_timer = '';
          });
        } else {
          setState(() {
            otp_text = 'OTP Sent';
            isResendButtonEnabled = false;
            _start--;
            otp_timer = '($_start s)';
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void otpValidationApi(String emailId, String phoneNumber) async {
    final loginUrl = Uri.parse(
        '${ApiConstants.baseUrl}api/authentication/loginvalidateotp?username=${widget.mobileNumber}&otp=$otp');
    print(loginUrl);
    var response = await http.get(loginUrl);
    Map<String, dynamic> loginResponse = jsonDecode(response.body);
    print(loginResponse);
    final String status = loginResponse['status'] as String;
    if (status == '1') {
      Map<String, dynamic> map = jsonDecode(response.body);
      LoginDataModel logininResponse = LoginDataModel.fromJson(map);
      print('login response:${logininResponse.toJson()}');
      writeTheData('userName', logininResponse.name);
    //  writeTheData('profileImage', logininResponse.userImagePath);
      writeTheData('userId', logininResponse.accountUserId);
      writeTheData('mallId', logininResponse.mallId);
      writeTheData('userMail', logininResponse.username);
      writeTheData('accessToken', logininResponse.accessToken);
      writeTheData('role', '${logininResponse.accRoleName}');
      role = '${logininResponse.accRoleName}';
      AppLoader.hideLoader();
      if (logininResponse.accRoleName == 'HR Manager') {
        writeTheData('role', 'Clientele');
        role = 'Clientele';
      } else if (logininResponse.accRoleName == 'Employee') {
        writeTheData('role', 'Employees');
        role = 'Employees';
      } else {
        writeTheData('role', logininResponse.accRoleName);
        role = logininResponse.accRoleName!;
      }

      // writeTheData('role', '${logininResponse.accRoleName}');
      //  role = '${logininResponse.accRoleName}';
      print('role:$role');
      print('mallId:${logininResponse.mallId}');
      print('Keyword:${logininResponse.username}');
      var findJobId ='';
          //'${ApiConstants.getMasters}type=$role&mallId=${logininResponse.mallId}&keyWord=${logininResponse.username}';
      Map<String, dynamic> jsonData = await ServerCall.getRequest(
        findJobId,
        token: logininResponse.accessToken,
      );
      var status = jsonData['status'];
      var jobs = jsonData['jobs'];
      setState(() {
        if (jobs != null && jobs.toString().isNotEmpty) {
          var jobId = jobs[0]['id'];
          writeTheData('jobId', jobId);
        }
      });

      //   Navigator.pushReplacementNamed(context, '/dashboard');

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DashBoardPage()));
      print('mail:${logininResponse.username}');
    } else {
      final errorMessage = loginResponse['msg'];
      print('otpmsg:$errorMessage');
      showToast(errorMessage);
    }
  }

  void getSigninDataFromServer(String emailId, String phoneNumber) async {
    final loginUrl = Uri.parse(
        '${ApiConstants.baseUrl}api/authentication/loginotp?username=$emailId');
    print(loginUrl);
    var response = await http.get(loginUrl);
    AppLoader.hideLoader();
    Map<String, dynamic> loginResponse = jsonDecode(response.body);
    print(loginResponse);
    final String status = loginResponse['status'] as String;
    if (status == '1') {
      showToast(loginResponse['message'] as String);
    } else {
      final errorMessage = loginResponse['message'] as String;
      showToast(errorMessage);
    }
  }
}
