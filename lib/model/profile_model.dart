class UserDetails {
  String? status;
  Result? result;

  UserDetails({this.status, this.result});

  UserDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? fullname;
  String? username;
  String? firstName;
  String? lastName;
  String? emailId;
  String? mobile;
  String? anniversaryDate;
  String? dob;
  String? role;
  AccountRole? accountRole;
  int? active;
  String? gender;
  String? langs;
  String? address;
  String? uniqueUserName;
  String? logo;
  int? id;

  Result(
      {this.fullname,
      this.username,
      this.firstName,
      this.lastName,
      this.emailId,
      this.mobile,
      this.anniversaryDate,
      this.dob,
      this.role,
      this.accountRole,
      this.active,
      this.gender,
      this.langs,
      this.address,
      this.uniqueUserName,
      this.logo,
      this.id});

  Result.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailId = json['emailId'];
    mobile = json['mobile'];
    anniversaryDate = json['anniversaryDate'];
    dob = json['dob'];
    role = json['role'];
    accountRole = json['accountRole'] != null
        ? new AccountRole.fromJson(json['accountRole'])
        : null;
    active = json['active'];
    gender = json['gender'];
    langs = json['langs'];
    address = json['address'];
    uniqueUserName = json['uniqueUserName'];
    if (json.containsKey('logo')) {
      logo = json['logo'].isNotEmpty
          ? json['logo']
          : 'https://sa4.insuranceportfolio.in:9085/coin/files/7/user/files/999_1684836444462.png';
      print('logo: $logo');
    } else {
      logo =
          "https://sa4.insuranceportfolio.in:9085/coin/files/7/user/files/999_1684836444462.png";
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailId'] = this.emailId;
    data['mobile'] = this.mobile;
    data['anniversaryDate'] = this.anniversaryDate;
    data['dob'] = this.dob;
    data['role'] = this.role;
    if (this.accountRole != null) {
      data['accountRole'] = this.accountRole!.toJson();
    }
    // data['active'] = this.active;
    // data['gender'] = this.gender;
    // data['langs'] = this.langs;
    // data['address'] = this.address;
    // data['uniqueUserName'] = this.uniqueUserName;
    // data['logo'] = this.logo;
    // data['id'] = this.id;
    return data;
  }
}

class AccountRole {
  int? id;
  String? name;
  List<Properties>? properties;

  AccountRole({this.id, this.name, this.properties});

  AccountRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['properties'] != null) {
      properties = <Properties>[];
      json['properties'].forEach((v) {
        properties!.add(new Properties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.properties != null) {
      data['properties'] = this.properties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Properties {
  String? propName;
  String? propValue;
  // bool? isAttachment;
  // String? attachmentName;
   String? jobTypeFldJson;
  // int? id;
  // List<String>? allowedValuesResults;

  Properties(
      {this.propName,
      this.propValue,
      // this.isAttachment,
      // this.attachmentName,
       this.jobTypeFldJson,
      // this.id,
      // this.allowedValuesResults
      });

  Properties.fromJson(Map<String, dynamic> json) {
    propName = json['propName'];
    propValue = json['propValue'];
    // isAttachment = json['isAttachment'];
    // attachmentName = json['attachmentName'];
     jobTypeFldJson = json['jobTypeFldJson'];
    // id = json['id'];
    // allowedValuesResults = json['allowedValuesResults'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['propName'] = this.propName;
    data['propValue'] = this.propValue;
    // data['isAttachment'] = this.isAttachment;
    // data['attachmentName'] = this.attachmentName;
     data['jobTypeFldJson'] = this.jobTypeFldJson;
    // data['id'] = this.id;
    // data['allowedValuesResults'] = this.allowedValuesResults;
    return data;
  }
}
