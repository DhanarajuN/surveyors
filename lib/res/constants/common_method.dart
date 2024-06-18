import 'dart:io';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonMethod {
  static dynamic getValueFromJson(Map<String, dynamic> json, String key) {
    if (json.containsKey(key)) {
      print('json Value: ${json[key]}');
      return json[key];
    }
    return null;
  }

  static logout(BuildContext context) async {
    AppLoader.showLoader();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Simulating the asynchronous logout process
      await Future.delayed(const Duration(seconds: 1));

      AppLoader.hideLoader();

      // Navigating to the login route using GoRouter
      GoRouter.of(context).go(RoutesList.login);
    } catch (error) {
      print("Logout error: $error");
      AppLoader.hideLoader();
    }
  }

  //  external browser
  static Future<void> externalBrowser(String url) async {
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  static Future<void> downloadFile(String? url, String type) async {
    AppLoader.showLoader();
    final downloadPath = await _getDownloadPath();
    final uri = Uri.parse(url!);
    final fileName =
        uri.pathSegments.last; // Specify the desired file name here

    try {
      Dio dio = Dio();
      dio.options.responseType = ResponseType.bytes;

      Response response = await dio.get(
        url,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(0);
            print('Download progress: $progress%');
          }
        },
      );

      File file = File('$downloadPath/$fileName.pdf');

      // Check if the parent directory exists, and create it if necessary
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }

      // Write the downloaded data to the file
      await file.writeAsBytes(response.data);

      showToast("Document downloaded");

      AppLoader.hideLoader();
      if (type == 'share') {
        final result =
            await Share.shareXFiles([XFile(file.path)], text: 'Document');
      } else {
        await _openDownloadedFile(file.path);
      }
    } catch (e) {
      showToast("Download failed: $e");
      print('Download Error: $e');
      AppLoader.hideLoader();
    }
  }

  static Future<String> _getDownloadPath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path + '/Download';
  }

  static _openDownloadedFile(String filePath) async {
    final file = File(filePath);

    if (!file.existsSync()) {
      print("File does not exist at path: $filePath");
      showToast("File cannot be opened. File does not exist.");
      return;
    }

    try {
      if (Platform.isAndroid) {
        final deviceInfo = DeviceInfoPlugin();
        final androidInfo = await deviceInfo.androidInfo;

        if (androidInfo.version.sdkInt >= 30) {
          // Devices running Android SDK 30 and above
          final status = await Permission.manageExternalStorage.request();
          if (status.isGranted) {
            print(file.path);
            await OpenFile.open(file.path);
          } else {
            print("Permission denied");
            showToast("File cannot be opened. Permission denied.");
          }
        } else {
          // Devices running Android SDK below 30
          final status = await Permission.storage.request();
          if (status.isGranted) {
            await Future.delayed(Duration(milliseconds: 500));
            await OpenFile.open(file.path);
          } else {
            print("Permission denied");
            showToast("File cannot be opened. Permission denied.");
          }
        }
      } else if (Platform.isIOS) {
        await OpenFile.open(file.path);
      } else {
        print("Platform not supported");
      }
    } catch (e) {
      print("Error opening file: $e");
      showToast("File cannot be opened.");
    }
  }

  static Future<void> openFileUsingStorageAccessFramework(
      String filePath) async {
    try {
      final uri = Uri.file(filePath);
      await OpenFile.open(uri.toString());
    } catch (e) {
      print("Error opening file using Storage Access Framework: $e");
      showToast("File cannot be opened.");
    }
  }

  static Future<bool> checkStoragePermission() async {
    if (Platform.isAndroid) {
      var deviceInfo = DeviceInfoPlugin();
      var androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 30) {
        // Devices running Android SDK 30 and above
        PermissionStatus status =
            await Permission.manageExternalStorage.request();
        return status.isGranted;
      } else {
        // Devices running Android SDK below 30
        PermissionStatus status = await Permission.storage.request();
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      return true;
    } else {
      // Platform not supported
      return false;
    }
  }
  
static Future<Position?> requestLocationPermission() async {
  while (true) {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, prompt user to enable
      print('Please enable location services.');
       LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permission to access location is denied
      print('Permission to access location is denied.');
       //await Geolocator.openLocationSettings(); // Opens location settings on device
     LocationPermission permission = await Geolocator.requestPermission();
      continue;
    }
    }


    try {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
      return position;
    } catch (e) {
      
      await Geolocator.openLocationSettings();
      print('Error fetching location: $e');
      return null;
    }
  }
}
}
