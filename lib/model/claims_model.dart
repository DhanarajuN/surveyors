class ClaimsModel {
  int? status;
  Userdetails? userdetails;
  List<MyClaims>? jobs;
  ClaimsModel({this.status, this.userdetails, this.jobs});
  ClaimsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userdetails = json['userdetails'] != null
        ? new Userdetails.fromJson(json['userdetails'])
        : null;
    if (json['jobs'] != null) {
      jobs = <MyClaims>[];
      json['jobs'].forEach((v) {
        jobs!.add(new MyClaims.fromJson(v));
      });
    }
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

class MyClaims {
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
	String? dateOfIntimation;
	String? initiatorsName;
	String? initiatorsDivision;
	String? initiatorsEmail;
	String? policyYear;
	String? initiatorsBU;
	String? policyNo;
	String? policyType;
	String? lossDescription;
	String? contactPersonsMobileNo;
	String? claimNo;
	String? surveyOrganizerEmail;
	String? tATForIntimation;
	List<Null>? attachments;
	String? onAccountPaymentDetails;
	List<String>? additionalInformation;
	String? contactPersonsNameToOrganiseSurvey;
	String? tATForConsent;
	String? profitCenter;
	List<String>? probableCauseOfDamage;
	String? tATForSurveyorAppointment;
	String? totalOnAccountPayment;
	String? tATForPayment;
	String? tATForAssessment;
	String? documentRepository;
	String? estimateOfLossInINR;
	String? pendingWith;
	String? dateOfOccurrence;
	String? additionalClaimCoordinatorSEmailID;
	String? insurerName;
	String? policySubtype;
	String? claimType;
	String? communicationHistory;
	String? claimReferenceNumber;
	String? state;
	String? intimationAmount;
	String? assetDescription;
	String? tATForDocumentSubmission;
	String? bASUName;
	String? materialCargoDescription;
	String? briefDetailsOfLoss;
	String? consignmentQty;
	String? estimatedLossQtyReported;
	String? salvageRateApprovedRsBag;
	String? modeOfTransit;
	String? consignmentValue;
	String? consignmentValueRs;
	String? approvedLossQuantityJIRNosBags;
	String? claimClosureRemarks;
	String? lossLocationArea;
	String? storeServiceCenterGodownVendorLocationCode;
	String? region;
	String? matCost;
	String? bLAWBLRNoConsignmentNoteNo;
	String? bLAWBLRConsignmentNoteDate;
	String? statusOfTheClaim;
	String? motor1;
	String? motor2;
	String? motor3;
	String? engineering1;
	String? engineering2;
	String? motor4;
	String? aging;
	String? engineering3;
	String? motor5;
	String? engineering4;
	String? invoicePONumber;
	String? accountName;
	String? groupName;
	String? invoicePODate;
	String? emailId;
	String? invoiceValuePOValue;
	String? country;
	String? tATForLOR;
	String? currencyType;
	String? uSD;
	String? bACodeSourceSupplyingPlant;
	List<String>? hrsOfOperation;
	AdditionalDetails? additionalDetails;
	List<String>? jobComments;
	String? currentJobStatus;
	bool? statusBasedEditAccess;
	int? currentJobStatusId;
	String? nextSeqNos;
  List<CreatedSubJobs>? createdSubJobs;
	List<NextJobStatuses>? nextJobStatuses;
	String? insights;
	String? overallRating;
	String? totalReviews;
	Malldetails? malldetails;
	List<String>? favourites;
	int? favouritesCount;

  MyClaims({
   this.id, this.itemCode, this.createdOn, this.lastModifiedDate, this.createdById, this.jobTypeId, this.jobTypeName, this.createdByFullName, this.publicURL, this.packageName, this.isparse, this.immutableType, this.dateOfIntimation, this.initiatorsName, this.initiatorsDivision, this.initiatorsEmail, this.policyYear, this.initiatorsBU, this.policyNo, this.policyType, this.lossDescription, this.contactPersonsMobileNo, this.claimNo, this.surveyOrganizerEmail, this.tATForIntimation, this.attachments, this.onAccountPaymentDetails, this.additionalInformation, this.contactPersonsNameToOrganiseSurvey, this.tATForConsent, this.profitCenter, this.probableCauseOfDamage, this.tATForSurveyorAppointment, this.totalOnAccountPayment, this.tATForPayment, this.tATForAssessment, this.documentRepository, this.estimateOfLossInINR, this.pendingWith, this.dateOfOccurrence, this.additionalClaimCoordinatorSEmailID, this.insurerName, this.policySubtype, this.claimType, this.communicationHistory, this.claimReferenceNumber, this.state, this.intimationAmount, this.assetDescription, this.tATForDocumentSubmission, this.bASUName, this.materialCargoDescription, this.briefDetailsOfLoss, this.consignmentQty, this.estimatedLossQtyReported, this.salvageRateApprovedRsBag, this.modeOfTransit, this.consignmentValue, this.consignmentValueRs, this.approvedLossQuantityJIRNosBags, this.claimClosureRemarks, this.lossLocationArea, this.storeServiceCenterGodownVendorLocationCode, this.region, this.matCost, this.bLAWBLRNoConsignmentNoteNo, this.bLAWBLRConsignmentNoteDate, this.statusOfTheClaim, this.motor1, this.motor2, this.motor3, this.engineering1, this.engineering2, this.motor4, this.aging, this.engineering3, this.motor5, this.engineering4, this.invoicePONumber, this.accountName, this.groupName, this.invoicePODate, this.emailId, this.invoiceValuePOValue, this.country, this.tATForLOR, this.currencyType, this.uSD, this.bACodeSourceSupplyingPlant, this.hrsOfOperation, this.additionalDetails, this.jobComments, this.currentJobStatus, this.statusBasedEditAccess, this.currentJobStatusId, this.nextSeqNos, this.createdSubJobs, this.nextJobStatuses, this.insights, this.overallRating, this.totalReviews, this.malldetails, this.favourites, this.favouritesCount
  });

  MyClaims.fromJson(Map<String, dynamic> json) {
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
		dateOfIntimation = json['Date of Intimation'];
		initiatorsName = json['Initiators name'];
		initiatorsDivision = json['Initiators Division'];
		initiatorsEmail = json['Initiators_email'];
		policyYear = json['Policy Year'];
		initiatorsBU = json['Initiators BU'];
		policyNo = json['Policy No'];
		policyType = json['Policy Type'];
		lossDescription = json['Loss Description'];
		//contactPersonsMobileNo = json['Contact persons mobile no.'];
		claimNo = json['Claim No'];
		//surveyOrganizerEmail = json['Survey Organizer Email'];
		//tATForIntimation = json['TAT for intimation'];
// 	if (json['Attachments'] != null) {
//   attachments = <String>[];
//   json['Attachments'].forEach((v) {
//     attachments.add(v.toString());
//   });
// }


		onAccountPaymentDetails = json['OnAccount Payment Details'];
	//	additionalInformation = json['Additional Information'].cast<String>();
	//	contactPersonsNameToOrganiseSurvey = json['Contact persons name to organise survey'];
		tATForConsent = json['TAT for consent'];
		profitCenter = json['Profit Center'];
		//probableCauseOfDamage = json['Probable Cause of Damage'].cast<String>();
		tATForSurveyorAppointment = json['TAT for surveyor appointment'];
		totalOnAccountPayment = json['Total OnAccount Payment'];
		tATForPayment = json['TAT for payment'];
		tATForAssessment = json['TAT for assessment'];
		documentRepository = json['Document Repository'];
		estimateOfLossInINR = json['Estimate of loss in INR'];
		pendingWith = json['Pending With'];
		dateOfOccurrence = json['Date of Occurrence'];
		//additionalClaimCoordinatorSEmailID = json['Additional Claim Coordinator's Email ID'];
		insurerName = json['Insurer Name'];
		policySubtype = json['Policy Subtype'];
		claimType = json['Claim Type'];
		communicationHistory = json['Communication History'];
		claimReferenceNumber = json['Claim Reference Number'];
		state = json['State'];
		intimationAmount = json['Intimation Amount'];
		assetDescription = json['Asset Description'];
		tATForDocumentSubmission = json['TAT for document submission'];
		bASUName = json['BA / SU Name'];
		materialCargoDescription = json['Material / Cargo Description'];
		briefDetailsOfLoss = json['Brief Details of Loss'];
		consignmentQty = json['Consignment Qty'];
		estimatedLossQtyReported = json['Estimated Loss Qty. Reported'];
		salvageRateApprovedRsBag = json['Salvage Rate Approved (Rs. / Bag)'];
		modeOfTransit = json['Mode of Transit'];
		consignmentValue = json['Consignment Value'];
		consignmentValueRs = json['Consignment Value (Rs.)'];
		approvedLossQuantityJIRNosBags = json['Approved Loss Quantity JIR (Nos / Bags)'];
		claimClosureRemarks = json['Claim Closure Remarks'];
		lossLocationArea = json['Loss Location Area'];
		storeServiceCenterGodownVendorLocationCode = json['Store/Service Center/Godown/Vendor Location Code'];
		region = json['Region'];
		matCost = json['Mat Cost'];
		bLAWBLRNoConsignmentNoteNo = json['BL/AWB/LR No/Consignment Note No'];
		bLAWBLRConsignmentNoteDate = json['BL/AWB/LR/Consignment Note Date'];
		statusOfTheClaim = json['Status of the Claim'];
		motor1 = json['Motor1'];
		motor2 = json['Motor2'];
		motor3 = json['Motor3'];
		engineering1 = json['Engineering1'];
		engineering2 = json['Engineering2'];
		motor4 = json['Motor4'];
		aging = json['Aging'];
		engineering3 = json['Engineering3'];
		motor5 = json['Motor5'];
		engineering4 = json['Engineering4'];
		invoicePONumber = json['Invoice/PO Number'];
		accountName = json['Account Name'];
		groupName = json['Group Name'];
		invoicePODate = json['Invoice/PO Date'];
		emailId = json['Email Id'];
		invoiceValuePOValue = json['Invoice Value/PO Value'];
		country = json['Country'];
		tATForLOR = json['TAT for LOR'];
		currencyType = json['Currency Type'];
		uSD = json['USD'];
		bACodeSourceSupplyingPlant = json['BA Code (Source / Supplying Plant)'];
		if (json['hrsOfOperation'] != null) {
  hrsOfOperation = <String>[];
  json['hrsOfOperation'].forEach((v) {
    hrsOfOperation!.add(v.toString());
  });
}

additionalDetails = json['Additional_Details'] != null
    ? AdditionalDetails.fromJson(json['Additional_Details'])
    : null;

// if (json['jobComments'] != null) {
//   jobComments = <dynamic>[];
//   json['jobComments'].forEach((v) {
//     jobComments.add(v.toString());
//   });
//}

		currentJobStatus = json['Current_Job_Status'];
		statusBasedEditAccess = json['Status_Based_EditAccess'];
		currentJobStatusId = json['Current_Job_StatusId'];
		nextSeqNos = json['Next_Seq_Nos'];
	if (json['CreatedSubJobs'] != null) {
      createdSubJobs = <CreatedSubJobs>[];
      json['CreatedSubJobs'].forEach((v) {
        //createdSubJobs!.add(new Null.fromJson(v));
      });
    }

if (json['Next_Job_Statuses'] != null) {
  nextJobStatuses = <NextJobStatuses>[];
  json['Next_Job_Statuses'].forEach((v) {
    nextJobStatuses!.add(NextJobStatuses.fromJson(v));
  });
}

		insights = json['Insights'];
		overallRating = json['overallRating'];
		totalReviews = json['totalReviews'];
		malldetails = json['malldetails'] != null ? new Malldetails.fromJson(json['malldetails']) : null;
		if (json['favourites'] != null) {
  favourites = <String>[]; // Assuming the JSON values are strings
  json['favourites'].forEach((v) {
    favourites!.add(v.toString()); // Convert JSON value to string and add it to the list
  });
}

		favouritesCount = json['favouritesCount'];
	}

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['jobTypeName'] = this.jobTypeName;
    data['Date of Intimation'] = this.dateOfIntimation;
    data['Policy Year'] = this.policyYear;
    data['Policy No'] = this.policyNo;
    data['Policy Type'] = this.policyType;
    data['Claim No'] = this.claimNo;
    data['Estimate of loss in INR'] = this.estimateOfLossInINR;
    data['Date of Occurrence'] = this.dateOfOccurrence;
    data['Claim Type'] = this.claimType;
    return data;
  }
  
}
class AdditionalDetails {


	//AdditionalDetails({});

	AdditionalDetails.fromJson(Map<String, dynamic> json) {
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}

class NextJobStatuses {
	String? statusId;
	String? seqNo;
	String? statusName;
	List<SubJobtypeForms>? subJobtypeForms;
	List<AccessRoles>? accessRoles;
	String? ruleText;

	NextJobStatuses({this.statusId, this.seqNo, this.statusName, this.subJobtypeForms, this.accessRoles, this.ruleText});

	NextJobStatuses.fromJson(Map<String, dynamic> json) {
		statusId = json['Status_Id'];
		seqNo = json['SeqNo'];
		statusName = json['Status_Name'];
		if (json['Sub_Jobtype_Forms'] != null) {
  subJobtypeForms = <SubJobtypeForms>[];
  json['Sub_Jobtype_Forms'].forEach((v) {
    subJobtypeForms!.add(SubJobtypeForms.fromJson(v));
  });
}

if (json['Access_Roles'] != null) {
  accessRoles = <AccessRoles>[];
  json['Access_Roles'].forEach((v) {
    accessRoles!.add(AccessRoles.fromJson(v));
  });
}

		ruleText = json['rule_text'];
	}


}

class SubJobtypeForms {
	String? formId;
	String? formName;

	SubJobtypeForms({this.formId, this.formName});

	SubJobtypeForms.fromJson(Map<String, dynamic> json) {
		formId = json['Form_Id'];
		formName = json['Form_Name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Form_Id'] = this.formId;
		data['Form_Name'] = this.formName;
		return data;
	}
}

class AccessRoles {
	String? id;
	String? name;

	AccessRoles({this.id, this.name});

	AccessRoles.fromJson(Map<String, dynamic> json) {
		id = json['Id'];
		name = json['Name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['Id'] = this.id;
		data['Name'] = this.name;
		return data;
	}
}

class Malldetails {
	String? id;
	String? fullname;
	String? email;
	String? subdomain;

	Malldetails({this.id, this.fullname, this.email, this.subdomain});

	Malldetails.fromJson(Map<String, dynamic> json) {
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
	}}
  class CreatedSubJobs {
  int? id;
  String? jobtype;
  CreatedSubJobs(this.id, this.jobtype);
  CreatedSubJobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    jobtype = json['jobTypeName'];
  }
}
