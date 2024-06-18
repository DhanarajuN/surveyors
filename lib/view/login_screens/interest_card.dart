import 'dart:convert';

import 'package:Surveyors/model/varaints_model.dart';
import 'package:Surveyors/res/constants/server_calls.dart';
import 'package:flutter/material.dart';
import 'package:Surveyors/data/local_store_helper.dart';

import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';
import 'package:http/http.dart' as http;

class InterestCardWidget extends StatefulWidget {
  const InterestCardWidget({super.key});
  @override
  State<InterestCardWidget> createState() => _ClaimsCardWidgetState();
}

class _ClaimsCardWidgetState extends State<InterestCardWidget> {
  int userId = 0;
  int mallId = 0;
  String userMail = '';
  var responses = <http.Response>[];
  List<VariantJob> interestedPolicies = [];
  var no_claims_text = '';
  Map<String, dynamic> interest = {};
  var accessToken = '';

  @override
  void initState() {
    getProfileImage();
    Future.delayed(const Duration(seconds: 1), () async {
      getClaimsDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(interestedPolicies.isEmpty);
    return RefreshIndicator(
      onRefresh:
          getClaimsDetails, // Wrap the function call with a lambda function
      child: interestedPolicies.isEmpty
          ? Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$no_claims_text',
                      style: KTextStyle.bold18BFontStyle,
                    ),
                  ],
                ),
              ),
            )
          : Scaffold(
              body: ListView.builder(
                itemCount: interestedPolicies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: insuranceBody(interestedPolicies[index]),
                  );
                },
              ),
            ),
    );
  }

  getProfileImage() async {
    var id = await readTheData('userId');
    var mallid = await readTheData('mallId');
    var userMail = await readTheData('userMail');
    accessToken = await readTheData('accessToken');
    print(id);
    print(mallid);
    setState(() {
      userId = id;
      mallId = mallid;
      userMail = userMail;
    });
  }

  Widget insuranceBody(VariantJob job) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Card(
        shadowColor: Colors.grey,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.policyType?.isEmpty ?? true
                            ? 'N/A'
                            : job.policyType!.split('(').first,
                        style: KTextStyle.bold14BFontStyle,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      // Text(
                      //   job.name?.isEmpty ?? true
                      //       ? 'N/A'
                      //       : job.name!.split('(').first,
                      //   style: KTextStyle.bold14GFontStyle,
                      // )
                    ],
                  ),
                  // SizedBox(
                  //   width: 40,
                  //   height: 40,
                  //   child: IconButton(
                  //     icon: Image.asset(ImageConstants.viewMoreLogo1),
                  //     //iconSize: 20,
                  //     onPressed: () {
                  //       print('View More Button Clicked');
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ClaimsSubJob(
                  //                     claims: claims,
                  //                   )));
                  //     },
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SUM INSURED',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          Text(
                            '\u{20B9}${job.sumInsured}',
                            style: KTextStyle.regularDescFontStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STATUS',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          Text(
                            "${job.currentJobStatus}",
                            style: KTextStyle.regularDescFontStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PREMIUM',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          Text(
                            '\u{20B9}${job.totalPremium}',
                            style: KTextStyle.regularDescFontStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'DATE OF INTIMATION',
                            style: KTextStyle.regularTitleGreyFontStyle,
                          ),
                          
                          Text(
                            '${job.createdOn!.split('(').first}',
                            style: KTextStyle.regularDescFontStyle,
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getClaimsDetails() async {
    AppLoader.showLoader();
    // var intrestedPoliciesList =
    // //     '${ApiConstants.getMasters}type=Interested Policies&mallId=$mallId&userId=$userId';
    // print(intrestedPoliciesList);
    // interest = await ServerCall.getRequest(
    //   intrestedPoliciesList,
    //   token: accessToken,
   // );
    AppLoader.hideLoader();

    getUserClaimsData();
  }

  void getUserClaimsData() {
    VariantModel interestResponse = VariantModel.fromJson(interest);
    print(interestResponse.jobs!.length);
    if (interestResponse.jobs!.isNotEmpty) {
      print('1');
      setState(() {
        interestedPolicies = interestResponse.jobs!;
        
      });

      print(interestedPolicies.length);
    } else {
      no_claims_text = 'No Interest Policies Avilable';
      print('2');
      //_showAlertMessage('Alert', 'No Data Found.');
    }
  }
}
