class UserShippingAddress {
  bool? error;
  List<UserShippingAddressData>? data;
  String? msg;

  UserShippingAddress({this.error, this.data, this.msg});

  UserShippingAddress.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <UserShippingAddressData>[];
      json['data'].forEach((v) {
        data!.add(UserShippingAddressData.fromJson(v));
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

class UserShippingAddressData {
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
  dynamic charge;
  String? futureUse;
  String? createdAt;
  String? updatedAt;

  UserShippingAddressData(
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
      this.charge,
      this.futureUse,
      this.createdAt,
      this.updatedAt});

  UserShippingAddressData.fromJson(Map<String, dynamic> json) {
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
    charge = json['charge'];
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
    data['charge'] = charge;
    data['future_use'] = futureUse;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
