import '../../model/subjobs_model.dart';
class User{
  final String id;
  final String itemCode;
  final List<Job> jobs;
  User({required this.id, required this.itemCode,required this.jobs} );
////////////////
factory User.fromJson(Map<String, dynamic> json, List<Fields> avialfields) {
  return User(
    id: json['id'] ?? '',
    itemCode: json['ItemCode'] ?? '',
    jobs: (json['jobs'] as List<dynamic>?)
        ?.map((jobJson) => Job.fromJson(jobJson, avialfields))
        .toList() ?? [],
  );
}}
class Job {
  final String id;
  final String itemCode;
  final List<CreatedSubJob> createdSubJobs;

  Job({
    required this.id,
    required this.itemCode,
    required this.createdSubJobs,
  });

 factory Job.fromJson(Map<String, dynamic> json, List<Fields> avialfields) {
  return Job(
    id: json['id'] ?? '',
    itemCode: json['ItemCode'] ?? '',
    createdSubJobs: (json['CreatedSubJobs'] as List<dynamic>?)
        ?.map((subJobJson) => CreatedSubJob.fromJson(subJobJson, avialfields))
        .toList() ?? [],
  );
}

}
class CreatedSubJob {
  String? id;
  String? jobtype;
  String? dropdown;
  Map<String, dynamic> data = {};
  CreatedSubJob.fromJson(Map<String, dynamic> json, List<Fields> fields) {
    id = json['id'];
    jobtype = json['jobTypeName'];
    data=json['data'];

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
  CreatedSubJob.fromJson1(Map<String, dynamic> json, List<Fields> fields) {
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
