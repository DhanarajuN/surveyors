import 'dart:convert';

import 'package:Surveyors/data/local_store_helper.dart';
import 'package:Surveyors/res/components/loader.dart';
import 'package:Surveyors/res/components/toast.dart';
import 'package:Surveyors/res/constants/common_method.dart';
import 'package:Surveyors/res/constants/routes_constants.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServerCall {
  ServerCall._();
  static Future<Map<String, dynamic>> postRequest(String url,
      {String? token, BuildContext? context, dynamic body}) async {
    AppLoader.showLoader();

    // var accessToken = readTheData('accessToken');
    var headers = <String, String>{};
    // if (token != null) {
    //   headers['Authorization'] = 'Bearer $token';
    // }

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    AppLoader.hideLoader();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> loginPostRequest(String url,
      {String? token, BuildContext? context, dynamic body}) async {
    AppLoader.showLoader();

    // var accessToken = readTheData('accessToken');
    var headers = <String, String>{};
    // if (token != null) {
    headers['X-Tenant'] = 'jcg';
    // }

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    AppLoader.hideLoader();
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> getRequest(String url,
      {String? token,BuildContext? context}) async {
    AppLoader.showLoader();
    var headers = <String, String>{};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    var response = await http.get(Uri.parse(url), headers: headers);
    AppLoader.hideLoader();

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      if (jsonResponse.containsKey('message') &&
          jsonResponse['message'].contains('The Token has expired')) {
        // Handle token expiration here
        showToast('The Session is Expired ...');
        return {'tokenExpired': true}; // Indicate the token has expired
      }
      print('urL:  $url');
     // print('responsee:   $jsonResponse');
      return jsonResponse;
    } else if (response.statusCode == 403) {
      final jsonResponse = json.decode(response.body);

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      GoRouter.of(context!).push(RoutesList.login);
      return jsonResponse;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
