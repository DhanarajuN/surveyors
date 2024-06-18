class RecommendedPolicies {
  int? status;
  Userdetails? userdetails;
  List<RecommendedPoliciesJobs>? jobs;
  int? totalNumRecords;
  int? count;
  bool? showFields;
  bool? showInsights;
  bool? showStatuses;
  bool? showJTJobs;
  bool? showChatbotFields;
  double? averageRating;

  RecommendedPolicies(
      {this.status,
      this.userdetails,
      this.jobs,
      this.totalNumRecords,
      this.count,
      this.showFields,
      this.showInsights,
      this.showStatuses,
      this.showJTJobs,
      this.showChatbotFields,
      this.averageRating});

  RecommendedPolicies.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userdetails = json['userdetails'] != null
        ? new Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['jobs'] != null) {
      jobs = <RecommendedPoliciesJobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new RecommendedPoliciesJobs.fromJson(v));
      });
    }
    totalNumRecords = json['totalNumRecords'];
    count = json['count'];
    showFields = json['showFields'];
    showInsights = json['showInsights'];
    showStatuses = json['showStatuses'];
    showJTJobs = json['showJTJobs'];
    showChatbotFields = json['showChatbotFields'];
    averageRating = json['averageRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.toJson();
    }
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    data['totalNumRecords'] = this.totalNumRecords;
    data['count'] = this.count;
    data['showFields'] = this.showFields;
    data['showInsights'] = this.showInsights;
    data['showStatuses'] = this.showStatuses;
    data['showJTJobs'] = this.showJTJobs;
    data['showChatbotFields'] = this.showChatbotFields;
    data['averageRating'] = this.averageRating;
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
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['subdomain'] = this.subdomain;
    return data;
  }
}

class RecommendedPoliciesJobs {
  int? id;
  String? itemCode;
  String? createdOn;
  String? lastModifiedDate;
  int? createdById;
  int? jobTypeId;
  String? jobTypeName;
  String? createdByFullName;
  String? publicURL;
  String? categoryMall;
  String? packageName;
  bool? isparse;
  String? immutableType;
  String? policyType;
  String? iconForSiteName;
  String? iconForSiteURL;
  String? linkId;
  String? internalName;
  String? rFQTemplate;
  String? order;
  String? policySubType;
  String? description;
  String? tag;
  String? premium;
  List<Null>? hrsOfOperation;
  List<Null>? attachments;
  AdditionalDetails? additionalDetails;
  List<Null>? jobComments;
  String? currentJobStatus;
  bool? statusBasedEditAccess;
  int? currentJobStatusId;
  String? nextSeqNos;
  List<Null>? createdSubJobs;
  List<NextJobStatuses>? nextJobStatuses;
  String? insights;
  String? overallRating;
  String? totalReviews;
  String? sumInsured;
  String? roomRentLimit;
  String? iCURentLimit;
  String? waitPeriod;
  String? covid;

  Userdetails? malldetails;
  List<Null>? favourites;
  int? favouritesCount;
  String? variantName;

  RecommendedPoliciesJobs(
      {this.id,
      this.itemCode,
      this.createdOn,
      this.lastModifiedDate,
      this.createdById,
      this.jobTypeId,
      this.jobTypeName,
      this.createdByFullName,
      this.publicURL,
      this.categoryMall,
      this.packageName,
      this.isparse,
      this.immutableType,
      this.policyType,
      this.iconForSiteName,
      this.iconForSiteURL,
      this.linkId,
      this.internalName,
      this.rFQTemplate,
      this.order,
      this.premium,
      this.tag,
      this.description,
      this.hrsOfOperation,
      this.attachments,
      this.additionalDetails,
      this.jobComments,
      this.currentJobStatus,
      this.statusBasedEditAccess,
      this.currentJobStatusId,
      this.nextSeqNos,
      this.createdSubJobs,
      this.nextJobStatuses,
      this.insights,
      this.overallRating,
      this.totalReviews,
      this.malldetails,
      this.favourites,
      this.sumInsured,
      this.favouritesCount,
      this.roomRentLimit,
      this.iCURentLimit,
      this.waitPeriod,
      this.covid,
      this.variantName});

  RecommendedPoliciesJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['ItemCode'];
    createdOn = json['createdOn'];
    lastModifiedDate = json['lastModifiedDate'];
    createdById = json['createdById'];
    jobTypeId = json['jobTypeId'];
    jobTypeName = json['jobTypeName'];
    createdByFullName = json['createdByFullName'];
    publicURL = json['publicURL'];
    categoryMall = json['Category_Mall'];
    packageName = json['PackageName'];
    isparse = json['Isparse'];
    immutableType = json['ImmutableType'];
    policyType = json['Policy Type'];
    iconForSiteName = json['icon for site_Name'];
    iconForSiteURL = json['icon for site_URL'];
    internalName = json['Policy Type'];
    rFQTemplate = json['RFQTemplate'];
    order = json['order'];
    policySubType = json['Policy Sub Type'];
    description = json['Desription'];
    premium = json['Total Premium'];
    tag = json['Tag'];
    sumInsured = json['Sum Insured'];
    variantName = json['Name'];
    roomRentLimit = json['Normal Room Rent Limit'];
    iCURentLimit = json['ICU Rent Limit'];
    waitPeriod = json['Wait Period'];
    covid = json['Covid-19 Hospitalisation'];
    if (json['hrsOfOperation'] != null) {
      hrsOfOperation = <Null>[];
      //json['hrsOfOperation'].forEach((v) { hrsOfOperation!.add(new Null.fromJson(v)); });
    }
    if (json['Attachments'] != null) {
      attachments = <Null>[];
      //json['Attachments'].forEach((v) { attachments!.add(new Null.fromJson(v)); });
    }
    additionalDetails = json['Additional_Details'] != null
        ? new AdditionalDetails.fromJson(json['Additional_Details'])
        : null;
    if (json['jobComments'] != null) {
      jobComments = <Null>[];
      //json['jobComments'].forEach((v) { jobComments!.add(new Null.fromJson(v)); });
    }
    currentJobStatus = json['Current_Job_Status'];
    statusBasedEditAccess = json['Status_Based_EditAccess'];
    currentJobStatusId = json['Current_Job_StatusId'];
    nextSeqNos = json['Next_Seq_Nos'];
    if (json['CreatedSubJobs'] != null) {
      createdSubJobs = <Null>[];
      //json['CreatedSubJobs'].forEach((v) { createdSubJobs!.add(new Null.fromJson(v)); });
    }
    if (json['Next_Job_Statuses'] != null) {
      nextJobStatuses = <NextJobStatuses>[];
      json['Next_Job_Statuses'].forEach((v) {
        nextJobStatuses!.add(new NextJobStatuses.fromJson(v));
      });
    }
    insights = json['Insights'];
    overallRating = json['overallRating'];
    totalReviews = json['totalReviews'];
    malldetails = json['malldetails'] != null
        ? new Userdetails.fromJson(json['malldetails'])
        : null;
    if (json['favourites'] != null) {
      favourites = <Null>[];
      //json['favourites'].forEach((v) { favourites!.add(new Null.fromJson(v)); });
    }
    favouritesCount = json['favouritesCount'];
    print('name:$variantName');
        print('ps:$policySubType');

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ItemCode'] = this.itemCode;
    data['createdOn'] = this.createdOn;
    data['lastModifiedDate'] = this.lastModifiedDate;
    data['createdById'] = this.createdById;
    data['jobTypeId'] = this.jobTypeId;
    data['jobTypeName'] = this.jobTypeName;
    data['createdByFullName'] = this.createdByFullName;
    data['publicURL'] = this.publicURL;
    data['Category_Mall'] = this.categoryMall;
    data['PackageName'] = this.packageName;
    data['Isparse'] = this.isparse;
    data['ImmutableType'] = this.immutableType;
    data['Name'] = this.policyType;
    data['icon for site_Name'] = this.iconForSiteName;
    data['icon for site_URL'] = this.iconForSiteURL;
    data['Internal Name'] = this.internalName;
    data['RFQTemplate'] = this.rFQTemplate;
    data['order'] = order;
    data['Policy Sub Type'] = policySubType;
    data['Desription'] = description;
    data['Sum Insured']=sumInsured;
    data['Policy Type']=policyType;
    data['Total Premium']=premium;
    if (this.hrsOfOperation != null) {
      // data['hrsOfOperation'] = this.hrsOfOperation!.map((v) => v.toJson()).toList();
    }
    if (this.attachments != null) {
      // data['Attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.additionalDetails != null) {
      data['Additional_Details'] = this.additionalDetails!.toJson();
    }
    if (this.jobComments != null) {
      //data['jobComments'] = this.jobComments!.map((v) => v.toJson()).toList();
    }
    data['Current_Job_Status'] = this.currentJobStatus;
    data['Status_Based_EditAccess'] = this.statusBasedEditAccess;
    data['Current_Job_StatusId'] = this.currentJobStatusId;
    data['Next_Seq_Nos'] = this.nextSeqNos;
    if (this.createdSubJobs != null) {
      //data['CreatedSubJobs'] = this.createdSubJobs!.map((v) => v.toJson()).toList();
    }
    if (this.nextJobStatuses != null) {
      data['Next_Job_Statuses'] =
          this.nextJobStatuses!.map((v) => v.toJson()).toList();
    }
    data['Insights'] = this.insights;
    data['overallRating'] = this.overallRating;
    data['totalReviews'] = this.totalReviews;
    if (this.malldetails != null) {
      data['malldetails'] = this.malldetails!.toJson();
    }
    if (this.favourites != null) {
      //data['favourites'] = this.favourites!.map((v) => v.toJson()).toList();
    }
    data['favouritesCount'] = this.favouritesCount;
    return data;
  }
}

class AdditionalDetails {
  //AdditionalDetails({});

  AdditionalDetails.fromJson(Map<String, dynamic> json) {}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    return data;
  }
}

class NextJobStatuses {
  String? statusId;
  String? seqNo;
  String? statusName;
  List<Null>? subJobtypeForms;
  List<Null>? accessRoles;
  String? ruleText;

  NextJobStatuses(
      {this.statusId,
      this.seqNo,
      this.statusName,
      this.subJobtypeForms,
      this.accessRoles,
      this.ruleText});

  NextJobStatuses.fromJson(Map<String, dynamic> json) {
    statusId = json['Status_Id'];
    seqNo = json['SeqNo'];
    statusName = json['Status_Name'];
    if (json['Sub_Jobtype_Forms'] != null) {
      subJobtypeForms = <Null>[];
      //json['Sub_Jobtype_Forms'].forEach((v) { subJobtypeForms!.add(new Null.fromJson(v)); });
    }
    if (json['Access_Roles'] != null) {
      accessRoles = <Null>[];
      //json['Access_Roles'].forEach((v) { accessRoles!.add(new Null.fromJson(v)); });
    }
    ruleText = json['rule_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_Id'] = this.statusId;
    data['SeqNo'] = this.seqNo;
    data['Status_Name'] = this.statusName;
    if (this.subJobtypeForms != null) {
      //data['Sub_Jobtype_Forms'] = this.subJobtypeForms!.map((v) => v.toJson()).toList();
    }
    if (this.accessRoles != null) {
      //data['Access_Roles'] = this.accessRoles!.map((v) => v.toJson()).toList();
    }
    data['rule_text'] = this.ruleText;
    return data;
  }
}
