class LoginDataModel {
  String? msg;
  String? country;
  String? defaultStoreItemCode;
  String? mappedConsumerUserId;
  String? userId;
  String? mallId;
  String? mobile;
  String? mallEmailId;
  String? accessToken;
  String? loyaltyPoints;
  String? routerUrl;
  String? name;
  String? token;
  String? accRoleId;
  String? currency;
  String? accRoleName;
  String? status;
  String? accountUserId;
  String? defaultStoreId;
  String? username;
  //List<Null> permissions;
  bool? requirePasswordReset;


  LoginDataModel(
      {this.msg,
      this.country,
      this.defaultStoreItemCode,
      this.mappedConsumerUserId,
      this.userId,
      this.mallId,
      this.mobile,
      this.mallEmailId,
      this.accessToken,
      this.loyaltyPoints,
      this.routerUrl,
      this.name,
      this.token,
      this.accRoleId,
      this.currency,
      this.accRoleName,
      this.status,
      this.accountUserId,
      this.defaultStoreId,
      this.username,
     // this.permissions,
      this.requirePasswordReset,
    });

  LoginDataModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    country = json['country'];
    defaultStoreItemCode = json['defaultStoreItemCode'];
    mappedConsumerUserId = json['mappedConsumerUserId'];
    userId = json['userId'];
    mallId = json['mallId'];
    mobile = json['mobile'];
    mallEmailId = json['mallEmailId'];
    accessToken = json['accessToken'];
    loyaltyPoints = json['loyaltyPoints'];
    routerUrl = json['routerUrl'];
    name = json['Name'];
    token = json['token'];
    accRoleId = json['accRoleId'];
    currency = json['currency'];
    accRoleName = json['accRoleName'];
    status = json['status'];
    accountUserId = json['accountUserId'];
    defaultStoreId = json['defaultStoreId'];
    username = json['username'];
    // if (json['permissions'] != null) {
    //   permissions = new List<Null>();
    //   json['permissions'].forEach((v) {
    //     permissions.add(new Null.fromJson(v));
    //   });
    // }
    requirePasswordReset = json['requirePasswordReset'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['country'] = this.country;
    data['defaultStoreItemCode'] = this.defaultStoreItemCode;
    data['mappedConsumerUserId'] = this.mappedConsumerUserId;
    data['userId'] = this.userId;
    data['mallId'] = this.mallId;
    data['mobile'] = this.mobile;
    data['mallEmailId'] = this.mallEmailId;
    data['accessToken'] = this.accessToken;
    data['loyaltyPoints'] = this.loyaltyPoints;
    data['routerUrl'] = this.routerUrl;
    data['Name'] = this.name;
    data['token'] = this.token;
    data['accRoleId'] = this.accRoleId;
    data['currency'] = this.currency;
    data['accRoleName'] = this.accRoleName;
    data['status'] = this.status;
    data['accountUserId'] = this.accountUserId;
    data['defaultStoreId'] = this.defaultStoreId;
    data['username'] = this.username;
    // if (this.permissions != null) {
    //   data['permissions'] = this.permissions.map((v) => v.toJson()).toList();
    // }
    data['requirePasswordReset'] = this.requirePasswordReset;
    data['name'] = this.name;
    return data;
  }
}