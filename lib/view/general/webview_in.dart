import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView1 extends StatefulWidget {
  final String url;
  const MyWebView1({Key? key, required this.url}) : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView1> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(title: const Text('EditJob')),
    body: WebViewWidget(controller: _controller),
  );
  }
}
