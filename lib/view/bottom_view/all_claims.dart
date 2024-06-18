import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/local_store_helper.dart';
import '../../data_model/dynamic_job_data.dart';
import '../../data_model/job_model.dart';
import '../../main.dart';
import '../../model/subjobs_model.dart';
import '../../push_notification.dart';
import '../../res/components/loader.dart';
import '../../res/constants/api_constants.dart';
import '../../res/constants/colors.dart';
import '../../res/constants/custom_textstyle.dart';
import '../../res/constants/routes_constants.dart';
import '../../res/constants/server_calls.dart';
import '../custom/timer.dart';
import '../general/map_page.dart';
import '../general/webview_in.dart';
import '../web_view.dart';

class AllClaimsScreen extends StatefulWidget {
  final String? type;
  const AllClaimsScreen({Key? key, this.type}) : super(key: key);

  @override
  State<AllClaimsScreen> createState() => _AllClaimsScreenState();
}

class _AllClaimsScreenState extends State<AllClaimsScreen>
    with SingleTickerProviderStateMixin {
  var accessToken = '';
  var surveyorId = '';
  List<Fields> avialfields = [];
  late TimerService timerService;
  String? type = '';

  late User user;
  Map<String, dynamic> fields = {};
  bool isLoading = true;
  Map<String, dynamic> surveydata = {};
  List<String> subJobTypes = [];
  List<Widget> subJobWidgetList = [];
  int initialHours = 23;
  int _currentPage = 1;
  int totalPages = 0;
  final NumberPaginatorController _controller = NumberPaginatorController();

  @override
  void initState() {
    super.initState();
    timerService = TimerService(initialHours);
    timerService.startTimer();
    requestLocationPermission();
    getLocalStorage();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? AppLoader.showLoader()
          : user.jobs.isEmpty
              ? Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: user.jobs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: insuranceBody1(index),
                                );
                              },
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 16,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
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
                          config: NumberPaginatorUIConfig(
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
                ),
    );
  }

  @override
  void dispose() {
    super.dispose();
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
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0),
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
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0),
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
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0),
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
                                      // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0),
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
                            physics: const NeverScrollableScrollPhysics(),
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
                                          // height: 5 * (KTextStyle.regularDescFontStyle.fontSize ?? 14.0),
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
                                'url:::${ApiConstants.editJob1('${firstCreatedSubJob.id}', type!)}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWebView(
                                  url: ApiConstants.editJob1(
                                      '${firstCreatedSubJob.id}', type!),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: KColors.appColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
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
    return Center(
      child: Text(
        'No data available',
        style: TextStyle(color: KColors.black),
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
      throw e;
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
    Map<String, dynamic>? dd = await readJsonData('surveyorData');
    print('dd');
    setState(() {
      accessToken = accessToken;
      type = widget.type ?? 'Claim Register';
    });
    // _requestPermissions();
    getSurveyors();
  }

  Future<void> _requestPermissions() async {
    final cameraStatus = await Permission.camera.request();
    Permission.mediaLibrary.request();
    Permission.photos.request();
    Permission.storage.request();
    Permission.camera.request();
    // Request storage permission
    final status = await Permission.manageExternalStorage.request();

    if (cameraStatus!.isGranted && status.isGranted) {
      print('Permissions granted');
    } else {
      // At least one of the permissions is denied
      print('Permissions denied');
    }
  }

  Future<void> getSurveyors() async {
    isLoading = true;
    String fields_url = ApiConstants.getMastersFieldsAPi(type!);
    fields = await ServerCall.getRequest(fields_url,
        token: accessToken, context: context);
    String instances_url =
        ApiConstants.getMastersAPi(type!, '${_currentPage}', '10');
    Map<String, dynamic> instanceRes = await ServerCall.getRequest(
        instances_url,
        token: accessToken,
        context: context);

    AllJobsTypeList filedResponse = AllJobsTypeList.fromJson(fields);
    if (filedResponse.jobs != null) {
      setState(() {
        avialfields = filedResponse.jobs!.first.fields!;

        user = User.fromJson(instanceRes, avialfields);
      });
    }
    if (user.totalNumRecords != null) {
      totalPages = (user.totalNumRecords! / 10).ceil();
      // Continue with the rest of your code using totalPages...
    }
    print(totalPages);

    _currentPage = user.currentPageNumber!;
    print(_currentPage);
    AppLoader.hideLoader();
    isLoading = false;
  }
}
