class LoginResponse {
  String? statusMessage;
  int? statusCode;
  LoginData? data;
  String? time;

  LoginResponse({this.statusMessage, this.statusCode, this.data, this.time});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusMessage = json['status_Message'];
    statusCode = json['status_Code'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_Message'] = this.statusMessage;
    data['status_Code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['time'] = this.time;
    return data;
  }
}

class LoginData {
  String? token;
  String? userName;
  String? rolename;
  String? clientId;
  String? employeeName;
  int? pqStationId;
  String? pqStationName;
  bool? roleStatus;
  String? modifiedTime;
  int? userId;

  LoginData(
      {this.token,
      this.userName,
      this.rolename,
      this.clientId,
      this.employeeName,
      this.pqStationId,
      this.pqStationName,
      this.roleStatus,
      this.modifiedTime,
      this.userId});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userName = json['userName'];
    rolename = json['rolename'];
    clientId = json['clientId'];
    employeeName = json['employeeName'];
    pqStationId = json['pqStationId'];
    pqStationName = json['pqStationName'];
    roleStatus = json['roleStatus'];
    modifiedTime = json['modifiedTime'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userName'] = this.userName;
    data['rolename'] = this.rolename;
    data['clientId'] = this.clientId;
    data['employeeName'] = this.employeeName;
    data['pqStationId'] = this.pqStationId;
    data['pqStationName'] = this.pqStationName;
    data['roleStatus'] = this.roleStatus;
    data['modifiedTime'] = this.modifiedTime;
    data['userId'] = this.userId;
    return data;
  }
}
