import 'package:Surveyors/data_model/module_catgories.dart';

class Modulecategories {
  String? status;
  List<Jobs>? jobs;

  Modulecategories({this.status, this.jobs});

  Modulecategories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(Jobs.fromJson(v));
      });
    }
  }
}

class Jobs {
  String? id;
  Data? data;
  String? current_job_status;

  Jobs({this.id, this.data, this.current_job_status});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    current_job_status = json['Current_Job_Status'];
  }
}

class Data {
  String? restrictedRoles;
  String? module;
  String? moduleLabel; // Corrected field name
  String? moduleValue;
  String? moduleEntryJobId;
  late List<String> menuKey;
  late List<String> menuRouterLink;
  late List<String> menuEntryJobId;
  String? loadingMsg;
  String? noRecordsMsg;
  String? modulePriority;
  String? moduleType;

  Data(
      {this.restrictedRoles,
      this.module,
      this.moduleLabel,
      this.moduleValue,
      this.moduleEntryJobId,
      required this.menuKey,
      required this.menuRouterLink,
      required this.menuEntryJobId,
      this.loadingMsg,
      this.noRecordsMsg,
      this.modulePriority,
      this.moduleType});

  Data.fromJson(Map<String, dynamic> json) {
    restrictedRoles = json['Restricted_Roles'];
    module = json['MODULE'];
    moduleLabel = json['MODULE_LABEL']; // Corrected field name
    moduleValue = json['MODULE_VALUE'];
    moduleEntryJobId = json['MODULE_ENTRY_JOB_ID'];
    if (json['Menu_key'] is List) {
      menuKey =
          (json['Menu_key'] as List).map((e) => e?.toString() ?? '').toList();
    } else {
      menuKey = [];
    }

    // Handle type conversion for menuRouterLink
    if (json['Menu_router_link'] is List) {
      menuRouterLink = (json['Menu_router_link']as List).map((e) => e?.toString() ?? '').toList();
    } else {
      menuRouterLink = [];
    }

    // Handle type conversion for menuEntryJobId
    if (json['Menu_entry_JOB_ID'] is List) {
      menuEntryJobId = (json['Menu_entry_JOB_ID']as List).map((e) => e?.toString() ?? '').toList();
    } else {
      menuEntryJobId = [];
    }

    loadingMsg = json['LoadingMsg'];
    noRecordsMsg = json['No_Records_msg'];
    modulePriority = json['Module_Priority'];
    final dynamic moduleTypeJson = json['MODULE_TYPE'];
    moduleType = moduleTypeJson.toString();
  }
}
