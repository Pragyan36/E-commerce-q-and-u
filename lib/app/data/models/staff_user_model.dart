class StaffUserModel {
  bool? error;
  Data? data;
  String? msg;

  StaffUserModel({this.error, this.data, this.msg});

  StaffUserModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic additionalAddress;
  dynamic company;
  dynamic agree;
  dynamic gender;
  dynamic country;
  dynamic area;
  dynamic memberId;
  dynamic province;
  dynamic district;
  dynamic zip;
  String? address;
  bool? status;
  String? photo;
  dynamic emailVerifiedAt;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  dynamic providerId;
  dynamic provider;
  dynamic avatar;
  String? createdAt;
  String? updatedAt;
  List<Roles>? roles;

  Data(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.additionalAddress,
      this.company,
      this.agree,
      this.gender,
      this.country,
      this.area,
      this.memberId,
      this.province,
      this.district,
      this.zip,
      this.address,
      this.status,
      this.photo,
      this.emailVerifiedAt,
      this.twoFactorSecret,
      this.twoFactorRecoveryCodes,
      this.providerId,
      this.provider,
      this.avatar,
      this.createdAt,
      this.updatedAt,
      this.roles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    additionalAddress = json['additional_address'];
    company = json['company'];
    agree = json['agree'];
    gender = json['gender'];
    country = json['country'];
    area = json['area'];
    memberId = json['member_id'];
    province = json['province'];
    district = json['district'];
    zip = json['zip'];
    address = json['address'];
    status = json['status'];
    photo = json['photo'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    providerId = json['provider_id'];
    provider = json['provider'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['additional_address'] = additionalAddress;
    data['company'] = company;
    data['agree'] = agree;
    data['gender'] = gender;
    data['country'] = country;
    data['area'] = area;
    data['member_id'] = memberId;
    data['province'] = province;
    data['district'] = district;
    data['zip'] = zip;
    data['address'] = address;
    data['status'] = status;
    data['photo'] = photo;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_secret'] = twoFactorSecret;
    data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    data['provider_id'] = providerId;
    data['provider'] = provider;
    data['avatar'] = avatar;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['guard_name'] = guardName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? modelId;
  int? roleId;
  String? modelType;

  Pivot({this.modelId, this.roleId, this.modelType});

  Pivot.fromJson(Map<String, dynamic> json) {
    modelId = json['model_id'];
    roleId = json['role_id'];
    modelType = json['model_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['model_id'] = modelId;
    data['role_id'] = roleId;
    data['model_type'] = modelType;
    return data;
  }
}
