import 'package:Surveyors/model/subjobs_model.dart';

class FieldTypeModel {
  List<Fields> fields;
  int? status;
  List<FieldData>? jobs;

  FieldTypeModel.fromJson(Map<String, dynamic> json, this.fields) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <FieldData>[];
      json['jobs'].forEach((v) {
        jobs!.add(FieldData.fromJson(v, fields));
      });
    }
  }
}

class FieldData {
  int? id;
  String? jobtype;
  String? dropdown;
  Map<String, dynamic> data = {};
  FieldData.fromJson(Map<String, dynamic> json, List<Fields> fields) {
    id = json['id'];
    jobtype = json['jobTypeName'];

    _initializeData(json, fields);

  }
  void _initializeData(Map<String, dynamic> json, List<Fields> fields) {
    for (Fields field in fields) {
      String fieldName = field.name!;
      dynamic fieldValue = json[fieldName];

      // Split the field value if it contains '(' and take the first part

      if (fieldValue != null && fieldValue.toString().isNotEmpty) {
        if (fieldValue is Iterable) {
          List<String> stringList = [];

          for (var item in fieldValue) {
            if (item != null) {
              stringList.add(item.toString());
            }
          }
          data[fieldName] = stringList;
        } else {
          data[fieldName] = fieldValue.toString();
        }
      } else {
        data[fieldName] = '';
      }
    }
  }

  //item code
  FieldData.fromJson1(Map<String, dynamic> json, List<Fields> fields) {
    id = json['id'];
    jobtype = json['jobTypeName'];

    _initializeData1(json, fields);

  }
  void _initializeData1(Map<String, dynamic> json, List<Fields> fields) {
    for (Fields field in fields) {
      String fieldName = field.name!;
      dynamic fieldValue = json[fieldName];
      if (fieldValue != null) {
        //item codes assign based on value
        if (field.allowedValuesResults != null) {
          Map<String, dynamic> itemcode = field.allowedValuesResults;
          for (var entry in itemcode.entries) {
            String key = entry.key;
            dynamic value = entry.value;
            value = value.toString().split('~').last;
            if (key.toString().contains(fieldValue)) {
              fieldValue = value;
            }
          }
          dynamic dropdown1 = itemcode[fieldValue];
          if (dropdown1 != null) {
            fieldValue = dropdown1;
          }
        }
      }
      // Split the field value if it contains '(' and take the first part

      if (fieldValue != null && fieldValue.toString().isNotEmpty) {
        if (fieldValue is Iterable) {
          data[fieldName] = fieldValue.cast<String>().toList();
        } else {
          data[fieldName] = fieldValue.toString();
        }
      } else {
        data[fieldName] = '';
      }
    }
  }
}
