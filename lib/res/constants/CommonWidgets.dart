import 'dart:convert';

import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/model/field_model.dart';
import 'package:Surveyors/model/field_model.dart';
import 'package:Surveyors/model/field_model.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:Surveyors/view/login_screens/dashboard_screen.dart';
import 'package:Surveyors/view/web_view.dart';
import 'package:flutter/material.dart';

import '../../model/field_model.dart';

class CommonWidgtes {
  static String premium1 = '';
  static String sumInsured1 = '';
  static String type1 = '';
  static BuildContext? _context;
  static String formattedDueDate = '';
  static String currentDate = '';
  static String formattedDueDate_ = '';
  static String currentDate_ = '';

  static showBottomSheet(BuildContext context,
      {required String sumInsured,
      required String premium,
      required Map<String, dynamic> json,
      required String type}) {
    _context = context;
    DateTime currentDate1 = DateTime.now();
    premium1 = premium;
    type1 = type;
    sumInsured1 = sumInsured;
    currentDate =
        "${currentDate1.day.toString().padLeft(2, '0')}/${currentDate1.month.toString().padLeft(2, '0')}/${currentDate1.year}";
    DateTime dueDate = currentDate1.add(const Duration(days: 365));
    formattedDueDate =
        "${dueDate.day.toString().padLeft(2, '0')}/${dueDate.month.toString().padLeft(2, '0')}/${dueDate.year}";
    currentDate_ =
        "${currentDate1.month.toString().padLeft(2, '0')}/${currentDate1.day.toString().padLeft(2, '0')}/${currentDate1.year}";
    formattedDueDate_ =
        "${dueDate.month.toString().padLeft(2, '0')}/${dueDate.day.toString().padLeft(2, '0')}/${dueDate.year}";
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Due Date field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Due Date',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '$formattedDueDate',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      enabled: false,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                // Fee Amount field
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Fee Amount',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: '$premium1',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textAlign: TextAlign.center,
                      enabled: false,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // "Pay Online" Button
                Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      var url =
                          'http://devamc.mmcdevops.com:8081/RazorPay/razorpay?amount=$premium1';
                      Navigator.of(context).pop();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MyWebView(url: url),
                      //   ),
                      // );
                      //Future.delayed(const Duration(milliseconds: 10000), () {
                      postJob(_context!, json, "Policies");
                      //});
                    },
                    child: const Text('Pay Online'),
                  ),
                ),
                const SizedBox(height: 10),
                // "Increase Limit of Liability" Button
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      showIncreaseLiabilityDialog(context);
                    },
                    child: const Text('Increase Limit of Liability'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showIncreaseLiabilityDialog(BuildContext context) {
    int aa = int.parse('${sumInsured1}') * 5;

    TextEditingController amountController = TextEditingController();
    bool isAmountValid = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cover Opted'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                'Enter amount between ${sumInsured1} to ${aa} and should be multiple of 1 lakhs',
                style: const TextStyle(color: Colors.red, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: TextFormField(
                  controller: amountController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor:
                        isAmountValid ? Colors.green.withOpacity(0.2) : null,
                    // : Icon(
                    //   amountController.text.isEmpty
                    //       ? Icons.close
                    //       : (isAmountValid ? Icons.check : Icons.close),
                    //   color: amountController.text.isEmpty
                    //       ? Colors.red
                    //       : (isAmountValid ? Colors.green : Colors.red),
                    // ),
                  ),
                  onChanged: (value) {
                    int enteredAmount = int.tryParse(value) ?? 0;
                    isAmountValid =
                        enteredAmount >= int.parse('${sumInsured1}') &&
                            enteredAmount <= aa &&
                            enteredAmount % 100000 == 0;
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle submit action
                    int enteredAmount =
                        int.tryParse(amountController.text) ?? 0;
                    print('${enteredAmount >= int.parse('${sumInsured1}')}'
                        '${enteredAmount <= aa}'
                        '${enteredAmount % 100000 == 0}');
                    if (enteredAmount >= int.parse('${sumInsured1}') &&
                        enteredAmount <= aa &&
                        enteredAmount % 100000 == 0) {
                      // Valid input, proceed with submit action

                      // Set a success state for the input

                      sumInsured1 = enteredAmount.toString();

                      premium1 = (enteredAmount / 20).toString();
                      isAmountValid = true;
                      Navigator.pop(context);

                      // Close the dialog after a brief delay
                      // Future.delayed(const Duration(seconds: 1), () {});
                    } else {
                      showToast("Invalid Amount:$enteredAmount");
                      // Invalid input, do nothing
                    }
                  },
                  child: const Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15), // Adjust padding
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static postJob(
      BuildContext context, Map<String, dynamic> json, String type) async {
    print('aviiii:$json  ');
    var id = await readTheData('userId');
    var mallid = await readTheData('mallId');
    var userMail = await readTheData('userMail');
    var fields = await readFieldsData('policyFields');
    var jobId = await readTheData('jobId');
    var accessToken = await readTheData('accessToken');

    FieldData modelResponse = FieldData.fromJson1(json, fields);
    int jobId1 = json['id'];
    print('item code:${modelResponse.dropdown}');
    modelResponse.data['Initiators_email'] = userMail;

    modelResponse.data['Sum Insured'] = sumInsured1;
    modelResponse.data['Total Premium'] = premium1;
    modelResponse.data['Polcy Start Date'] = currentDate_;
    modelResponse.data['Polcy End Date'] = formattedDueDate_;
    print(currentDate_);
    print(formattedDueDate_);

    var dt = '';
    if (type == 'Policies') {
      dt = 'CAMPAIGNS';
    } else {
      dt = 'CAMPAIGNS';
    }
    var jsonData = {
      'list': [modelResponse.data]
    };
    var jsonEncoded = jsonEncode(jsonData);
    var requestBody = {
      'userId': '$mallid',
      'consumerEmail': '$userMail',
      'type': '$type',
      'json': '$jsonEncoded', // Replace with your actual JSON data
      'dt': '$dt',
      'category': 'Services',
      'parentJobId': '$jobId',
    };
    print(jsonEncoded);
    try {
      // var url = await ApiConstants.postedJobApi(
      //     jsonEncoded, "$type", mallId, userMail, jobId);
      // showToast(url);
      Map<String, dynamic> jsonData = await ServerCall.postRequest(
          ApiConstants.jobCreate,
          token: accessToken,
          body: requestBody);
      var json = jsonData['myHashMap'];
      var msg = json['message'];
      if (msg == 'Jobs saved') {
        showToast(msg);
        if (type1 == "Interested Policies") {
          Map<String, dynamic> jsonData2 = await ServerCall.getRequest(
              '${ApiConstants.jobDelete}$jobId1',
              token: accessToken);
          print('jobbbbb:$jobId1');

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashBoardPage()));
        }
      }
      // Extract the key-value message from the response
      // var message = responseBody['message'];
    } catch (e) {
      print('Error occurred during POST request: $e');
      showToast("$e");
    }

    print(jsonEncoded);
  }

  static editFieldsWidget(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text('Login'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        // icon: Icon(Icons.account_box),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        // icon: Icon(Icons.email),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Message',
                        icon: Icon(Icons.message),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text("Submit"),
                  onPressed: () {
                    // your code
                  })
            ],
          );
        });
  }
}
