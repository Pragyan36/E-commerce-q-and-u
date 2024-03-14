class UserBillingAddress {
  bool? error;
  List<UserBillingAddressData>? data;
  String? msg;

  UserBillingAddress({this.error, this.data, this.msg});

  UserBillingAddress.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <UserBillingAddressData>[];
      json['data'].forEach((v) {
        data!.add(UserBillingAddressData.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class UserBillingAddressData {
  int? id;
  String? name;
  int? userId;
  String? email;
  String? phone;
  String? province;
  String? district;
  String? area;
  String? additionalAddress;
  int? zip;
  int? futureUse;
  String? createdAt;
  String? updatedAt;

  UserBillingAddressData(
      {this.id,
      this.name,
      this.userId,
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

  UserBillingAddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
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
    data['name'] = name;
    data['user_id'] = userId;
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
