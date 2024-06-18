class Status {
  String? jobTypeName;
  // List<Null>? subJobs;
  List<JobStatus>? jobStatus;
  String? jobTypeId;

  Status(
      {this.jobTypeName,
      //this.subJobs,
      this.jobStatus,
      this.jobTypeId});

  Status.fromJson(Map<String, dynamic> json) {
    jobTypeName = json['JobTypeName'];
    if (json['SubJobs'] != null) {
      //subJobs = new List<Null>();
      // json['SubJobs'].forEach((v) {
      //   subJobs!.add(new Null.fromJson(v));
      // });
    }
    if (json['jobStatus'] != null) {
      jobStatus = (json['jobStatus'] as List)
          .map((v) => JobStatus.fromJson(v as Map<String, dynamic>))
          .toList();
    }

    jobTypeId = json['jobTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['JobTypeName'] = this.jobTypeName;
    // if (this.subJobs != null) {
    //   data['SubJobs'] = this.subJobs!.map((v) => v.toJson()).toList();
    // }
    if (this.jobStatus != null) {
      data['jobStatus'] = this.jobStatus!.map((v) => v.toJson()).toList();
    }
    data['jobTypeId'] = this.jobTypeId;
    return data;
  }
}

class JobStatus {
  int? count;
  String? name;
  String? groupName;
  String? statusId;
  FieldAverage? fieldAverage;

  JobStatus(
      {this.count,
      this.name,
      this.groupName,
      this.statusId,
      this.fieldAverage});

  JobStatus.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    groupName = json['groupName'];
    statusId = json['statusId'];
    fieldAverage = json['fieldAverage'] != null
        ? new FieldAverage.fromJson(json['fieldAverage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    data['groupName'] = this.groupName;
    data['statusId'] = this.statusId;
    if (this.fieldAverage != null) {
      data['fieldAverage'] = this.fieldAverage!.toJson();
    }
    return data;
  }
}

class FieldAverage {
  EstimateOfLoss? estimateOfLoss;

  FieldAverage({this.estimateOfLoss});

  FieldAverage.fromJson(Map<String, dynamic> json) {
    estimateOfLoss = json['Estimate of Loss'] != null
        ? new EstimateOfLoss.fromJson(json['Estimate of Loss'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.estimateOfLoss != null) {
      data['Estimate of Loss'] = this.estimateOfLoss!.toJson();
    }
    return data;
  }
}

class EstimateOfLoss {
  String? total;
  String? average;

  EstimateOfLoss({this.total, this.average});

  EstimateOfLoss.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    average = json['average'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['average'] = this.average;
    return data;
  }
}
