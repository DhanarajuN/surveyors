import '../../model/subjobs_model.dart';
class User{
  final String id;
  final String itemCode;
  final List<Jobs> jobs;
  final int? totalNumRecords;
  final int? count;
  final int?currentPageNumber;
  User({required this.id, required this.itemCode,required this.jobs,this.totalNumRecords,this.count,this.currentPageNumber} );

factory User.fromJson(Map<String, dynamic> json, List<Fields> avialfields) {
  return User(
    id: json['id'] ?? '',
    itemCode: json['ItemCode'] ?? '',
    jobs: (json['jobs'] as List<dynamic>?)
        ?.map((jobJson) => Jobs.fromJson(jobJson, avialfields))
        .toList() ?? [],
    totalNumRecords: json['totalNumRecords'],
    count: json['count'],
    currentPageNumber: json['currentPageNumber'],

  );
}}

class Jobs{
  String? id;
  String? jobtype;
  String? dropdown;
  String? currentJobStatus;
  Map<String, dynamic> data = {};
  Jobs.fromJson(Map<String, dynamic> json, List<Fields> fields) {
    id = json['id'];
    jobtype = json['jobTypeName'];
    data=json['data'];
    currentJobStatus=json['Current_Job_Status'];

    _initializeData(data, fields);
  
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
  Jobs.fromJson1(Map<String, dynamic> json, List<Fields> fields) {
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
  }}
