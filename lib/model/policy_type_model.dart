class PolicyTypes {
  int? status;
  List<Policies>? jobs;
  int? totalNumRecords;
  int? count;
  bool? showFields;
  bool? showInsights;
  bool? showStatuses;
  bool? showJTJobs;
  bool? showChatbotFields;
  double? averageRating;

  PolicyTypes(
      {this.status,
      this.jobs,
      this.totalNumRecords,
      this.count,
      this.showFields,
      this.showInsights,
      this.showStatuses,
      this.showJTJobs,
      this.showChatbotFields,
      this.averageRating});

  PolicyTypes.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <Policies>[];
      json['jobs'].forEach((v) {
        jobs!.add(Policies.fromJson(v));
      });
    }
  }
}

class Policies {
  int? id;
  int? jobTypeId;
  String? jobTypeName;
  String? policyType;
  String? policySubType;
  String? premium;
  String? sumInsured;
  String? desription;
  String? order;
  String? tag;

  Policies(
      {this.id,
      this.jobTypeId,
      this.jobTypeName,
      this.policyType,
      this.desription,
      this.order,
      this.premium,
      this.sumInsured,
      this.policySubType,
      this.tag});

  Policies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobTypeId = json['jobTypeId'];
    jobTypeName = json['jobTypeName'];
    policyType = json['Policy Type'];
    desription = json['Desription'];
    premium = json['Premium'];
    sumInsured = json['Sum Insured'];
    policySubType = json['Policy SubType'];
    order = json['order'];
    tag = json['Tag'];
  }
}
