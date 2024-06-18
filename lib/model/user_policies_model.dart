class UserPoliciesList {
  int? status;
  List<Jobs>? jobs;
  int? totalNumRecords;
  int? count;
  UserPoliciesList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        print('33333333333333${json['jobs']}');
        jobs!.add(Jobs.fromJson(v));
      });
    }
    totalNumRecords = json['totalNumRecords'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;

    data['totalNumRecords'] = totalNumRecords;
    data['count'] = count;

    return data;
  }
}

class MyPolicies {
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
  String? receipt;
  String? certificate;
  String? masterPolicy;
  String? renewalNotice;
  String? coInsurancePattern;
  String? policyNo;
  String? initiatorsEmail;
  String? policyStartDate;
  String? policyEndDate;
  String? policyCopy;
  String? yearRange;
  String? communicationHistory;
  String? sumInsured;
  String? premiumWithoutGST;
  String? brokerSMobileNo;
  String? policySubType;
  String? endorsement;
  String? quoteName;
  String? quoteURL;
  String? actions;
  String? brokerCode;
  String? insurer;
  String? totalPremium;
  String? emailID;
  String? claims;
  String? accountName;
  String? groupName;
  String? effectiveDate;
  String? brokerName;
  String? brokerSEmailID;
  String? policyType;
  String? policyDescription;
  String? premiumTranscationDate;
  String? documentRepository;
  String? modeOfPayment;
  String? previousPolicyNumberForRenewalOfPolicy;
  String? industry;
  String? installments;
  String? totalSuminsured;
  String? installmentDetails;
  String? totalInstallmentsPremium;
  String? allRiskLocations;
  String? premiumIncludingGST;
  String? employees;
  String? order;
  List<Null>? hrsOfOperation;
  List<Null>? attachments;
  AdditionalDetails? additionalDetails;
  List<JobComments>? jobComments;
  String? currentJobStatus;
  bool? statusBasedEditAccess;
  int? currentJobStatusId;
  String? nextSeqNos;
  List<CreatedSubJobs>? createdSubJobs;
  List<NextJobStatuses>? nextJobStatuses;
  String? insights;
  String? overallRating;
  String? totalReviews;
  List<Null>? favourites;
  int? favouritesCount;
  String? quote;
  String? agPolicyNo;
  List<Map<String, dynamic>> createdSubJobs1 = [];

  MyPolicies(
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
      this.receipt,
      this.certificate,
      this.masterPolicy,
      this.renewalNotice,
      this.coInsurancePattern,
      this.policyNo,
      this.initiatorsEmail,
      this.policyStartDate,
      this.policyEndDate,
      this.policyCopy,
      this.yearRange,
      this.communicationHistory,
      this.sumInsured,
      this.premiumWithoutGST,
      this.brokerSMobileNo,
      this.policySubType,
      this.endorsement,
      this.quoteName,
      this.quoteURL,
      this.actions,
      this.brokerCode,
      this.insurer,
      this.totalPremium,
      this.emailID,
      this.claims,
      this.accountName,
      this.groupName,
      this.effectiveDate,
      this.brokerName,
      this.brokerSEmailID,
      this.policyType,
      this.policyDescription,
      this.premiumTranscationDate,
      this.documentRepository,
      this.modeOfPayment,
      this.previousPolicyNumberForRenewalOfPolicy,
      this.industry,
      this.installments,
      this.totalSuminsured,
      this.installmentDetails,
      this.totalInstallmentsPremium,
      this.allRiskLocations,
      this.premiumIncludingGST,
      this.employees,
      this.hrsOfOperation,
      this.order,
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
      this.favourites,
      this.favouritesCount,
      required this.createdSubJobs1,
      this.agPolicyNo,
      this.quote});

  MyPolicies.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    itemCode = json['ItemCode'] ?? '-';
    createdOn = json['createdOn'] ?? '-';
    lastModifiedDate = json['lastModifiedDate'] ?? '-';
    createdById = json['createdById'] ?? '-';
    jobTypeId = json['jobTypeId'] ?? '-';
    jobTypeName = json['jobTypeName'] ?? '-';
    createdByFullName = json['createdByFullName'] ?? '-';
    publicURL = json['publicURL'] ?? '-';
    packageName = json['PackageName'] ?? '-';
    isparse = json['Isparse'] ?? '-';
    immutableType = json['ImmutableType'] ?? '-';
    receipt = json['receipt'] ?? '-';
    certificate = json['certificate'] ?? '-';
    masterPolicy = json['masterPolicy'] ?? '-';
    renewalNotice = json['renewalNotice'] ?? '-';
    coInsurancePattern = json['CoInsurance Pattern'] ?? '-';
    policyNo = json['Policy No'] ?? '-';
    initiatorsEmail = json['Initiators_email'] ?? '-';
    policyStartDate = json['Policy Start Date'] ?? '-';
    policyEndDate = json['Policy End Date'] ?? '-';
    policyCopy = json['Policy Copy'];
    yearRange = json['Policy To'] ?? '-';
    communicationHistory = json['Communication History'] ?? '-';
    sumInsured = json['Sum Insured'] ?? '-';
    premiumWithoutGST = json['Premium without GST'] ?? '-';
    brokerSMobileNo = json['Broker’s Mobile No.'] ?? '-';
    policySubType = json['Policy Sub Type'] ?? '-';

    endorsement = json['Endorsement'] ?? '-';
    quoteName = json['Quote_Name'] ?? '-';
    quoteURL = json['Quote_URL'] ?? '-';
    actions = json['Actions'] ?? '-';
    brokerCode = json['Broker Code'] ?? '-';
    insurer = json['Insurer'] ?? '-';
    totalPremium = json['Total Premium'] ?? '-';
    emailID = json['Email ID'] ?? '-';
    claims = json['Claims'] ?? '-';
    accountName = json['Account Name'] ?? '-';
    groupName = json['Group Name'] ?? '-';
    effectiveDate = json['Effective Date'] ?? '-';
    brokerName = json['Broker Name'] ?? '-';
    brokerSEmailID = json['Broker’s Email ID'] ?? '-';
    policyType = json['Policy Type'] ?? '-';
    policyDescription = json['Policy Description'] ?? '-';
    premiumTranscationDate = json['Premium Transcation Date'] ?? '-';
    documentRepository = json['Document Repository'] ?? '-';
    modeOfPayment = json['Mode of Payment'] ?? '-';
    previousPolicyNumberForRenewalOfPolicy =
        json['Previous Policy Number(For Renewal of Policy)'] ?? '-';
    industry = json['Industry'] ?? '-';
    installments = json['Installments'] ?? '-';
    totalSuminsured = json['Total Suminsured'] ?? '-';
    installmentDetails = json['Installment Details'] ?? '-';
    totalInstallmentsPremium = json['Total Installments Premium'] ?? '-';
    allRiskLocations = json['All Risk Locations'];
    premiumIncludingGST = json['Premium Including GST'] ?? '-';
    employees = json['Employees'] ?? '-';
    order = json['order'] ?? '-';
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
      jobComments = <JobComments>[];
      json['jobComments'].forEach((v) {
        jobComments!.add(new JobComments.fromJson(v));
      });
    }
    currentJobStatus = json['Current_Job_Status'];
    statusBasedEditAccess = json['Status_Based_EditAccess'];
    currentJobStatusId = json['Current_Job_StatusId'];
    nextSeqNos = json['Next_Seq_Nos'];
    if (json['CreatedSubJobs'] != null) {
      createdSubJobs = <CreatedSubJobs>[];
      json['CreatedSubJobs'].forEach((v) {
        createdSubJobs1.add(Map<String, dynamic>.from(v));
        createdSubJobs!.add(new CreatedSubJobs.fromJson(v));
      });
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

    if (json['favourites'] != null) {
      favourites = <Null>[];
      json['favourites'].forEach((v) {
        //favourites!.add(new Null.fromJson(v));
      });
    }
    favouritesCount = json['favouritesCount'];
    quote = json['Quote'];
    agPolicyNo = json['Insurer Policy No'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['ItemCode'] = itemCode;
    data['createdOn'] = createdOn;
    data['lastModifiedDate'] = lastModifiedDate;
    data['createdById'] = createdById;
    data['jobTypeId'] = jobTypeId;
    data['jobTypeName'] = jobTypeName;
    data['createdByFullName'] = createdByFullName;
    data['publicURL'] = publicURL;
    data['PackageName'] = packageName;
    data['Isparse'] = isparse;
    data['ImmutableType'] = immutableType;
    data['receipt'] = receipt;
    data['certificate'] = certificate;
    data['masterPolicy'] = masterPolicy;
    data['renewalNotice'] = renewalNotice;
    data['CoInsurance Pattern'] = coInsurancePattern;
    data['Policy No'] = policyNo;
    data['Initiators_email'] = initiatorsEmail;
    data['Policy Start Date'] = policyStartDate;
    data['Policy End Date'] = policyEndDate;
    data['Policy Copy_URL'] = policyCopy;
    data['Year Range'] = yearRange;
    data['Communication History'] = communicationHistory;
    data['Sum Insured'] = sumInsured;
    data['Premium without GST'] = premiumWithoutGST;
    data['Broker’s Mobile No.'] = brokerSMobileNo;
    data['Policy Sub Type'] = policySubType;
    data['Endorsement'] = endorsement;
    data['Quote_Name'] = quoteName;
    data['Quote_URL'] = quoteURL;
    data['Actions'] = actions;
    data['Broker Code'] = brokerCode;
    data['Insurer'] = insurer;
    data['Total Premium'] = totalPremium;
    data['Email ID'] = emailID;
    data['Claims'] = claims;
    data['Account Name'] = accountName;
    data['Group Name'] = groupName;
    data['Effective Date'] = effectiveDate;
    data['Broker Name'] = brokerName;
    data['Broker’s Email ID'] = brokerSEmailID;
    data['Policy Type'] = policyType;
    data['Policy Description'] = policyDescription;
    data['Premium Transcation Date'] = premiumTranscationDate;
    data['Document Repository'] = documentRepository;
    data['Mode of Payment'] = modeOfPayment;
    data['Previous Policy Number(For Renewal of Policy)'] =
        previousPolicyNumberForRenewalOfPolicy;
    data['Industry'] = industry;
    data['Installments'] = installments;
    data['Total Suminsured'] = totalSuminsured;
    data['Installment Details'] = installmentDetails;
    data['Total Installments Premium'] = totalInstallmentsPremium;
    data['All Risk Locations'] = allRiskLocations;
    data['Premium Including GST'] = premiumIncludingGST;
    data['Employees'] = employees;
    data['order'] = order;
    data['Insurer Policy No'] = agPolicyNo;
    if (hrsOfOperation != null) {
      data['hrsOfOperation'] = hrsOfOperation!
          .map((v) => ''
              //v.toJson()
              )
          .toList();
    }
    if (attachments != null) {
      data['Attachments'] = attachments!
          .map((v) => ''
              //v.toJson()
              )
          .toList();
    }
    if (additionalDetails != null) {
      data['Additional_Details'] = additionalDetails!.toJson();
    }
    if (jobComments != null) {
      data['jobComments'] = jobComments!.map((v) => v.toJson()).toList();
    }
    data['Current_Job_Status'] = currentJobStatus;
    data['Status_Based_EditAccess'] = statusBasedEditAccess;
    data['Current_Job_StatusId'] = currentJobStatusId;
    data['Next_Seq_Nos'] = nextSeqNos;
    if (createdSubJobs != null) {
      data['CreatedSubJobs'] = createdSubJobs!
          .map((v) => ''
              //v.toJson()
              )
          .toList();
    }
    if (nextJobStatuses != null) {
      data['Next_Job_Statuses'] =
          nextJobStatuses!.map((v) => v.toJson()).toList();
    }
    data['Insights'] = insights;
    data['overallRating'] = overallRating;
    data['totalReviews'] = totalReviews;

    if (favourites != null) {
      data['favourites'] = favourites!
          .map((v) => ''
              //v.toJson()
              )
          .toList();
    }
    data['favouritesCount'] = favouritesCount;
    data['Quote'] = quote;
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

class JobComments {
  String? commentId;
  String? postedById;
  String? postedByName;
  String? jobId;
  String? jobName;
  String? comment;
  String? time;
  String? disabled;
  String? logo;
  String? orgId;

  JobComments(
      {this.commentId,
      this.postedById,
      this.postedByName,
      this.jobId,
      this.jobName,
      this.comment,
      this.time,
      this.disabled,
      this.logo,
      this.orgId});

  JobComments.fromJson(Map<String, dynamic> json) {
    commentId = json['commentId'];
    postedById = json['postedBy_Id'];
    postedByName = json['postedBy_Name'];
    jobId = json['Job_Id'];
    jobName = json['Job_Name'];
    comment = json['comment'];
    time = json['time'];
    disabled = json['disabled'];
    logo = json['logo'];
    orgId = json['orgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentId'] = commentId;
    data['postedBy_Id'] = postedById;
    data['postedBy_Name'] = postedByName;
    data['Job_Id'] = jobId;
    data['Job_Name'] = jobName;
    data['comment'] = comment;
    data['time'] = time;
    data['disabled'] = disabled;
    data['logo'] = logo;
    data['orgId'] = orgId;
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
      json['Sub_Jobtype_Forms'].forEach((v) {
        // subJobtypeForms!.add(new Null.fromJson(v));
      });
    }
    if (json['Access_Roles'] != null) {
      accessRoles = <Null>[];
      json['Access_Roles'].forEach((v) {
        //accessRoles!.add(new Null.fromJson(v));
      });
    }
    ruleText = json['rule_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status_Id'] = statusId;
    data['SeqNo'] = seqNo;
    data['Status_Name'] = statusName;
    if (subJobtypeForms != null) {
      data['Sub_Jobtype_Forms'] = subJobtypeForms!
          .map((v) => ''
              //v.toJson()
              )
          .toList();
    }
    if (accessRoles != null) {
      data['Access_Roles'] = accessRoles!
          .map((v) => ''
              // v.toJson()
              )
          .toList();
    }
    data['rule_text'] = ruleText;
    return data;
  }
}

class Jobs {
  List<MyPolicies>? mypolicies;
  Jobs({this.mypolicies});
  Jobs.fromJson(Map<String, dynamic> json) {
    if (json['CreatedSubJobs'] != null) {
      print('22232323323${json['CreatedSubJobs']}');
      mypolicies = <MyPolicies>[];
      json['CreatedSubJobs'].forEach((v) {
        mypolicies!.add(MyPolicies.fromJson(v));
      });
    }
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
