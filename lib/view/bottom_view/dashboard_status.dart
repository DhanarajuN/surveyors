import 'package:Surveyors/data_model/status_model.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';

import '../../data/local_store_helper.dart';
import '../../res/components/loader.dart';
import '../../res/constants/api_constants.dart';
import '../../res/constants/custom_textstyle.dart';
import '../../res/constants/routes_constants.dart';
import '../../res/constants/server_calls.dart';

class DashboardStatus extends StatefulWidget {
  final String? type;
  const DashboardStatus({super.key, this.type});

  @override
  State<DashboardStatus> createState() => _DashboardStatusState();
}

class _DashboardStatusState extends State<DashboardStatus> {
  String accessToken = '';
  bool isLoading = true;
  bool _isSwitched = false;
  int totalCount = 0;
  double totalTotal = 0.0;
  List<Map<String, dynamic>> primaryList = [];
  List<Map<String, dynamic>> secondaryList = [];
  String? type = '';
  bool estimateOfLoss = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? AppLoader.showLoader()
          : primaryList.isEmpty
              ? Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: _isSwitched
                                  ? KColors.secondaryStatusColor
                                  : KColors.primaryColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              _isSwitched
                                  ? 'Secondary Status'
                                  : 'Primary Status',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSwitched = !_isSwitched;
                              });
                            },
                            child: Container(
                              width: 60.0,
                              height: 30.0,
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: _isSwitched
                                    ? KColors.secondaryColor
                                    : KColors.primaryColor,
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: _isSwitched ? 26.0 : 0.0,
                                    child: Container(
                                      width: 25.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: _isSwitched
                                      ? secondaryList.length
                                      : primaryList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: statusCard(index),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget statusCard(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 3.0,
              spreadRadius: 1.0,
              offset: const Offset(1.0, 1.0),
            ),
          ],
        ),
        child: Card(
          color: Colors.white, // Set the card color to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          shadowColor: Colors.white,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: _isSwitched
                              ? KColors.secondaryStatusColor
                              : KColors.primaryColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          _isSwitched
                              ? secondaryList[index]['Name']
                              : primaryList[index]['Name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(
                            '${RoutesList.childScreen}?status=${_isSwitched ? 'primaryStatus' : 'secondaryStatus'}&value=${_isSwitched ? secondaryList[index]['Name'] : primaryList[index]['Name']}&type=${type}');
                      },
                      child: Text(
                        'View All',
                        style: KTextStyle.bold18BFontStyle,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _isSwitched
                          ? secondaryList[index]['Count'].toString()
                          : primaryList[index]['Count'].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  estimateOfLoss ? 'Estimate of Loss' : "",
                  style: TextStyle(fontSize: 18, color: KColors.greyColor),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _isSwitched
                      ? estimateOfLoss
                          ? secondaryList[index]['Total'].toString()
                          : ""
                      : estimateOfLoss
                          ? primaryList[index]['Total'].toString()
                          : "",
                  style: TextStyle(fontSize: 18, color: KColors.black),
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    getLocalStorage();
    super.initState();
  }

  getLocalStorage() async {
    accessToken = await readTheData('accessToken');
    // surveyorId = await readTheData('surveyorId');
    // Map<String, dynamic>? dd = await readJsonData('surveyorData');

    setState(() {
      accessToken = accessToken;
      type = widget.type ?? 'Claim Register';
    });
    getStatus();
  }

  Future<void> getStatus() async {
    isLoading = true;
    AppLoader.showLoader();
    String status_url = ApiConstants.statusApi('${type}');
    // fields = await ServerCall.getRequest(fields_url, token: accessToken);
    // String instances_url = ApiConstants.getMastersAPi('Claim Register','1','10');
    Map<String, dynamic> instanceRes = await ServerCall.getRequest(status_url,
        token: accessToken, context: context);

    Status status = Status.fromJson(instanceRes);

    if (status.jobStatus != null) {
      primaryList = [];
      secondaryList = [];
      for (JobStatus status1 in status.jobStatus!) {
        print('primary:${status1.name}');
        print('secondary:${status1.groupName}');
        print('count:${status1.count}');
        setState(() {
          totalCount += status1.count!;
          print(status1.count);
          //  if(status1.count!=0){
          String? total = '';

          if (status1.fieldAverage!.estimateOfLoss != null) {
            totalTotal +=
                double.parse('${status1.fieldAverage!.estimateOfLoss!.total}');
            total = status1.fieldAverage!.estimateOfLoss!.total;
            estimateOfLoss = true;
          } else {
            totalTotal += 0;
            total = '0';
          }

          primaryList.add({
            'Name': status1.name ?? "",
            'Count': status1.count,
            'Total': total
          });

          secondaryList.add({
            'Name': status1.groupName ?? "",
            'Count': status1.count,
            'Total': total
          });

          //}
        });
      }
      setState(() {
        primaryList.insert(
          0,
          {
            'Name': 'Total',
            'Count': totalCount.toString(),
            'Total': totalTotal,
          },
        );

        secondaryList.insert(
          0,
          {
            'Name': 'Total',
            'Count': totalCount.toString(),
            'Total': totalTotal,
          },
        );
        Map<String, Map<String, dynamic>> uniqueNamesMap = {};

        for (var item in secondaryList) {
          String name = item['Name'];
          int count = int.parse(item['Count'].toString());
          double total = double.parse(item['Total'].toString());

          if (uniqueNamesMap.containsKey(name)) {
            uniqueNamesMap[name]!['Count'] += count;
            uniqueNamesMap[name]!['Total'] += total;
          } else {
            // If the name doesn't exist, add it to uniqueNamesMap
            uniqueNamesMap[name] = {'Count': count, 'Total': total};
          }
        }

        secondaryList.clear();

        uniqueNamesMap.forEach((name, data) {
          secondaryList.add({
            'Name': name,
            'Count': data['Count'],
            'Total': data['Total'].toString()
          });
        });
      });

      print("saagsgg:::${primaryList}");
      print("lllll::::${secondaryList}");
    }
    AppLoader.hideLoader();
    isLoading = false;
  }
}
