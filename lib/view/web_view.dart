import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/constants/api_constants.dart';
import 'package:Surveyors/res/constants/colors.dart';
import 'package:Surveyors/res/constants/custom_textstyle.dart';

class MyWebView extends StatefulWidget {
  final String url;
  final bool? visibleAppbar;

  const MyWebView({Key? key, required this.url, this.visibleAppbar}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController _mobileController;
  late final PlatformWebViewController _webController;
  bool _pageLoaded = true;
  bool app_Bar = true;
  String url = '';

  @override
 void initState() {
  super.initState();
  url = widget.url;
  app_Bar = widget.visibleAppbar ?? true;

  if (kIsWeb) {
    _pageLoaded = false;
    AppLoader.hideLoader();

    _webController = PlatformWebViewController(
      const PlatformWebViewControllerCreationParams(),
    )
    ..loadRequest(
      LoadRequestParams(
        uri: Uri.parse(url),
      ),
    );
    // ..setPlatformNavigationDelegate(
    //   PlatformNavigationDelegate(
    //     // Assuming the required argument is a function or handler, you need to define it correctly
    //     (navigationRequest) {
    //       // Handle navigation request here
    //       return NavigationDecision.navigate;
    //     },
    //   ),
    // );

    // _webController.currentUrl().then((currentUrl) {
    //   print('Current URL: ${_webController.currentUrl()}');
    // });

  } else {
    _mobileController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              setState(() {
                _pageLoaded = false;
                AppLoader.hideLoader();
              });
            } else {
              setState(() {
                _pageLoaded = true;
              });
            }
          },
          onPageFinished: (url) {
            _handlePageNavigation(url);
          },
          onPageStarted: (url) {
            _handlePageNavigation(url);
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    addFileSelectionListener();
  }
}


  void _handlePageNavigation(String url) {
    print("url:::${url}");
    if (url.contains('https://insurancedemo.gosure.ai/login')) {
      setState(() {
        url = 'https://insurancedemo.gosure.ai/${ApiConstants.tenant}/login';
        if (kIsWeb) {
          _webController.loadRequest(
            LoadRequestParams(
              uri: Uri.parse(url),
            ),
          );
        } else {
          _mobileController.loadRequest(Uri.parse(url));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: app_Bar
          ? AppBar(
              backgroundColor: KColors.appColor,
              title: Text('Edit', style: KTextStyle.appTitleFontStyle),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            )
          : null,
      body: _pageLoaded
          ? AppLoader.showLoader()
          : kIsWeb
              ? PlatformWebViewWidget(
                  PlatformWebViewWidgetCreationParams(controller: _webController),
                ).build(context)
              : WebViewWidget(controller: _mobileController),
    );
  }

  void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      final androidController = _mobileController.platform as AndroidWebViewController;
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(final FileSelectorParams params) async {
    final List<String> filePaths = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () async {
                  Navigator.pop(context, ['camera']);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Camera Recorder'),
                onTap: () async {
                  Navigator.pop(context, ['camera_recorder']);
                },
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text('File Picker'),
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                  if (result != null && result.files.isNotEmpty) {
                    final paths = result.files.map((file) => file.path!).toList();
                    Navigator.pop(context, paths);
                  } else {
                    Navigator.pop(context, []);
                  }
                },
              ),
            ],
          ),
        );
      },
    );

    if (filePaths.isNotEmpty) {
      if (filePaths.first == 'camera') {
        final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
        return pickedFile != null ? [Uri.file(pickedFile.path).toString()] : [];
      } else if (filePaths.first == 'camera_recorder') {
        final pickedFile = await ImagePicker().pickVideo(source: ImageSource.camera);
        return pickedFile != null ? [Uri.file(pickedFile.path).toString()] : [];
      } else {
        return filePaths.map((path) => Uri.file(path).toString()).toList();
      }
    }

    return [];
  }
}
