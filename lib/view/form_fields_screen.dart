import 'dart:convert';

import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/model/field_model.dart';
import 'package:Surveyors/model/subjobs_model.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormFieldsScreen extends StatefulWidget {
  FormFieldsScreen(
      {super.key,
      required this.type,
      required this.id,
      this.fieldsValue,
      required this.onScreenPopped});
  String type;
  int? id;
  final FieldData? fieldsValue;
  final Function onScreenPopped;
  @override
  State<FormFieldsScreen> createState() => _FormFieldsScreenState();
}

class _FormFieldsScreenState extends State<FormFieldsScreen> {
  var name = '';
  var userMail = '';
  int userId = 0;
  int mallId = 0;
  var accessToken = '';
  String dt = '';
  List<Fields> actionFields = [];
  List<String> groupNames = []; // Store unique group names
  List<List<Widget>> dividedFields = [];
  DateTime? selectedDate;
  String selectedMenuItem = '';
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _dateFocusNode = FocusNode();
  Map<String, int> selectedRadioMap =
      {}; // Track selected radio buttons for each group
  Map<String, dynamic> postReq = {};
  String selectedAttachment = '';
  var value_ajax = <String>{};
  late AllJobsTypeList filedResponse;
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final GlobalKey<FormFieldState<String>> _emailFieldKey =
  //     GlobalKey<FormFieldState<String>>();
  TextEditingController _emailController = TextEditingController();
  bool ajaxCall = true;
  static final RegExp emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
  );
  static final RegExp phoneRegex = RegExp(r'^\d{3}-\d{3}-\d{4}$');

  var validText = '';
  FocusNode emailFieldFocus = FocusNode();
  final FocusNode _focusNode = FocusNode();
  String todayDate = '';
  String _todayDate = '';
  Map<String, dynamic> ajaxResponse = {};
  var field_value;
  List<String> allowedvalues = [];
  late List<bool> _isChecked;
  @override
  void initState() {
    todayDate = formattedDate();
    _emailController.addListener(_validateEmail);
    _isChecked = List<bool>.filled(allowedvalues.length, false);
    _dateFocusNode.addListener(() {
      if (_dateFocusNode.hasFocus) {
        _selectDate(context, '');
      }
    });
    // TODO: implement initState
    getUserDetails();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (dividedFields.isEmpty) {
      return Container(
        child: AppLoader.showLoader(),
      ); // Show a loading indicator while data is being fetched.
    }

    return Scaffold(
      //key: _formKey,
      appBar: AppBar(
        title: Text(
          widget.type,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
      body: Container(
        color: Colors.grey,
        height: MediaQuery.of(context).size.height,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              child: Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: dividedFields.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30.0,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.blue[800],
                                child: Center(
                                  child: Text(
                                    groupNames[index],
                                    style: KTextStyle.menuTextStyle,
                                  ),
                                ),
                              ),
                              ...dividedFields[index].map((widget) {
                                // Wrap each widget with a Container and add margin
                                return Container(
                                  margin: const EdgeInsets.all(10),
                                  child: widget,
                                );
                              }).toList(),
                            ],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (validateFields()) {
                            postJob(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                '$validText',
                                style: KTextStyle.redText,
                              )),
                            );
                          }
                          print(postReq);
                        },
                        child: Text('Submit'))
                  ],
                ),
              ),
            )),
      ),
    );
  }

  bool validateFields() {
    bool isValid = true;

    for (var field in actionFields) {
      var name = postReq[field.name];

      if (field.mandatory == 'true') {
        if (name == null || name.isEmpty) {
          // Field is mandatory and empty
          isValid = false;
          validText = 'Please Fill Mandatory Fields';

          break; // Stop checking further fields
        }
      } else if (name != null && name.isNotEmpty) {
        // Change '||' to '&&' here
        if (field.type == 'Email') {
          bool _isValid = emailRegex.hasMatch(name);
          isValid = isValid && _isValid;
          if (!isValid) {
            validText = "Please fill Valid ${field.name}";
          }
        } else if (field.type == 'Phone Number') {
          bool _isValid = phoneRegex.hasMatch(name);
          isValid = isValid && _isValid;
          if (!isValid) {
            validText = "Please fill Valid ${field.name}";
          }
        }
      }
    }

    return isValid;
  }

  getUserDetails() async {
    var user = await readTheData('userName');
    var id = await readTheData('userId');
    var mallid = await readTheData('mallId');
    var user_mail = await readTheData('userMail');
    accessToken = await readTheData('accessToken');

    setState(() {
      name = user;
      userId = id;
      mallId = mallid;
      userMail = user_mail;
    });
    getActionFields();
  }

  void getActionFields() async {
    var url ='';
       // '${ApiConstants.getMasters}type=allJobTypes|${widget.type}&mallId=$mallId';
    Map<String, dynamic> actionsRes = await ServerCall.getRequest(
      url,
      token: accessToken,
    );
    setState(() {
      filedResponse = AllJobsTypeList.fromJson(actionsRes);
    });
    actionFields = [];
    if (filedResponse.jobs != null && filedResponse.jobs!.isNotEmpty) {
      actionFields = filedResponse.jobs!.first.fields ?? [];
      actionFields.sort(((a, b) => ((a.order!)).compareTo(((b.order!)))));

      //setState(() async {
      dt = filedResponse.jobs!.first.dt!;
      // });
      print('action Length:${actionFields.length}');
    } else {
      actionFields = []; // Default value if no jobs or fields are available
    }
    view();
  }

  Future<void> view() async {
    dividedFields = [];
    groupNames = [];
    for (var field in actionFields) {
      if (widget.fieldsValue!.data.isNotEmpty) {
        field_value = widget.fieldsValue!.data[field.name];
      }
      if (field.groupName!.isEmpty) {
        setState(() {
          field.groupName = 'Other Details';
        });
      }

      List<String> checkboxValues = [];
      var allowed = field.allowedValues;
      allowedvalues = allowed!.split('|');
      _isChecked = List<bool>.filled(allowedvalues.length, false);

      var groupName = field.groupName;
      var mandatory = field.mandatory;
      List<String> dropdownKey = [];
      List<String> dropdownValue = [];
      print(widget.id);
      //print('1114444;${field.mandatory}');
      if (field.type != 'Report' &&
          field.type != 'SubJob' &&
          field.groupName != 'MARINE CLAIM DETAILS' &&
          field.groupName != 'MOTOR CLAIM DETAILS' &&
          field.groupName != 'ENGINEERING CLAIM DETAILS' &&
          field.groupName != 'Actions' &&
          field.groupName != 'PROPERTY CLAIM DETAILS') {
        postReq['${field.name}'] = field_value;

        if (field.allowedValuesResults != null) {
          Map<String, dynamic> itemcode = field.allowedValuesResults;
          for (var entry in itemcode.entries) {
            String key = entry.key.split('(').first;
            dropdownKey.add(key);

            // dynamic dropValue = entry.value;
            // dropValue = field_value.toString().split('~').last;
            dropdownValue.add(entry.value);
            postReq['${field.name}'] = entry.value;
            if ((field.rule != '') && (field_value.toString().isNotEmpty)) {
              if (key.contains(field_value)) {
                var rule1 = field.rule!.split('|').last;
                var _json = {field.name: entry.key};
                var jsonValue = jsonEncode(_json);
                if (ajaxCall) {
                  var url = ApiConstants.ajaxCall(
                      mallId, userId, field.rule, jsonValue, entry.value);

                  Future<Map<String, dynamic>> response = _ajaxcallRes(url);
                  Map<String, dynamic> responseData = await response;
                  var ajaxRes = responseData['values'];
                  for (var pair in rule1.split(',')) {
                    var parts = pair.split('~');
                    if (parts.length == 2) {
                      var key2 = parts[0];
                      var value2 = parts[1];
                      setState(() {
                        value_ajax.add(value2);
                        ajaxResponse[value2] = ajaxRes[value2];
                        postReq['$value2'] = ajaxRes[value2];
                      });
                    }
                  }
                }
                int index = dropdownKey.indexOf(key);
                var fieldValue = dropdownValue[index];
              }
            }
          }
        }
        if (value_ajax.isNotEmpty) {
          for (var item in value_ajax) {
            if (item == field.name) {
              /// setState(() {
              field_value = ajaxResponse[item];
//});
            }
          }
        }
        if ((field.type == 'ReadOnly Auto Date') ||
            ((field.type == 'Auto Date'))) {
          field_value = _todayDate;
          postReq['${field.name}'] = _todayDate;
        }
        if ((field.type == 'Email') && (field_value != null)) {
          _emailController.text = field_value;
        } else if ((field.type == 'Email') && (field_value == null)) {
          _emailController.text = '';
        }
        if ((field.type == 'Auto Date') && (field_value != null)) {
          _dateController.text = field_value;
        } else if ((field.type == 'Auto Date') && (field_value == null)) {
          _dateController.text = '';
        }
        if (field.type == 'Radio Button') {
          Widget radioButtonsWidget = RadioButtonsWidget(
            groupName: '${field.groupName}',
            allowedvalues: allowedvalues,
            selectedRadioMap: selectedRadioMap,
            fieldName: '${field.name}',
            onChanged: (int value) {
              setState(() {
                selectedRadioMap['${field.groupName}'] =
                    value; // Update selectedRadioMap
                postReq['${field.name}'] = allowedvalues[value];
                print('${field.name}:${allowedvalues[value]}');
                print(selectedRadioMap[groupName]);
              });
            },
          );

          dividedFields[groupNames.indexOf('${field.groupName}')]
              .add(radioButtonsWidget);
        }

        if (!groupNames.contains(groupName)) {
          groupNames.add(groupName ??
              ''); // Provide a default empty string if groupName is null
          dividedFields.add([]);
        }
        if (field.type != 'Radio Button') {
          dividedFields[groupNames.indexOf(groupName ?? '')].add(Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side text with a maximum width of 140 pixels
              Container(
                width: 140,
                child: Row(
                  children: [
                    Container(
                      width: 130,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${field.name}",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            if (field.mandatory! == 'true')
                              TextSpan(
                                text: ' *',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),
              if (field.type == 'Selection')
                Expanded(
                  // Adjust the flex value as needed
                  //flex: 1,
                  child: DropdownMenu<String>(
                    width: 200,
                    // No fixed width specified
                    initialSelection: 'Select value',
                    controller: TextEditingController(text: field_value),
                    onSelected: (String? value) async {
                      // This is called when the user selects an item.

                      int selectedIndex = dropdownKey.indexOf(value!);
                      selectedMenuItem = value!;
                      setState(() {
                        field_value = dropdownKey[selectedIndex];
                        postReq['${field.name}'] = dropdownValue[selectedIndex];
                      });
                      if (field.rule!.isNotEmpty) {
                        var _json = {field.name: dropdownKey[selectedIndex]};
                        var jsonValue = jsonEncode(_json);
                        var url = ApiConstants.ajaxCall(
                            mallId,
                            userId,
                            field.rule,
                            jsonValue,
                            dropdownValue[selectedIndex]);
                        Future<Map<String, dynamic>> response =
                            _ajaxcallRes(url);
                        Map<String, dynamic> responseData = await response;
                        var ajaxRes = responseData['values'];
                        var rule1 = field.rule!.split('|').last;
                        for (var pair in rule1.split(',')) {
                          var parts = pair.split('~');
                          if (parts.length == 2) {
                            var key2 = parts[0];
                            var value2 = parts[1];
                            setState(() {
                              value_ajax.add(value2);
                              ajaxResponse[value2] = ajaxRes[value2];
                              for (var field in actionFields) {
                                if (ajaxRes.containsKey(field.name)) {
                                  setState(() {
                                    widget.fieldsValue!.data['${field.name}'] =
                                        ajaxRes[field.name];
                                    postReq['${field.name}'] =
                                        ajaxRes[field.name];
                                    // Fields[field.name]  = ajaxRes[field.name];
                                    ajaxCall = false;
                                  });
                                }
                              }
                            });
                          }
                        }
                      }
                      view();
                      print('${field.name}: ${dropdownValue[selectedIndex]}');
                      postReq['${field.name}'] = dropdownValue[selectedIndex];
                    },
                    dropdownMenuEntries: dropdownKey
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(
                        value: value,
                        label: value,
                      );
                    }).toList(),
                  ),
                )
              else if (field.type == 'Date')
                Expanded(
                  flex: 2, // Adjust the flex value as needed
                  child: TextFormField(
                    readOnly: true,

                    onTap: () {
                      _selectDate(context, '${field.name}');
                      // print('${field.name}:${date.toString()}');
                      //postReq['${field.name}'] = date;

                      // Make sure this function is called
                    },
                    decoration: InputDecoration(
                      hintText: 'Select a date',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isFieldMandatoryEmpty('${field.name}')
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: _dateController, // Remove the parentheses here
                  ),
                )
              else if (field.type == 'Email')
                Expanded(
                  flex: 2,
                  child: Builder(
                    builder: (BuildContext context) {
                      return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        //  key: _emailFieldKey,
                        decoration: InputDecoration(
                          hintText: '', // Placeholder text
                          border: OutlineInputBorder(),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, // Set the border color to red
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, // Set the border color to red
                            ),
                          ),
                        ),
                        onChanged: (text) {
                          onChangedField('${field.name}', text);
                        },
                      );
                    },
                  ),
                )
              else if (field.type == 'Phone Number')
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '', // Placeholder text
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      if (text.length == 10) {
                        _focusNode.unfocus();
                        postReq['${field.name}'] = text;
                      }
                      postReq['${field.name}'] = text;
                    },
                    focusNode: _focusNode,
                  ),
                )
              else if (field.type == 'Numeric Text')
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: TextEditingController(text: field_value),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '', // Placeholder text
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      // Print the text whenever it changes
                      print('${field.name}:${text}');
                      postReq['${field.name}'] = text;
                    },
                  ),
                )
              else if (field.type == 'ReadOnly Auto Date')
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    readOnly: true,
                    controller: TextEditingController(
                        text: field_value), // Set the fixed value
                    decoration: const InputDecoration(
                      hintText: '', // Placeholder text
                      border: OutlineInputBorder(),
                    ),
                  ),
                )
              else if (field.type == 'Auto Date')
                Expanded(
                  flex: 2, // Adjust the flex value as needed
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      _selectDate(context, '${field.name}');
                      // print('${field.name}:${date.toString()}');
                      //postReq['${field.name}'] = date;

                      // Make sure this function is called
                    },
                    decoration: InputDecoration(
                      hintText: todayDate,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isFieldMandatoryEmpty('${field.name}')
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    controller: _dateController, // Remove the parentheses here
                  ),
                )
              else if ((field.type == 'Small Text') ||
                  (field.type == 'TextArea'))
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        controller: TextEditingController(text: field_value),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: '', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          // Print the text whenever it changes
                          print('${field.name}:${text}');
                          postReq['${field.name}'] = text;
                        }))
              else if (field.type == 'Attachment')
                AttachmentWidget(
                  selectedAttachment: selectedAttachment,
                  onAttachmentSelected: (String newAttachment) {
                    setState(() {
                      selectedAttachment = newAttachment;
                      postReq['${field.name}'] = selectedAttachment;
                    });
                  },
                )
              else if (field.type == 'CheckBox')
                Container(
                    width: 150,
                    child: CheckboxListView(
                      allowedValues: allowedvalues,
                      initialCheckedValues: _isChecked,
                      onChanged: (newCheckedValues) {
                        setState(() {
                          _isChecked = List.from(newCheckedValues);
                          List<String> selectedValues = [];
                          for (int i = 0; i < allowedvalues.length; i++) {
                            if (_isChecked[i]) {
                              selectedValues.add(allowedvalues[i]);
                            }
                          }

                          // Combine selected values into a single string with '|' delimiter
                          String combinedValues = selectedValues.join('|');

                          // Update postReq with the combined values
                          postReq['${field.name}'] = combinedValues;
                        });
                      },
                    ))
              else if (field.type == 'ReadOnly Small Text')
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(text: field_value),
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          hintText: '', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          // Print the text whenever it changes
                          print('${field.name}:${text}');
                          postReq['${field.name}'] = text;
                        }))
              else
                Expanded(
                    flex: 2,
                    child: TextFormField(
                        //readOnly: true,
                        keyboardType: TextInputType.text,
                        controller: TextEditingController(text: field_value),
                        decoration: const InputDecoration(
                          hintText: '', // Placeholder text
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          // Print the text whenever it changes
                          print('${field.name}:${text}');
                          postReq['${field.name}'] = text;
                        }))
            ],
          ));
        }
      }
    }
  }

  bool isFieldMandatoryEmpty(String fieldName) {
    final field =
        actionFields.firstWhere((element) => element.name == fieldName);
    return field != null &&
        field.mandatory! == 'true' &&
        (postReq[fieldName] == null || postReq[fieldName].isEmpty);
  }

  void onChangedField(String fieldName, String text) {
    // Update the postReq for the field
    postReq[fieldName] = text;

    // Validate fields based on their types
    for (var field in actionFields) {
      if (field.name == fieldName) {
        if (field.type == 'Email') {
          validateEmailField(fieldName, text);
        } else if (field.type == 'Numeric Text') {
          validateNumericTextField(fieldName, text);
        } else if (field.type == 'Date') {
          validateDateField(fieldName, text);
        }
        break; // No need to continue checking other fields
      }
    }
  }

  Future<Map<String, dynamic>> _ajaxcallRes(String url) async {
    Map<String, dynamic> resss = await ServerCall.getRequest(url);
    return resss;
  }

  void _validateEmail() {
    String text = _emailController.text;
    bool isValid = emailRegex.hasMatch(text);
    if (!isValid) {
      setState(() {
        // Invalid email format, set the error border color to red
        //   _emailFieldKey.currentState!.didChange(text);
      });
    } else {
      setState(() {
        // Valid email format, clear the error border color
        //_emailFieldKey.currentState!.didChange(text);
      });
    }
  }

  void validateEmailField(String fieldName, String text) {
    bool isValid = emailRegex.hasMatch(text);
    setState(() {
      if (isValid) {
        // Email is valid, you can set a state variable if needed
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   // SnackBar(
        //   //   content: Text(
        //   //     'Invalid email format for field $fieldName',
        //   //     style: KTextStyle.redText,
        //   //   ),
        //   // ),
        // );
        // Set focus to the email field
        // Set focus to the email field
        emailFieldFocus.requestFocus();

        // Update the email field decoration to show a red border
        // _emailFieldKey.currentState!.reset();
        //  _emailFieldKey.currentState!.didChange(text);
      }
    });
  }

  void validateNumericTextField(String fieldName, String text) {
    // You can implement numeric field validation here if needed
    // For example, check if it's a valid number, within a range, etc.
    // You can set a state variable or show a message accordingly.
  }

  void validateDateField(String fieldName, String text) {
    // You can implement date field validation here if needed
    // For example, check if it's a valid date format, within a range, etc.
    // You can set a state variable or show a message accordingly.
  }
  Widget attachment(String? fieldName) {
    return Expanded(
      flex: 2,
      child: TextFormField(
        readOnly: true,
        controller: TextEditingController(
          text: selectedAttachment,
        ),
        onTap: () {
          if (selectedAttachment.isEmpty) selectAttachment(fieldName);
        },
        decoration: InputDecoration(
          hintText: 'Browse',
          border: OutlineInputBorder(),
          suffixIcon: selectedAttachment.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    clearAttachment();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                )
              : Icon(Icons.attach_file),
        ),
      ),
    );
  }

  void selectAttachment(String? fieldName) async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedAttachment = result.files.single.name;
        postReq['$fieldName'] = selectedAttachment;
        print(selectedAttachment);
      });
    }
  }

// Method to clear the selected attachment
  void clearAttachment() {
    setState(() {
      selectedAttachment = '';
    });
  }

  postJob(BuildContext context) async {
    var mallid = await readTheData('mallId');
    var userMail = await readTheData('userMail');
    var accessToken = await readTheData('accessToken');

    postReq['Initiators_email'] = userMail;

    // if (type == 'Policies') {
    //   dt = 'CAMPAIGNS';
    // } else {
    //   dt = 'CAMPAIGNS';
    // }
    //postReq['Initiators_email']
    var jsonData = {
      'list': [postReq]
    };
    var jsonEncoded = jsonEncode(jsonData);
    var requestBody = {
      'userId': '$mallid',
      'consumerEmail': '$userMail',
      'type': '${widget.type}',
      'json': '$jsonEncoded', // Replace with your actual JSON data
      'dt': '$dt',
      'category': 'Services',
      'parentJobId': '${widget.id}',
    };
    print(jsonEncoded);
    print(requestBody);
    // try {
    // var url = await ApiConstants.postedJobApi(
    //     jsonEncoded, "$type", mallId, userMail, jobId);
    // showToast(url);

    Map<String, dynamic> jsonData1 = await ServerCall.postRequest(
        ApiConstants.jobCreate,
        token: accessToken,
        body: requestBody);
    var json = jsonData1['myHashMap'];
    var msg = json['message'];
    if (msg == 'Jobs saved') {
      widget.onScreenPopped();
      Navigator.pop(context, 'Job saved');
      //  Navigator.of(context).pop();

      showToast(msg);
      //   if (type1 == "Interested Policies") {
      //     Map<String, dynamic> jsonData2 = await ServerCall.getRequest(
      //         '${ApiConstants.jobDelete}$jobId1',
      //         token: accessToken);
      //     print('jobbbbb:$jobId1');

      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const DashBoardPage()));
      //   }
      // }
      // Extract the key-value message from the response
      // var message = responseBody['message'];
      // } catch (e) {
      //   print('Error occurred during POST request: $e');
      //   showToast("$e");
    }

    print(jsonEncoded);
  }

  String formattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('dd/MM/yyyy');
    final _formatter = DateFormat('MM/dd/yyyy');
    _todayDate = formatter.format(now);
    return formatter.format(now);
  }

  Future<String> _selectDate(BuildContext context, String field) async {
    String date = '';
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate!);
        String date = DateFormat('MM/dd/yyyy').format(selectedDate!);
        print('${field}:$date');
        postReq[field] = date;
      });
    }
    return _dateController.text;
  }
}

class AttachmentWidget extends StatefulWidget {
  final String selectedAttachment;
  final Function(String) onAttachmentSelected;

  AttachmentWidget({
    required this.selectedAttachment,
    required this.onAttachmentSelected,
  });

  @override
  _AttachmentWidgetState createState() => _AttachmentWidgetState();
}

class _AttachmentWidgetState extends State<AttachmentWidget> {
  late FilePickerResult selectedAttachmentResult;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    // Initialize selectedAttachmentResult to an empty FilePickerResult.
    selectedAttachmentResult = FilePickerResult([]);
    textEditingController =
        TextEditingController(text: widget.selectedAttachment);
  }

  void selectAttachment() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedAttachmentResult = result;
        widget.onAttachmentSelected(selectedAttachmentResult.files.single.name);
        textEditingController.text = selectedAttachmentResult.files.single.name;
      });
    }
  }

  void clearAttachment() {
    setState(() {
      selectedAttachmentResult = FilePickerResult([]);
      widget.onAttachmentSelected('');
      textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TextFormField(
        readOnly: true,
        controller: textEditingController,
        onTap: () {
          if (selectedAttachmentResult == null ||
              selectedAttachmentResult.files.isEmpty) {
            selectAttachment();
          }
        },
        decoration: InputDecoration(
          hintText: 'Browse',
          border: OutlineInputBorder(),
          suffixIcon: selectedAttachmentResult != null &&
                  selectedAttachmentResult.files.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    clearAttachment();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                )
              : Icon(Icons.attach_file),
        ),
      ),
    );
  }
}

class CheckboxListView extends StatefulWidget {
  final List<String> allowedValues;
  final List<bool> initialCheckedValues;
  final ValueChanged<List<bool>> onChanged;

  CheckboxListView({
    required this.allowedValues,
    required this.initialCheckedValues,
    required this.onChanged,
  });

  @override
  _CheckboxListViewState createState() => _CheckboxListViewState();
}

class _CheckboxListViewState extends State<CheckboxListView> {
  late List<bool> isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = List.from(widget.initialCheckedValues);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.allowedValues.length,
      itemBuilder: (context, index) {
        return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          value: isChecked[index],
          onChanged: (val) {
            setState(() {
              isChecked[index] = val!;
              widget.onChanged(isChecked); // Notify the parent widget
            });
          },
          title: Text(widget.allowedValues[index]),
        );
      },
    );
  }
}

class RadioButtonsWidget extends StatefulWidget {
  final String groupName;
  final List<String> allowedvalues;
  final Map<String, int> selectedRadioMap;
  final ValueChanged<int> onChanged;
  final String fieldName;

  RadioButtonsWidget(
      {required this.groupName,
      required this.allowedvalues,
      required this.selectedRadioMap,
      required this.onChanged,
      required this.fieldName});

  @override
  _RadioButtonsWidgetState createState() => _RadioButtonsWidgetState();
}

class _RadioButtonsWidgetState extends State<RadioButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left side text with a maximum width of 140 pixels
        Container(
          width: 140,
          child: Text(
            widget.fieldName, // Replace with the dynamic content you need
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.allowedvalues.map<Widget>((value) {
              final int index = widget.allowedvalues.indexOf(value);
              return RadioListTile<int>(
                title: Text(value),
                value: index,
                groupValue: widget.selectedRadioMap[widget.groupName] ?? -1,
                onChanged: (int? value) {
                  setState(() {
                    widget.selectedRadioMap[widget.groupName] = value!;
                    widget.onChanged(
                        value!); // Notify the parent about the change
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
