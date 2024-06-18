import 'dart:convert';

import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/model/user_polices1_model.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data_model/job_model.dart';
import '../../res/constants/routes_constants.dart';
import '../../res/constants/server_calls.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({Key? key}) : super(key: key);

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

var accessToken = '';
Map<String, dynamic> user = {};
Map<String, dynamic> fields = {};
bool isLoading = true;
 Map<String, dynamic> surveydata={};
class _InterestsScreenState extends State<InterestsScreen> {
  // List<String> insuranceTypes = [
  //   'Marine',
  //   'Health',
  //   'Life',
  //   'Auto',
  //   'Home',
  //   'Travel',
  //   'Business',
  //   'Pet',
  //   'Accident',
  //   'Property',
  //   'Liability',
  //   'Crop',
  //   'Disability',
  //   'Flood',
  //   'Renters',
  //   'Earthquake',
  //   'Cyber',
  // ];
  List<String> selectedInsuranceTypes = [];
  List<String> insuranceTypes = [
    'Crop',
    'Engineering',
    'Fire',
    'LOP',
    'Marine Cargo',
    'Marinehull',
    'MISC',
    'Motor'
  ];
  Map<String, String> insuranceTypes1 = {};

  List<bool> isSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: isLoading
          ? Center(child: AppLoader.showLoader())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.black, size: 25),
                        onPressed: () {
                          // Navigator.of(context).pop();
                          GoRouter.of(context).go(RoutesList.dashBoard);
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Let's select your Category type.",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Please select one or more to proceed.',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 3,
                            ),
                            itemCount: insuranceTypes.length,
                            itemBuilder: (BuildContext context, int index) {
                              final String type = insuranceTypes[index];
                              final bool isSelectedd = isSelected[
                                  index]; // Access isSelected by index
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    // isSelected[index] = !isSelected[
                                    //     index]; // Modify isSelected by index
                                    // insuranceTypes1[type] =
                                    //     isSelected[index] ? 'true' : 'false';
                                    //     print('selcted;;;;;;$isSelected');
                                    //     print('insuranceee:::::::$insuranceTypes1');
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isSelectedd
                                        ? Colors.blueAccent
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelectedd
                                          ? Colors.blueAccent
                                          : Colors.grey,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      insuranceTypes[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: isSelectedd
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: isSelected.contains(true)
                          ? () {
                            
                              GoRouter.of(context)
                                  .push(RoutesList.bascicDetails);
                            }
                          : null, // Disable button if no item is selected
                      child: const Text('Continue'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSelected.contains(true)
                            ? Colors
                                .blue // Change color to normal blue if at least one item is selected
                            : Colors.blue[
                                100], // Keep light blue color if no item is selected
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> getSurveyors() async {
    isLoading=true;
    String fields_url = ApiConstants.getMastersFieldsAPi('Claim Handler');
    fields = await ServerCall.getRequest(fields_url, token: accessToken);
    String instances_url = ApiConstants.getMastersAPi('Claim Handler', '1', '1');
    Map<String, dynamic> surveyorDataRes = await ServerCall.getRequest(
      instances_url,
      token: accessToken,
    );
    JobsData response = JobsData.fromJson(surveyorDataRes);
    writeTheData('surveyorId', response.jobs![0].id);
     surveydata = (response.jobs![0].data!).toJson();
     writeJsonData('surveyorData', surveydata);
     print('surveyorData:::::::::::::::$surveydata');
     print('surveyorData:::::::::::::::${readJsonData("surveyorData")}');
    for (var name in insuranceTypes) {
      String isSelected1 = surveydata[name] != "" ? surveydata[name] : "false";
      insuranceTypes1[name] = isSelected1;
      print('name:$name  value:$isSelected1');
    }
    print(insuranceTypes1);
    setState(() {
      isSelected = insuranceTypes.map((type) {
        final value = insuranceTypes1[type];
        return value == 'Yes'
            ? true
            : false; 
      }).toList();

     // writeTheData(key, value);
     
    });
 AppLoader.hideLoader();
                  isLoading = false;

    // print(user);
    //print(surveydata);
    //print(fields);
  }

  @override
  initState() {
    // TODO: implement initState
    getLocalStorage();
    super.initState();
  }

  getLocalStorage() async {
    accessToken = await readTheData('accessToken');
    Map<String, dynamic>? dd = await readJsonData('surveyorData');
    print('dd');
    setState(() {
      accessToken = accessToken;
    });
    getSurveyors();
  }
}
