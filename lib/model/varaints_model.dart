class VariantModel {
  int? status;
  List<VariantJob>? jobs;
  int? totalNumRecords;
  int? count;
  bool? showFields;
  bool? showInsights;
  bool? showStatuses;
  bool? showJTJobs;
  bool? showChatbotFields;
  double? averageRating;

  VariantModel(
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

  VariantModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <VariantJob>[];
      json['jobs'].forEach((v) {
        jobs!.add(new VariantJob.fromJson(v));
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

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;

  //   if (this.jobs != null) {
  //     data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
  //   }
  //   data['totalNumRecords'] = this.totalNumRecords;
  //   data['count'] = this.count;
  //   data['showFields'] = this.showFields;
  //   data['showInsights'] = this.showInsights;
  //   data['showStatuses'] = this.showStatuses;
  //   data['showJTJobs'] = this.showJTJobs;
  //   data['showChatbotFields'] = this.showChatbotFields;
  //   data['averageRating'] = this.averageRating;
  //   return data;
  // }
}

class VariantJob {
  int? id;
  String? itemCode;
  String? createdOn;
  String? lastModifiedDate;
  int? createdById;
  int? jobTypeId;
  String? jobTypeName;
  String? createdByFullName;
  String? publicURL;
  String? packageName;
  bool? isparse;
  String? immutableType;

  String? internalName;
  String? rFQTemplate;
  String? emailOfUser;
  String? distributionType;
  String? agentName;
  String? agentEmail;
  String? accountName;
  String? company;
  String? emailId;
  String? website;
  String? groupName;
  String? sumInsured;
  String? totalPremium;
  String? policyType;
  String? policySubType;
  List<Null>? hrsOfOperation;
  List<Null>? attachments;
  AdditionalDetails? additionalDetails;
  String? currentJobStatus;
  bool? statusBasedEditAccess;
  int? currentJobStatusId;
  String? nextSeqNos;
  List<NextJobStatuses>? nextJobStatuses;
  String? insights;
  String? overallRating;
  String? totalReviews;
  List<Null>? favourites;
  int? favouritesCount;
  String? quote;
  List<CreatedSubJobs>? createdSubJobs;
  List<Map<String, dynamic>> createdSubJobs1 = [];

  VariantJob(
      {this.id,
      this.itemCode,
      this.createdOn,
      this.lastModifiedDate,
      this.createdById,
      this.jobTypeId,
      this.jobTypeName,
      this.createdByFullName,
      this.publicURL,
      this.packageName,
      this.isparse,
      this.immutableType,
      this.internalName,
      this.rFQTemplate,
      this.emailOfUser,
      this.distributionType,
      this.agentName,
      this.agentEmail,
      this.accountName,
      this.company,
      this.emailId,
      this.website,
      this.groupName,
      this.sumInsured,
      this.totalPremium,
      this.policySubType,
      this.policyType,
      this.hrsOfOperation,
      this.attachments,
      this.additionalDetails,
      this.currentJobStatus,
      this.statusBasedEditAccess,
      this.currentJobStatusId,
      this.nextSeqNos,
      this.nextJobStatuses,
      this.insights,
      this.overallRating,
      this.totalReviews,
      this.favourites,
      this.favouritesCount,
      this.quote,
      this.createdSubJobs});

  VariantJob.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['ItemCode'];
    createdOn = json['createdOn'];
    lastModifiedDate = json['lastModifiedDate'];
    createdById = json['createdById'];
    jobTypeId = json['jobTypeId'];
    jobTypeName = json['jobTypeName'];
    createdByFullName = json['createdByFullName'];
    publicURL = json['publicURL'];
    packageName = json['PackageName'];
    isparse = json['Isparse'];
    immutableType = json['ImmutableType'];
    internalName = json['Internal Name'];
    rFQTemplate = json['RFQTemplate'];
    emailOfUser = json['Email of User'];
    distributionType = json['DistributionType'];
    agentName = json['Agent Name'];
    agentEmail = json['Agent Email'];
    accountName = json['Account Name'];
    company = json['Company'];
    emailId = json['EmailId'];
    website = json['Website'];
    groupName = json['Group Name'];
    sumInsured = json['Sum Insured'];
    totalPremium = json['Total Premium'];
    policyType = json['Policy Type'];
    policySubType = json['Policy Sub Type'];
    if (json['CreatedSubJobs'] != null) {
      createdSubJobs = <CreatedSubJobs>[];
      json['CreatedSubJobs'].forEach((v) {
        createdSubJobs1.add(Map<String, dynamic>.from(v));
        createdSubJobs!.add(new CreatedSubJobs.fromJson(v));
      });
    }
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

    currentJobStatus = json['Current_Job_Status'];
    statusBasedEditAccess = json['Status_Based_EditAccess'];
    currentJobStatusId = json['Current_Job_StatusId'];
    nextSeqNos = json['Next_Seq_Nos'];

    if (json['Next_Job_Statuses'] != null) {
      nextJobStatuses = <NextJobStatuses>[];
      json['Next_Job_Statuses'].forEach((v) {
        nextJobStatuses!.add(new NextJobStatuses.fromJson(v));
      });
    }
    insights = json['Insights'];
    overallRating = json['overallRating'];
    totalReviews = json['totalReviews'];

    if (json['favourites'] != null) {
      favourites = <Null>[];
      json['favourites'].forEach((v) {
        //favourites!.add(new Null.fromJson(v));
      });
    }
    favouritesCount = json['favouritesCount'];
    quote = json['Quote'];
  }
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['ItemCode'] = itemCode;
    _data['createdOn'] = createdOn;
    _data['lastModifiedDate'] = lastModifiedDate;
    _data['createdById'] = createdById;
    _data['jobTypeId'] = jobTypeId;
    _data['jobTypeName'] = jobTypeName;
    _data['createdByFullName'] = createdByFullName;
    _data['publicURL'] = publicURL;
    _data['PackageName'] = packageName;
    _data['Isparse'] = isparse;
    _data['ImmutableType'] = immutableType;
    _data['Internal Name'] = internalName;
    _data['RFQTemplate'] = rFQTemplate;
    _data['Email of User'] = emailOfUser;
    _data['DistributionType'] = distributionType;
    _data['Agent Name'] = agentName;
    _data['Agent Email'] = agentEmail;
    _data['Account Name'] = accountName;
    _data['Company'] = company;
    _data['EmailId'] = emailId;
    _data['Website'] = website;
    _data['Group Name'] = groupName;
    _data['Sum Insured'] = sumInsured;
    _data['Total Premium'] = totalPremium;
    _data['Policy Type'] = policyType;
    _data['Policy Sub Type'] = policySubType;
    _data['hrsOfOperation'] = hrsOfOperation;
    _data['Attachments'] = attachments;
    //  _data['Additional_Details'] = AdditionalDetails.toJson();
    //   _data['jobComments'] = jobComments;
    _data['Current_Job_Status'] = currentJobStatus;
    _data['Status_Based_EditAccess'] = statusBasedEditAccess;
    _data['Current_Job_StatusId'] = currentJobStatusId;
    _data['Next_Seq_Nos'] = nextSeqNos;
    //  _data['CreatedSubJobs'] = createdSubJobs;
    //_data['Next_Job_Statuses'] = NextJobStatuses.map((e)=>e.toJson()).toList();
    _data['Insights'] = insights;
    _data['overallRating'] = overallRating;
    _data['totalReviews'] = totalReviews;
    //  _data['malldetails'] = malldetails.toJson();
    _data['favourites'] = favourites;
    _data['favouritesCount'] = favouritesCount;
    return _data;
  }
}

class CreatedSubJobs {
  int? id;
  String? jobtype;
  CreatedSubJobs(this.id, this.jobtype);
  CreatedSubJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobtype = json['jobTypeName'];
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
