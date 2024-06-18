import 'dart:math';

import 'package:Surveyors/res/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data/local_store_helper.dart';
import '../../data_model/status_model.dart';
import '../../res/app_colors.dart';
import '../../res/components/loader.dart';
import '../../res/constants/api_constants.dart';
import '../../res/constants/server_calls.dart';
import '../general/indicator.dart';

class ReoprtsScreen extends StatefulWidget {
  final String? type;
  const ReoprtsScreen({super.key, this.type});

  @override
  State<ReoprtsScreen> createState() => _ReoprtsScreenState();
}

class _ReoprtsScreenState extends State<ReoprtsScreen> {
  bool isLoading = true;
  String accessToken = '';
  bool _isSwitched = false;
  int totalCount = 0;
  double totalTotal = 0.0;
  List<Map<String, dynamic>> primaryList = [];
  List<Map<String, dynamic>> secondaryList = [];
  List<bool> _isSelected = [];
  String? type = '';

  List<Color> predefinedColors = [];
  List<Color> pieChartColors = [];

  int touchedIndex = -1;
  @override
  void initState() {
    // TODO: implement initState
    getLocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  return Padding(
      padding: EdgeInsets.all(10), // Add 10 pixels padding around the Column
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black, // Set your desired border color here
                    width: 2, // Set your desired border width here
                  ),
                ),
                child: PieChart(
                  PieChartData(
                    sections: _getPieChartData(),
                    centerSpaceRadius: 60,
                    sectionsSpace: 0,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
                childAspectRatio: 3,
              ),
              itemCount: secondaryList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Checkbox(
                      value: _isSelected[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _isSelected[index] = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        '${secondaryList[index]['Name']} (${secondaryList[index]['Count']})',
                        style: TextStyle(color: pieChartColors[index]),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _getPieChartData() {
    List<PieChartSectionData> sections = [];
    for (int i = 0; i < secondaryList.length; i++) {
      if (_isSelected[i]) {
        final Map<String, dynamic> data = secondaryList[i];
        sections.add(
          PieChartSectionData(
            color: pieChartColors[i],
            value: double.parse(data['Count'].toString()),
            title: '${data['Name']}',
            radius: 75,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    }
    return sections;
  }

  List<Color> generateColors(int length) {
    List<Color> colors = [];
    for (int i = 0; i < length; i++) {
      // Calculate hue angle
      double hue = (360.0 / length) * i;
      // Convert hue to RGB color
      colors.add(HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor());
    }
    return colors;
  }

  Color generateColor(int index) {
    if (index == 0) {
      return Colors.brown; // Use brown color for the first index
    } else {
      // For other indices, generate a random color using RGB values
      Random random = Random();
      return Color.fromRGBO(
        random.nextInt(256), // red
        random.nextInt(256), // green
        random.nextInt(256), // blue
        1, // alpha (opacity)
      );
    }
  }

// Color _generateRandomColor() {
//   Color random = Color();
//   return Color.fromRGBO(
//     random.nextInt(256), // red
//     random.nextInt(256), // green
//     random.nextInt(256), // blue
//     1, // alpha (opacity)
//   );
// }
  void _initSelections() {
    _isSelected = List<bool>.filled(secondaryList.length, true);
  }

  List<Widget> _getToggleButtons() {
    return List.generate(
      secondaryList.length,
      (index) => Row(
        children: [
          Checkbox(
            value: _isSelected[index],
            onChanged: (bool? value) {
              setState(() {
                _isSelected[index] = value!;
              });
            },
          ),
          Text(
              '${secondaryList[index]['Name']} (${secondaryList[index]['Count']})'),
        ],
      ),
    );
  }

  getLocalStorage() async {
    accessToken = await readTheData('accessToken');
    // surveyorId = await readTheData('surveyorId');
    // Map<String, dynamic>? dd = await readJsonData('surveyorData');

    print('dd');
    setState(() {
      accessToken = accessToken;
      type = widget.type ?? 'Claim Register';
    });
    getStatus();
  }

  Future<void> getStatus() async {
    try {
      isLoading = true;
      AppLoader.showLoader();
      String status_url = ApiConstants.statusApi(type!);
      Map<String, dynamic> instanceRes =
          await ServerCall.getRequest(status_url, token: accessToken);

      Status status = Status.fromJson(instanceRes);

      if (status.jobStatus != null) {
        primaryList = [];
        secondaryList = [];
        for (JobStatus status1 in status.jobStatus!) {
          totalCount += status1.count!;
          if (totalCount != 0) {
            // totalTotal +=
            //     double.parse('${status1.fieldAverage!.estimateOfLoss!.total}');
            primaryList.add({
              'Name': status1.name,
              'Count': status1.count,
              //'Total': status1.fieldAverage!.estimateOfLoss!.total
            });

            secondaryList.add({
              'Name': status1.name,
              'Count': status1.count,
             // 'Total': status1.fieldAverage!.estimateOfLoss!.total
            });
          }

          primaryList.insert(
            0,
            {
              'Name': 'Total',
              'Count': totalCount.toString(),
            //  'Total': totalTotal,
            },
          );
        }
        Map<String, Map<String, dynamic>> uniqueNamesMap = {};

        for (var item in secondaryList) {
          String name = item['Name'];
          int count = int.parse(item['Count'].toString());
       //   double total = double.parse(item['Total'].toString());

          if (uniqueNamesMap.containsKey(name)) {
            uniqueNamesMap[name]!['Count'] += count;
        //    uniqueNamesMap[name]!['Total'] += total;
          } else {
            uniqueNamesMap[name] = {'Count': count, };
          }
        }

        secondaryList.clear();

        uniqueNamesMap.forEach((name, data) {
          secondaryList.add({
            'Name': name,
            'Count': data['Count'],
           // 'Total': data['Total'].toString()
          });
        });

        _initSelections();
        pieChartColors = generateColors(secondaryList.length);
      }
    } catch (e) {
      print('Error fetching status: $e');
      // Handle error if needed
    } finally {
      AppLoader.hideLoader();
      setState(() {
        isLoading = false;
      });
    }
  }
}
