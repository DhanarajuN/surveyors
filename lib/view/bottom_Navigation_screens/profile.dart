import 'dart:convert';
import 'dart:io';

import 'package:Surveyors/model/login_data_model.dart';
import 'package:Surveyors/model/profile_model.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/common_method.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:flutter/material.dart';
import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String profileImage = '';
  String userName = '';
  int userId = 0;
  int mallId = 0;
  String email_id = '';
  String mobile_no = '';
  String firstName = '';
  String role = '';
  int role_id = 0;
  int active = 0;
  String gender = '';
  String lastName = '';
  var accessToken = '';
  var jsonString = '';
  var responses = <http.Response>[];
  TextEditingController userController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  bool isButtonVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedImage;
  late UserDetails userDetails;
  @override
  void initState() {
    // TODO: implement initState
    getProfileImage();
    checkConditions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _pickImage(ImageSource.gallery);
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: selectedImage != null
                      ? FileImage(selectedImage!) as ImageProvider<
                          Object> // Cast selectedImage to ImageProvider<Object>
                      : NetworkImage(
                          profileImage), // Use the default profile image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(email_id, style: KTextStyle.bold14BFontStyle),
          const SizedBox(
            height: 25.0,
          ),
          ProfileBody(),
          if (isButtonVisible)
            ElevatedButton(
              onPressed: () {
                profileUpdate();
                // Perform save action here
              },
              child: Text(
                'Save',
                style: KTextStyle.menuTextStyle,
              ),
            ),
        ],
      ),
    ));
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
        profileUpdate();
        print(selectedImage); // Update the selected image file
      });
      // Perform any additional actions with the image file
    } else {
      // Handle the case when the image selection was canceled
    }
  }

  getProfileImage() async {
    var image = await readTheData('profileImage');
    var name = await readTheData('userName');
    var id = await readTheData('userId');
    var mallid = await readTheData('mallId');
    accessToken = await readTheData('accessToken');
    print(image);
    print(name);
    print(id);
    print(mallid);
    setState(() {
      profileImage = image;
      userName = name;
      userId = id;
      mallId = mallid;
      getProfileDetails();
    });
  }

  void getProfileDetails() async {
    final myDetailsUrl = '${ApiConstants.get_profileDetails}$userId';

    Map<String, dynamic> map =
        await ServerCall.getRequest(myDetailsUrl, token: accessToken);
    if (map.containsKey('tokenExpired') && map['tokenExpired']) {
      CommonMethod.logout(context);
    } else {
      userDetails = UserDetails.fromJson(map);
      email_id = userDetails.result!.emailId!;
      profileImage = userDetails.result!.logo!;
      print('pi   $profileImage');
      userName = userDetails.result!.fullname!;
      mobile_no = userDetails.result!.mobile!;
      firstName = userDetails.result!.firstName!;
      lastName = userDetails.result!.lastName!;
      // userId = userDetails.result!.id!;
      // gender=userDetails.result!.gender!
      userController.text = userName ?? '';
      mobileController.text = mobile_no ?? '';
      firstNameController.text = firstName ?? '';
      lastNameController.text = lastName ?? '';
      writeTheData('userName', userDetails.result!.fullname!);

      writeTheData('profileImage', userDetails.result!.logo!);
    }

    // if (status == '1') {
    //   setState(() {
    //     var result = jsonData['result'];
    //     email_id = result['emailId'] ?? 'N/A';
    //     mobile_no = result['mobile'] ?? 'N/A';
    //     dob = result['dob'] ?? 'N/A';
    //     role = result['role'] ?? 'N/A';
    //     active = result['active'] ?? 'N/A';
    //     gender = result['gender'] ?? 'N/A';
    //     address = result['address'] ?? '';
    //     var accountRole = result['accountRole'];
    //     role_id = accountRole['id'];
    //     print('role_id:$role_id');
    //     userController.text = address ?? '';
    //     mobileController.text = mobile_no ?? '';
    //   });
    // } else {
    //   print('23456');
    // }
  }

  Widget ProfileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Employee Details',
        //   style: KTextStyle.bold18BFontStyle,
        // ),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade500,
                blurRadius: 3.0,
                spreadRadius: 2.0,
                offset: const Offset(2.0, 2.0),
              )
            ],
          ),
          margin: const EdgeInsets.only(top: 16, bottom: 12, left: 3, right: 3),
          child: ProfileInnerBody(),
        ),
      ],
    );
  }

  void checkConditions() {
    print('mobile:${mobileController.text}');
    firstNameController.addListener(() {
      setState(() {
        print(
            'uN$userName uN1${userController.text} fN$firstName fN${firstNameController.text} lN$lastName lN${lastNameController.text} mn$mobile_no mn${mobileController.text}');
        if (firstName != firstNameController.text ||
            lastName != lastNameController.text ||
            mobile_no != mobileController.text) {
          print(isButtonVisible);
          isButtonVisible = true;
        } else {
          isButtonVisible = false;
        }
      });
    });
    lastNameController.addListener(() {
      setState(() {
        print(
            'uN$userName uN1${userController.text} fN$firstName fN${firstNameController.text} lN$lastName lN${lastNameController.text} mn$mobile_no mn${mobileController.text}');
        if (firstName != firstNameController.text ||
            lastName != lastNameController.text ||
            mobile_no != mobileController.text) {
          print(isButtonVisible);
          isButtonVisible = true;
        } else {
          isButtonVisible = false;
        }
      });
    });

    mobileController.addListener(() {
      print('mobile:${mobileController.text}');
      setState(() {
        if (mobileController.text.length >= 10) {
          FocusScope.of(context).unfocus();
        }
        if (userName != userController.text ||
            firstName != firstNameController.text ||
            lastName != lastNameController.text ||
            mobile_no != mobileController.text) {
          isButtonVisible = true;
        } else {
          isButtonVisible = false;
        }
      });
    });
  }

  void profileUpdate() async {
    if (_formKey.currentState!.validate()) {
      // Perform save action here
      isButtonVisible = false;

      final data = {
        "orgId": mallId,
        "emailId": email_id,
        "accountRole": {
          "id": userDetails.result!.accountRole!.id,
          'name': userDetails.result!.accountRole!.name
        },
        "active": userDetails.result!.active,
        "id": userId
      };
      if ((mobileController.text != mobile_no)) {
        data['mobile'] = mobileController.text;
      }
      data['firstname'] = firstNameController.text;
      data['lastname'] = lastNameController.text;
      data['properties'] = userDetails.result!.accountRole!.properties;
      var image = selectedImage;
      print(json.encode(data));
      var url = Uri.parse(ApiConstants.update_profile);
      jsonString = json.encode(data);
      final request = http.MultipartRequest('POST', url);
      request.fields['json'] = jsonString;
      if (selectedImage != null) {
        String fileName = selectedImage!.path.split('/').last;
        request.files.add(
          await http.MultipartFile.fromPath('userImage', selectedImage!.path,
              filename: fileName),
        );
      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      var msg = jsonData['message'];
      getProfileDetails();

      print('response$response');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }

  Widget ProfileInnerBody() {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'UserName:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Text(
                      userName,
                      style: KTextStyle.bold14GFontStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'UserName:',
                //       style: KTextStyle.bold14BFontStyle,
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     // Adjust the spacing between the label and the form field
                //     Expanded(
                //       child: TextFormField(
                //         controller: userController,
                //         style: KTextStyle.regularDescFontStyle,
                //         decoration: const InputDecoration(
                //           border: OutlineInputBorder(),
                //           hintText: 'Enter UserName',
                //           // Other decoration properties...
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mobile No:',
                      style: KTextStyle.bold14BFontStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Adjust the spacing between the label and the form field
                    Expanded(
                      child: TextFormField(
                        controller: mobileController,
                        style: KTextStyle.regularDescFontStyle,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your Mobile Number',
                          // Other decoration properties...
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your mobile number';
                          } else if (value.length != 10) {
                            return 'Please enter a valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FirstName:',
                      style: KTextStyle.bold14BFontStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Adjust the spacing between the label and the form field
                    Expanded(
                      child: TextFormField(
                        controller: firstNameController,
                        style: KTextStyle.regularDescFontStyle,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your FirstName',
                          // Other decoration properties...
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LastName:',
                      style: KTextStyle.bold14BFontStyle,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    // Adjust the spacing between the label and the form field
                    Expanded(
                      child: TextFormField(
                        controller: lastNameController,
                        style: KTextStyle.regularDescFontStyle,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your LastName',
                          // Other decoration properties...
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Emp ID',
                //               style: KTextStyle.bold14BFontStyle,
                //             ),
                //             Text(
                //               '$userId',
                //               style: KTextStyle.regularDescFontStyle,
                //             )
                //           ],
                //         ),
                //         const SizedBox(
                //           height: 8,
                //         ),
                //         const SizedBox(
                //           height: 3,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'DOB',
                //               style: KTextStyle.bold14BFontStyle,
                //             ),
                //             Text(
                //               dob,
                //               style: KTextStyle.regularDescFontStyle,
                //             )
                //           ],
                //         ),
                //       ],
                //     ),
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const SizedBox(
                //           height: 8,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Gender',
                //               style: KTextStyle.bold14BFontStyle,
                //             ),
                //             Text(
                //               gender,
                //               style: KTextStyle.regularDescFontStyle,
                //             )
                //           ],
                //         ),
                //         const SizedBox(
                //           height: 8,
                //         ),
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text(
                //               'Role',
                //               style: KTextStyle.bold14BFontStyle,
                //             ),
                //             Text(
                //               role,
                //               style: KTextStyle.regularDescFontStyle,
                //             )
                //           ],
                //         ),
                //         const SizedBox(
                //           height: 8,
                //         ),
                //       ],
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ));
  }
}
