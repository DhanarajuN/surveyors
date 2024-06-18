import 'package:Surveyors/data_model/job_model.dart';
class JobsData {
  String? status;
  Userdetails? userdetails;
  List<Jobs>? jobs;
  int? totalNumRecords;
  int? currentPageNumber;
  int? count;
  bool? showFields;
  bool? showInsights;
  bool? showStatuses;
  bool? showJTJobs;
  bool? showChatbotFields;
  int? averageRating;
  Null? parentJobs;

  JobsData({
     this.status,
    this.userdetails,
    this.jobs,
    this.totalNumRecords,
    this.currentPageNumber,
    this.count,
    this.showFields,
    this.showInsights,
    this.showStatuses,
    this.showJTJobs,
    this.showChatbotFields,
    this.averageRating,
    this.parentJobs,
  });

  JobsData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userdetails = json['userdetails'] != null ? Userdetails.fromJson(json['userdetails']) : null;
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs?.add(Jobs.fromJson(v));
      });
    }
    totalNumRecords = json['totalNumRecords'];
    currentPageNumber = json['currentPageNumber'];
    count = json['count'];
    showFields = json['showFields'];
    showInsights = json['showInsights'];
    showStatuses = json['showStatuses'];
    showJTJobs = json['showJTJobs'];
    showChatbotFields = json['showChatbotFields'];
    averageRating = json['averageRating'];
    parentJobs = json['parentJobs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (userdetails != null) {
      data['userdetails'] = userdetails?.toJson();
    }
    if (jobs != null) {
      data['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    data['totalNumRecords'] = totalNumRecords;
    data['currentPageNumber'] = currentPageNumber;
    data['count'] = count;
    data['showFields'] = showFields;
    data['showInsights'] = showInsights;
    data['showStatuses'] = showStatuses;
    data['showJTJobs'] = showJTJobs;
    data['showChatbotFields'] = showChatbotFields;
    data['averageRating'] = averageRating;
    data['parentJobs'] = parentJobs;
    return data;
  }
}

class Userdetails {
  String? id;
  String? fullname;
  String? email;
  String? website;
  String? subdomain;

  Userdetails({
    this.id,
    this.fullname,
    this.email,
    this.website,
    this.subdomain,
  });

  Userdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    website = json['website'];
    subdomain = json['subdomain'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['website'] = website;
    data['subdomain'] = subdomain;
    return data;
  }
}

class Jobs {
  String? id;
  String? itemCode;
  String? dateCreated;
  String? lastUpdated;
  dynamic? createdById;
  String? jobTypeId;
  String? jobTypeName;
  dynamic? parentJobInstanceId;
  String? createdByFullName;
  String? publicURL;
  String? categoryMall;
  dynamic? packageName;
  String? receipt;
  String? certificate;
  String? masterPolicy;
  String? renewalNotice;
  dynamic? additionalDetails;
  String? currentJobStatus;
  dynamic? currentJobStatusId;
  dynamic? currentGroupStatus;
  dynamic? currentGroupStatusId;
  String? nextSeqNos;
  String? insights;
  String? overallRating;
  String? totalReviews;
  Userdetails? malldetails;
  int? favouritesCount;
  List<dynamic>? hrsOfOperation;
  List<dynamic>? attachments;
  List<dynamic>? jobComments;
  List<dynamic>? createdSubJobs;
  List<NextJobStatuses>? nextJobStatuses;
  List<dynamic>? favourites;
  Data? data;
  dynamic? persistenceHookStatus;
  dynamic? v1OldJobInstanceId;

  Jobs({
    this.id,
    this.itemCode,
    this.dateCreated,
    this.lastUpdated,
    this.createdById,
    this.jobTypeId,
    this.jobTypeName,
    this.parentJobInstanceId,
    this.createdByFullName,
    this.publicURL,
    this.categoryMall,
    this.packageName,
    this.receipt,
    this.certificate,
    this.masterPolicy,
    this.renewalNotice,
    this.additionalDetails,
    this.currentJobStatus,
    this.currentJobStatusId,
    this.currentGroupStatus,
    this.currentGroupStatusId,
    this.nextSeqNos,
    this.insights,
    this.overallRating,
    this.totalReviews,
    this.malldetails,
    this.favouritesCount,
    this.hrsOfOperation,
    this.attachments,
    this.jobComments,
    this.createdSubJobs,
    this.nextJobStatuses,
    this.favourites,
    this.data,
    this.persistenceHookStatus,
    this.v1OldJobInstanceId,
  });

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['ItemCode'];
    dateCreated = json['dateCreated'];
    lastUpdated = json['lastUpdated'];
    createdById = json['createdById'];
    jobTypeId = json['jobTypeId'];
    jobTypeName = json['jobTypeName'];
    parentJobInstanceId = json['parentJobInstanceId'];
    createdByFullName = json['createdByFullName'];
    publicURL = json['publicURL'];
    categoryMall = json['Category_Mall'];
    packageName = json['PackageName'];
    receipt = json['receipt'];
    certificate = json['certificate'];
    masterPolicy = json['masterPolicy'];
    renewalNotice = json['renewalNotice'];
    additionalDetails = json['Additional_Details'];
    currentJobStatus = json['Current_Job_Status'];
    currentJobStatusId = json['Current_Job_StatusId'];
    currentGroupStatus = json['Current_Group_Status'];
    currentGroupStatusId = json['Current_Group_StatusId'];
    nextSeqNos = json['Next_Seq_Nos'];
    insights = json['Insights'];
    overallRating = json['overallRating'];
    totalReviews = json['totalReviews'];
    malldetails = json['malldetails'] != null ? Userdetails.fromJson(json['malldetails']) : null;
    favouritesCount = json['favouritesCount'];
    if (json['hrsOfOperation'] != null) {
      hrsOfOperation = <dynamic>[];
      json['hrsOfOperation'].forEach((v) {
        hrsOfOperation?.add(v);
      });
    }
    if (json['Attachments'] != null) {
      attachments = <dynamic>[];
      json['Attachments'].forEach((v) {
        attachments?.add(v);
      });
    }
    if (json['jobComments'] != null) {
      jobComments = <dynamic>[];
      json['jobComments'].forEach((v) {
        jobComments?.add(v);
      });
    }
    if (json['CreatedSubJobs'] != null) {
      createdSubJobs = <dynamic>[];
      json['CreatedSubJobs'].forEach((v) {
        createdSubJobs?.add(v);
      });
    }
    if (json['Next_Job_Statuses'] != null) {
      nextJobStatuses = <NextJobStatuses>[];
      json['Next_Job_Statuses'].forEach((v) {
        nextJobStatuses?.add(NextJobStatuses.fromJson(v));
      });
    }
    if (json['favourites'] != null) {
      favourites = <dynamic>[];
      json['favourites'].forEach((v) {
        favourites?.add(v);
      });
    }
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    persistenceHookStatus = json['persistenceHookStatus'];
    v1OldJobInstanceId = json['v1OldJobInstanceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ItemCode'] = itemCode;
    data['dateCreated'] = dateCreated;
    data['lastUpdated'] = lastUpdated;
    data['createdById'] = createdById;
    data['jobTypeId'] = jobTypeId;
    data['jobTypeName'] = jobTypeName;
    data['parentJobInstanceId'] = parentJobInstanceId;
    data['createdByFullName'] = createdByFullName;
    data['publicURL'] = publicURL;
    data['Category_Mall'] = categoryMall;
    data['PackageName'] = packageName;
    data['receipt'] = receipt;
    data['certificate'] = certificate;
    data['masterPolicy'] = masterPolicy;
    data['renewalNotice'] = renewalNotice;
    data['Additional_Details'] = additionalDetails;
    data['Current_Job_Status'] = currentJobStatus;
    data['Current_Job_StatusId'] = currentJobStatusId;
    data['Current_Group_Status'] = currentGroupStatus;
    data['Current_Group_StatusId'] = currentGroupStatusId;
    data['Next_Seq_Nos'] = nextSeqNos;
    data['Insights'] = insights;
    data['overallRating'] = overallRating;
    data['totalReviews'] = totalReviews;
    if (malldetails != null) {
      data['malldetails'] = malldetails?.toJson();
    }
    data['favouritesCount'] = favouritesCount;
    if (hrsOfOperation != null) {
      data['hrsOfOperation'] = hrsOfOperation;
    }
    if (attachments != null) {
      data['Attachments'] = attachments;
    }
    if (jobComments != null) {
      data['jobComments'] = jobComments;
    }
    if (createdSubJobs != null) {
      data['CreatedSubJobs'] = createdSubJobs;
    }
    if (nextJobStatuses != null) {
      data['Next_Job_Statuses'] = nextJobStatuses?.map((v) => v.toJson()).toList();
    }
    if (favourites != null) {
      data['favourites'] = favourites;
    }
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    data['persistenceHookStatus'] = this.persistenceHookStatus;
    data['v1OldJobInstanceId'] = this.v1OldJobInstanceId;
    return data;
  }
}

class NextJobStatuses {
  int? sequenceNo;
  dynamic? primaryStatus;
  String? secondaryStatus;
  dynamic? roles;
  dynamic? subJobType;

  NextJobStatuses({
    this.sequenceNo,
    this.primaryStatus,
    this.secondaryStatus,
    this.roles,
    this.subJobType,
  });

  NextJobStatuses.fromJson(Map<String, dynamic> json) {
    sequenceNo = json['sequenceNo'];
    primaryStatus = json['primaryStatus'];
    secondaryStatus = json['secondaryStatus'];
    roles = json['roles'];
    subJobType = json['subJobType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sequenceNo'] = sequenceNo;
    data['primaryStatus'] = primaryStatus;
    data['secondaryStatus'] = secondaryStatus;
    data['roles'] = roles;
    data['subJobType'] = subJobType;
    return data;
  }
}

class Data {
  String? indSLANo;
  String? indSlaNoBapFormat;
  String? indSurveyorName;
  String? crop;
  String? engineering;
  String? fire;
  String? lOP;
  String? marineCargo;
  String? marinehull;
  String? mISC;
  String? motor;
  String? licenseEffectiveDate;
  String? licenseExpiryDate;
  String? addressLine1;
  String? addressLine2;
  String? addressLine3;
  String? cityName;
  String? districtName;
  String? stateName;
  String? addressPIN;
  String? mobileNumber;
  String? emailAddress;
  String? iIISLAMembershipNo;

  Data({
    this.indSLANo,
    this.indSlaNoBapFormat,
    this.indSurveyorName,
    this.crop,
    this.engineering,
    this.fire,
    this.lOP,
    this.marineCargo,
    this.marinehull,
    this.mISC,
    this.motor,
    this.licenseEffectiveDate,
    this.licenseExpiryDate,
    this.addressLine1,
    this.addressLine2,
    this.addressLine3,
    this.cityName,
    this.districtName,
    this.stateName,
    this.addressPIN,
    this.mobileNumber,
    this.emailAddress,
    this.iIISLAMembershipNo,
  });

  Data.fromJson(Map<String, dynamic> json) {
    indSLANo = json['Ind SLA No'];
    indSlaNoBapFormat = json['Ind Sla No Bap Format'];
    indSurveyorName = json['Ind Surveyor Name'];
    crop = json['Crop'];
    engineering = json['Engineering'];
    fire = json['Fire'];
    lOP = json['LOP'];
    marineCargo = json['Marine Cargo'];
    marinehull = json['Marinehull'];
    mISC = json['MISC'];
    motor = json['Motor'];
    licenseEffectiveDate = json['License Effective Date'];
    licenseExpiryDate = json['License Expiry Date'];
    addressLine1 = json['Address Line 1'];
    addressLine2 = json['Address Line 2'];
    addressLine3 = json['Address Line 3'];
    cityName = json['City Name'];
    districtName = json['District Name'];
    stateName = json['State Name'];
    addressPIN = json['Address PIN'];
    mobileNumber = json['Mobile Number'];
    emailAddress = json['Email Address'];
    iIISLAMembershipNo = json['IIISLA Membership No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Ind SLA No'] = indSLANo;
    data['Ind Sla No Bap Format'] = indSlaNoBapFormat;
    data['Ind Surveyor Name'] = indSurveyorName;
    data['Crop'] = crop;
    data['Engineering'] = engineering;
    data['Fire'] = fire;
    data['LOP'] = lOP;
    data['Marine Cargo'] = marineCargo;
    data['Marinehull'] = marinehull;
    data['MISC'] = mISC;
    data['Motor'] = motor;
    data['License Effective Date'] = licenseEffectiveDate;
    data['License Expiry Date'] = licenseExpiryDate;
    data['Address Line 1'] = addressLine1;
    data['Address Line 2'] = addressLine2;
    data['Address Line 3'] = addressLine3;
    data['City Name'] = cityName;
    data['District Name'] = districtName;
    data['State Name'] = stateName;
    data['Address PIN'] = addressPIN;
    data['Mobile Number'] = mobileNumber;
    data['Email Address'] = emailAddress;
    data['IIISLA Membership No'] = iIISLAMembershipNo;
    return data;
  }
}
