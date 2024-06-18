import 'dart:convert';

import 'package:Surveyors/model/subjobs_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class SharedPreferencesClass {
writeTheData(String key, dynamic value) async {
  final prefs = await SharedPreferences.getInstance();
  if (value is String) {
    prefs.setString(key, value);
  } else if (value is int) {
    prefs.setInt(key, value);
  } else if (value is bool) {
    prefs.setBool(key, value);
  } else if (value is List<Fields>) {
    print(
      'value:$value'
    );
    final jsonString =
        jsonEncode(value.map((field) => field.toJson()).toList());
    prefs.setString(key, jsonString);
  }
}
writeJsonData(String key,Map<String, dynamic> data) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
}
Future<Map<String, dynamic>?> readJsonData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  if (jsonString != null) {
    return jsonDecode(jsonString);
  } else {
    return null;
  }
}
readTheData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.get(key);
}
Future<List<Fields>> readFieldsData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final jsonString = prefs.getString(key);
  if (jsonString != null) {
    final List<dynamic> decodedList = jsonDecode(jsonString);
    final List<Fields> fieldsList = decodedList.map((json) => Fields.fromJson(json)).toList();
    return fieldsList;
  }
  return [];
}

deleteTheData(String key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

clearTheData() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
//}