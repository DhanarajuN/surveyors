import 'package:Surveyors/data_model/dynamic_job_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local_store_helper.dart';
import '../../model/subjobs_model.dart';
import '../../res/components/loader.dart';
import '../../res/constants/api_constants.dart';
import '../../res/constants/colors.dart';
import '../../res/constants/custom_textstyle.dart';
import '../../res/constants/server_calls.dart';
import '../custom/timer.dart';
import '../general/webview_in.dart';
import '../web_view.dart';

class ChildScreen extends StatefulWidget {
  final String? status;
  final String? value;
  final String? jobtype;
  const ChildScreen({Key? key, this.status, this.value, this.jobtype})
      : super(key: key);

  @override
  State<ChildScreen> createState() => _ChildScreenState();
}

class _ChildScreenState extends State<ChildScreen> {
  var accessToken = '';
  String jobtype = '';
  var surveyorId = '';
  List<Fields> avialfields = [];
  late TimerService timerService;

  late User user;
  Map<String, dynamic> fields = {};
  bool isLoading = true;
  Map<String, dynamic> surveydata = {};
  List<String> subJobTypes = [];
  List<Widget> subJobWidgetList = [];
  late TabController _tabController;
  int initialHours = 23;
  int _currentPage = 1;
  int totalPages = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KColors.appColor,
        title: Text(
          '${widget.value}',
          style: KTextStyle.appTitleFontStyle,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? AppLoader.showLoader()
          : user.jobs.isNotEmpty
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: user.jobs.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (widget.status == 'Open') {
                                return insuranceBody(index);
                              } else if (widget.status == 'Pending') {
                                return insuranceBody1(index);
                              } else if (widget.status == 'Completed') {
                                return insuranceBody3(index);
                              } else {
                                return insuranceBodyWidget(index);
                              }
                            },
                          ),
                          const SizedBox(
                              height: 100,
                            )
                        ],
                      ),
                    ),
                     Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: NumberPaginator(
                          // by default, the paginator shows numbers as center content
                          numberPages: totalPages,
                          initialPage: _currentPage - 1,
                          onPageChange: (int index) {
                            setState(() {
                              _currentPage = index +
                                  1; // _currentPage is a variable within State of StatefulWidget
                              getSurveyors();
                            });
                          },
                          config: const NumberPaginatorUIConfig(
                            // default height is 48
                           
                            buttonSelectedForegroundColor: Colors.white,
                            buttonUnselectedForegroundColor: KColors.appColor,
                            //buttonUnselectedBackgroundColor: Colors.grey,
                            buttonSelectedBackgroundColor: KColors.appColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'No data available',
                        style: TextStyle(color: KColors.black),
                      ),
                    ],
                  ),
                ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    timerService = TimerService(initialHours);
    timerService.startTimer();
    requestLocationPermission();
    print("jobtype1::::${widget.jobtype}");
    getLocalStorage();
    super.initState();
  }

  Widget insuranceBodyWidget(int index) {
    if (user.jobs.isNotEmpty) {
      final firstJob = user.jobs;
      if (firstJob.isNotEmpty && avialfields.isNotEmpty) {
        final firstCreatedSubJob = firstJob[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
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
              shadowColor: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    avialfields.length > 5
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          '${avialfields.isNotEmpty ? avialfields[0].name!.split('(').first ?? '' : ''} : ',
                                          style: KTextStyle.bold14BFontStyle,
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                          width: 3,
                                        ),
                                        Expanded(
                                          child: Text(
                                            firstCreatedSubJob.data.isNotEmpty
                                                ? firstCreatedSubJob.data[
                                                            avialfields[0]
                                                                .name]!
                                                        .split('(')
                                                        .first ??
                                                    ''
                                                : '',
                                            style:
                                                KTextStyle.regularDescFontStyle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${avialfields.isNotEmpty ? avialfields[1].name!.split('(').first ?? '' : ''} : ',
                                    style: KTextStyle.bold14BFontStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0), // Assuming font size for 1 line
                                      child: Text(
                                        firstCreatedSubJob.data.isNotEmpty
                                            ? (firstCreatedSubJob
                                                    .data[avialfields[1].name]!
                                                    .split('(')
                                                    .first ??
                                                '')
                                            : '',
                                        style: KTextStyle.regularDescFontStyle,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${avialfields.isNotEmpty ? avialfields[2].name!.split('(').first ?? '' : ''} : ',
                                    style: KTextStyle.bold14BFontStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0), // Assuming font size for 1 line
                                      child: Text(
                                        firstCreatedSubJob.data.isNotEmpty
                                            ? (firstCreatedSubJob
                                                    .data[avialfields[2].name]!
                                                    .split('(')
                                                    .first ??
                                                '')
                                            : '',
                                        style: KTextStyle.regularDescFontStyle,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${avialfields.isNotEmpty ? avialfields[3].name!.split('(').first ?? '' : ''} : ',
                                    style: KTextStyle.bold14BFontStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0), // Assuming font size for 1 line
                                      child: Text(
                                        firstCreatedSubJob.data.isNotEmpty
                                            ? (firstCreatedSubJob
                                                    .data[avialfields[3].name]!
                                                    .split('(')
                                                    .first ??
                                                '')
                                            : '',
                                        style: KTextStyle.regularDescFontStyle,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${avialfields.isNotEmpty ? avialfields[4].name!.split('(').first ?? '' : ''} : ',
                                    style: KTextStyle.bold14BFontStyle,
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                    width: 3,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0), // Assuming font size for 1 line
                                      child: Text(
                                        firstCreatedSubJob.data.isNotEmpty
                                            ? (firstCreatedSubJob
                                                    .data[avialfields[4].name]!
                                                    .split('(')
                                                    .first ??
                                                '')
                                            : '',
                                        style: KTextStyle.regularDescFontStyle,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics:  const NeverScrollableScrollPhysics(),
                            itemCount: avialfields.length,
                            itemBuilder: (BuildContext context, int i) {
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${avialfields[i].name?.split('(').first ?? ''} : ',
                                        style: KTextStyle.bold14BFontStyle,
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 3,
                                        width: 3,
                                      ),
                                      Expanded(
                                        child: Container(
                                          // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0), // Assuming font size for 1 line
                                          child: Text(
                                            firstCreatedSubJob.data.isNotEmpty
                                                ? (firstCreatedSubJob.data[
                                                            avialfields[i]
                                                                .name]!
                                                        .split('(')
                                                        .first ??
                                                    '')
                                                : '',
                                            style:
                                                KTextStyle.regularDescFontStyle,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              );
                            },
                          ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Job Status: ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Expanded(
                          child: Text(
                            firstCreatedSubJob.currentJobStatus != null
                                ? firstCreatedSubJob.currentJobStatus ?? ''
                                : '',
                            style: KTextStyle.regularDescFontStyle,
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print(
                                'url:::${ApiConstants.editJob1('${firstCreatedSubJob.id}', jobtype)}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWebView(
                                  url: ApiConstants.editJob1(
                                      '${firstCreatedSubJob.id}', jobtype),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                KColors.appColor, // Use the app's primary color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  5.0), // Set the button radius to 5
                            ),
                          ),
                          child: Text(
                            'Edit',
                            style: KTextStyle.appTitleFontStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return const Center(
      child: Text(
        'No data available',
        style: TextStyle(color: KColors.black),
      ),
    );
  }

  Widget insuranceBody(int index) {
    if (user.jobs.isNotEmpty) {
      final firstJob = user.jobs;
      if (firstJob.isNotEmpty && avialfields.isNotEmpty) {
        final firstCreatedSubJob = firstJob[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
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
              shadowColor: Colors.grey,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[0].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[0].name]!
                                      .split('(')
                                      .first ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[1].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[1].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[2].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[2].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[3].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[3].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[4].name!.split('(').first ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[4].name]!
                                      .split('(')
                                      .first ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double
                            .infinity, // Set the width to match the parent's width
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Dash(),
                            //   ),
                            // );
                          },
                          child: Text(
                            'Accept',
                            style: KTextStyle.appTitleFontStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return const SizedBox(); // Return an empty SizedBox if no data is available
  }

  Widget insuranceBody1(int index) {
    if (user.jobs.isNotEmpty) {
      final firstJob = user.jobs;
      if (firstJob.isNotEmpty && avialfields.isNotEmpty) {
        final firstCreatedSubJob = firstJob[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
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
              shadowColor: Colors.grey,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '${avialfields.isNotEmpty ? avialfields[0].name ?? '' : ''} : ',
                                style: KTextStyle.bold14BFontStyle,
                                textAlign: TextAlign.left,
                              ),
                              const SizedBox(
                                height: 3,
                                width: 3,
                              ),
                              Text(
                                firstCreatedSubJob.data.isNotEmpty
                                    ? firstCreatedSubJob
                                            .data[avialfields[0].name] ??
                                        ''
                                    : '',
                                style: KTextStyle.regularDescFontStyle,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.directions,
                            size: 40, // Increase the size as needed
                            color: Colors
                                .blue, // Change the color to your desired color
                          ),
                          onPressed: () {
                            openDirections(
                                'Hitech City Rd,Sri Sai Nagar,Madhapur, Hyderabad,Telangana – 500081');
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => CustomMapPage()),
                            // );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[1].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[1].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[2].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[2].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[3].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[3].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${avialfields.isNotEmpty ? avialfields[4].name ?? '' : ''} : ',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 3,
                          width: 3,
                        ),
                        Text(
                          firstCreatedSubJob.data.isNotEmpty
                              ? firstCreatedSubJob.data[avialfields[4].name] ??
                                  ''
                              : '',
                          style: KTextStyle.regularDescFontStyle,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: StreamBuilder<String>(
                          stream: timerService.currentTimeStream,
                          initialData: timerService.getCurrentTime(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.timer_outlined,
                                      color: KColors.appColor),
                                  const SizedBox(
                                      width:
                                          5), // Add some space between the icon and text
                                  Text(snapshot.data!,
                                      style: KTextStyle.redTextBold),
                                ],
                              );
                            } else {
                              return const Text(
                                  'Loading...'); // You can show a loading indicator while waiting for the initial data
                            }
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: double
                            .infinity, // Set the width to match the parent's width
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MyWebView(
                            //               url: ApiConstants.editJob(firstJob.id,
                            //                   '${firstCreatedSubJob.id}'),
                            //             )));
                          },
                          child: Text(
                            'Edit',
                            style: KTextStyle.appTitleFontStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
    return const SizedBox(); // Return an empty SizedBox if no data is available
  }

  Widget insuranceBody3(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
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
          shadowColor: Colors.grey,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'CLAIM NO:',
                          style: KTextStyle.bold14BFontStyle,
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Ca-1533063021215',
                          style: KTextStyle.regularDescFontStyle,
                        ),
                      ],
                    ),
                    // Text(
                    //   'Rejeted',
                    //   style: TextStyle(
                    //     color: Colors.red, // Set the color of the text to red
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 16.0,
                    //   ),
                    // ),
                  ],
                ),

                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'NAME:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      'Shyam',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'MOBILE NO:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      '943337469',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LOCATION:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      'Madhapur',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DISTANCE:',
                      style: KTextStyle.bold14BFontStyle,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 3,
                      width: 3,
                    ),
                    Text(
                      '2KM',
                      style: KTextStyle.regularDescFontStyle,
                    )
                  ],
                ),

                const SizedBox(
                  height: 20.0,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     ElevatedButton(
                //       onPressed: () {
                //         // Add your first button action here
                //       },
                //       child: Text('Edit'),
                //     ),
                //     ElevatedButton(
                //       onPressed: () {
                //         // Add your second button action here
                //       },
                //       child: Text('Directions'),
                //     ),
                //   ],
                // ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Container(
                //     width: double
                //         .infinity, // Set the width to match the parent's width
                //     child: ElevatedButton(
                //       onPressed: () {
                //         // Add your button action here
                //       },
                //       child: Text(
                //         'Edit',
                //         style: KTextStyle.appTitleFontStyle,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } on PlatformException catch (e) {
      print("Error getting location: $e");
      throw e; // You can handle the error as per your requirement
    }
  }

  void openDirections(String destination_address) async {
    // Show loader
    AppLoader.showLoader();

    try {
      final currentLocation = await getCurrentLocation();

      final url =
          'https://www.google.com/maps/dir/?api=1&origin=${currentLocation.latitude},${currentLocation.longitude}&destination=$destination_address';

      if (await canLaunch(url)) {
        // Hide loader before launching URL
        AppLoader.hideLoader();
        await launch(url);
      } else {
        // Hide loader if URL launch fails
        AppLoader.hideLoader();
        throw 'Could not launch $url';
      }
    } catch (e) {
      // Hide loader if an error occurs
      AppLoader.hideLoader();
      // Handle any errors
      print('Error opening directions: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to open directions. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close error dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      await handlePermissionDenied();
    }
  }

  Future<void> handlePermissionDenied() async {
    final status = await Permission.location.status;
    if (status != PermissionStatus.granted) {
      // Permission still not granted, prompt the user to grant permission again
      final isGranted = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
              'To use this feature, please grant location permission.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final status = await Permission.location.request();
                Navigator.of(context).pop(status == PermissionStatus.granted);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
      if (!isGranted) {
        // Handle the case where the user denies permission again
        // You can show a message or disable the feature that requires location permission.
      }
    }
  }

  getLocalStorage() async {
    accessToken = await readTheData('accessToken');
    //surveyorId = await readTheData('surveyorId');
    //Map<String, dynamic>? dd = await readJsonData('surveyorData');
    print('dd');
    setState(() {
      accessToken = accessToken;
      jobtype = widget.jobtype ?? 'Claim Register';
    });
    getSurveyors();
  }

  Future<void> getSurveyors() async {
    isLoading = true;
    String fields_url = ApiConstants.getMastersFieldsAPi(jobtype);
    fields = await ServerCall.getRequest(fields_url, token: accessToken);
    String instances_url = ApiConstants.getFilterApi(
        jobtype, _currentPage, 10, '${widget.status}', '${widget.value}');
    print("filterUrl:${instances_url}");
    Map<String, dynamic> instanceRes =
        await ServerCall.getRequest(instances_url, token: accessToken);

    AllJobsTypeList filedResponse = AllJobsTypeList.fromJson(fields);
    if (filedResponse.jobs != null) {
      setState(() {
        avialfields = filedResponse.jobs!.first.fields!;

        user = User.fromJson(instanceRes, avialfields);
  if (user.totalNumRecords != null) {
      totalPages = (user.totalNumRecords! / 10).ceil();
      // Continue with the rest of your code using totalPages...
    }        print(totalPages);

        _currentPage = user.currentPageNumber!;
        print(_currentPage);
      });
    }
    AppLoader.hideLoader();
    isLoading = false;
  }
}
