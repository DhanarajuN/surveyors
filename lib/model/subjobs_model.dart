import 'dart:convert';

import 'package:Surveyors/data/local_store_helper.dart';

class AllJobsTypeList {
  String? status;
  Userdetails? userdetails;
  List<Org>? jobs;

  AllJobsTypeList({this.status, this.userdetails, this.jobs});

  AllJobsTypeList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userdetails = json['userdetails'] != null
        ? Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['orgs'] != null) {
      jobs = <Org>[];
      json['orgs'].forEach((v) {
        jobs!.add(Org.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (userdetails != null) {
      data['userdetails'] = userdetails!.toJson();
    }
    if (jobs != null) {
      data['orgs'] = jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Org {
  String? id;
  String? type;
  String? mallName;
  String? mallId;
  String? dt;
  bool? isSubJobType;
  List<Fields>? fields;

  Org(
      {this.id,
      this.type,
      this.mallName,
      this.mallId,
      this.isSubJobType,
      this.fields});
  Org.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    mallName = json['mallName'];
    mallId = json['mallId'];
    isSubJobType = json['isSubJobType'];
    dt = json['dt'];
    writeTheData('$type', 'dt');
    if (json['Fields'] != null) {
      fields = <Fields>[];
      json['Fields'].forEach((v) {
        if ((v['type'] != 'SubJob')) {
          fields!.add(Fields.fromJson(v));
        }
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['mallName'] = mallName;
    data['mallId'] = mallId;
    data['isSubJobType'] = isSubJobType;
    data['dt'] = dt;
    if (fields != null) {
      data['Fields'] = fields!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Fields {
  String? id;
  int? order;
  String? type;
  String? name;
  String? groupName;
  String? allowedValuesResults1;
  String? allowedValues;
  String? dependent;
  bool? mandatory;
  String? rule;
  var allowedValuesResults;
  late final RuleAllowedValues ruleAllowedValues;

  Fields(
      {this.id,
      this.type,
      this.name,
      this.groupName,
      this.allowedValuesResults1,
      this.allowedValues,
      this.rule,
      this.order,
      required this.ruleAllowedValues});

  Fields.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];

    name = json['name'];
    groupName = json['groupName'];
    allowedValuesResults = json['allowedValuesResults'];
    dependent = json['dependentFields'];
    allowedValues = json['allowedValues'];
    mandatory = json['mandatory'];
    rule = json['rule'];
    order=json['order'];
    if (rule!.isNotEmpty) {
      List<String> parts = rule!.split(":");
      if(parts.length>2){
      rule= parts[1];
      }else{
        rule='';
      }
    }
    if (json.containsKey('ruleAllowedValues')) {
      if(json['ruleAllowedValues']!=null){
      ruleAllowedValues = RuleAllowedValues.fromJson(json['ruleAllowedValues']);}
    } else {
      ruleAllowedValues = RuleAllowedValues();
    }

    // Parse the allowedValuesResults map

    // allowedValuesResults = json['allowedValuesResults'];

    // print('field11: $name');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['groupName'] = groupName;
    data['allowedValuesResults'] = allowedValuesResults;
    data['allowedValues'] = allowedValues;
    //data['ruleAllowedValues']=ruleAllowedValues.;
    if (this.ruleAllowedValues != null) {
      data['ruleAllowedValues'] = this.ruleAllowedValues.toJson();
    }
    data['dependentFields'] = dependent;
    data['mandatory'] = mandatory;
    data['rule'] = rule;
    data['order']=order;
    return data;
  }
}

class RuleAllowedValues {
  String? ruleType;
  String? ruleText;
  String? definedParams;
  RuleAllowedValues({this.ruleType, this.ruleText, this.definedParams});
  RuleAllowedValues.fromJson(Map<String, dynamic> json) {
    ruleType = json['ruleType'];
    ruleText = json['ruleText'];
    definedParams = json['definedParams'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ruleType'] = ruleType;
    data['ruleText'] = ruleText;
    data['definedParams'] = definedParams;
    return data;
  }
}

class Userdetails {
  String? id;
  String? fullname;
  String? email;
  String? subdomain;
  Userdetails({this.id, this.fullname, this.email, this.subdomain});
  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    subdomain = json['subdomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['subdomain'] = subdomain;
    return data;
  }
}
