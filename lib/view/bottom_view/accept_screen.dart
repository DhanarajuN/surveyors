import 'package:Surveyors/res/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local_store_helper.dart';
import '../../data_model/dynamic_job.dart';
import '../../model/subjobs_model.dart';
import '../../res/components/loader.dart';
import '../../res/constants/api_constants.dart';
import '../../res/constants/custom_textstyle.dart';
import '../../res/constants/server_calls.dart';
import '../custom/timer.dart';
import '../general/map_page.dart';
import '../web_view.dart';

class AcceptScreen extends StatefulWidget {
  const AcceptScreen({super.key});

  @override
  State<AcceptScreen> createState() => _AcceptScreenState();
}

class _AcceptScreenState extends State<AcceptScreen> {
  var accessToken = '';
  var surveyorId = '';
  int initialHours = 24; // Initial duration in hours
  late TimerService timerService;
  List<Fields> avialfields = [];
  late User user;
  Map<String, dynamic> fields = {};
  bool isLoading = true;
  Map<String, dynamic> surveydata = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? AppLoader.showLoader()
          : ListView.builder(
              itemCount: user.jobs.first.createdSubJobs.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: insuranceBody(index));
              }),
    );
  }

  Widget insuranceBody(int index) {
    if (user.jobs.isNotEmpty) {
      final firstJob = user.jobs.first;
      if (firstJob.createdSubJobs.isNotEmpty && avialfields.isNotEmpty) {
        final firstCreatedSubJob = firstJob.createdSubJobs[index];
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
                            // need open map directions current location to claims co-ordinatins
                            openDirections(
                                'Hitech City Rd,Sri Sai Nagar,Madhapur, Hyderabad,Telangana – 500081');
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
                            print('edit::' +
                                ApiConstants.editJob(
                                    firstJob.id, '${firstCreatedSubJob.id}'));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWebView(
                                          url: ApiConstants.editJob(firstJob.id,
                                              '${firstCreatedSubJob.id}'),
                                        )));
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

  @override
  void initState() {
    getLocalStorage();
    timerService = TimerService(initialHours);
    timerService.startTimer();
    super.initState();
  }

  Widget insuranceBody1() {
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
                    IconButton(
                      icon: const Icon(
                        Icons.directions,
                        size: 40, // Increase the size as needed
                        color: Colors
                            .blue, // Change the color to your desired color
                      ),
                      onPressed: () {
                        // Add your icon action here
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
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: double
                        .infinity, // Set the width to match the parent's width
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your button action here
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

  getLocalStorage() async {
    accessToken = await readTheData('accessToken');
    surveyorId = await readTheData('surveyorId');
    //Map<String, dynamic>? dd = await readJsonData('surveyorData');
    print('dd');
    setState(() {
      accessToken = accessToken;
      requestLocationPermission();
    });
    getSurveyors();
  }

  Future<void> getSurveyors() async {
    isLoading = true;
    String fields_url = ApiConstants.getMastersFieldsAPi('Claim Register');
    fields = await ServerCall.getRequest(fields_url, token: accessToken);
    String instances_url = ApiConstants.instanceUrl(surveyorId);
    Map<String, dynamic> instanceRes =
        await ServerCall.getRequest(instances_url, token: accessToken);

    AllJobsTypeList filedResponse = AllJobsTypeList.fromJson(fields);
    if (filedResponse.jobs != null) {
      setState(() {
        avialfields = filedResponse.jobs!.first.fields!;
        user = User.fromJson(instanceRes, avialfields);
        print('fjafjf:::::::${user.jobs.first.createdSubJobs}');

        for (Fields field in avialfields) {
          print('fields:${field.name}');
        }
      });
    }
    print(
        'parent: ${user.id}  child:${user.jobs.first.id}  child:${user.jobs.first.createdSubJobs.first.id}');

    AppLoader.hideLoader();
    isLoading = false;
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
            content: const Text('Failed to open directions. Please try again later.'),
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
          content:
              const Text('To use this feature, please grant location permission.'),
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
}
