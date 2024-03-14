// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class UserModel {
  bool? error;
  UserData? data;
  String? msg;

  UserModel({this.error, this.data, this.msg});

  UserModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? status;
  String? photo;
  String? province;
  String? district;
  String? area;
  int? zip;
  String? companyName;
  String? verifyToken;
  int? verifyOtp;
  int? userId;
  String? emailVerifiedAt;
  String? socialProvider;
  String? referal_code;
  String? providerId;
  String? createdAt;
  String? social_avatar;
  String? updatedAt;
  UserShippingAddress? userShippingAddress;

  UserData(
      {this.id,
      this.name,
      this.referal_code,
      this.email,
      this.phone,
      this.address,
      this.status,
      this.photo,
      this.province,
      this.social_avatar,
      this.district,
      this.area,
      this.zip,
      this.companyName,
      this.verifyToken,
      this.verifyOtp,
      this.userId,
      this.emailVerifiedAt,
      this.socialProvider,
      this.providerId,
      this.createdAt,
      this.updatedAt,
      this.userShippingAddress});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    referal_code = json['referal_code'];
    phone = json['phone'];
    address = json['address'];
    social_avatar = json['social_avatar'];
    status = json['status'];
    photo = json['photo'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    zip = json['zip'];
    companyName = json['company_name'];
    verifyToken = json['verify_token'];
    verifyOtp = json['verify_otp'];
    userId = json['user_id'];
    emailVerifiedAt = json['email_verified_at'];
    socialProvider = json['social_provider'];
    providerId = json['provider_id'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userShippingAddress = json['user_shipping_address'] != null
        ? UserShippingAddress.fromJson(json['user_shipping_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['referal_code'] = referal_code;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['social_avatar'] = social_avatar;
    data['status'] = status;
    data['photo'] = photo;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['zip'] = zip;
    data['company_name'] = companyName;
    data['verify_token'] = verifyToken;
    data['verify_otp'] = verifyOtp;
    data['user_id'] = userId;
    data['email_verified_at'] = emailVerifiedAt;
    data['social_provider'] = socialProvider;
    data['provider_id'] = providerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (userShippingAddress != null) {
      data['user_shipping_address'] = userShippingAddress!.toJson();
    }
    return data;
  }
}

class UserShippingAddress {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? province;
  String? district;
  String? area;
  String? additionalAddress;
  int? zip;
  String? futureUse;
  String? createdAt;
  String? updatedAt;

  UserShippingAddress(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.phone,
      this.province,
      this.district,
      this.area,
      this.additionalAddress,
      this.zip,
      this.futureUse,
      this.createdAt,
      this.updatedAt});

  UserShippingAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    additionalAddress = json['additional_address'];
    zip = json['zip'];
    futureUse = json['future_use'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['additional_address'] = additionalAddress;
    data['zip'] = zip;
    data['future_use'] = futureUse;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
