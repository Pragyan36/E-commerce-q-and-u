// To parse this JSON data, do
//
//     final shippingAddress = shippingAddressFromJson(jsonString);

import 'dart:convert';

ShippingAddress shippingAddressFromJson(String str) =>
    ShippingAddress.fromJson(json.decode(str));

String shippingAddressToJson(ShippingAddress data) =>
    json.encode(data.toJson());

class ShippingAddress {
  ShippingAddress({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<ShippingAddressData>? data;
  String? msg;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        error: json["error"],
        data: List<ShippingAddressData>.from(
            json["data"].map((x) => ShippingAddressData.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ShippingAddressData {
  ShippingAddressData({
    this.id,
    this.engName,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.publishStatus,
    this.districts,
  });

  int? id;
  String? engName;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? publishStatus;
  List<Districts>? districts;

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) =>
      ShippingAddressData(
        id: json["id"],
        engName: json["eng_name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        publishStatus: json["publishStatus"],
        districts: List<Districts>.from(
            json["districts"].map((x) => Districts.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "eng_name": engName,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "publishStatus": publishStatus,
        "districts": List<dynamic>.from(districts!.map((x) => x.toJson())),
      };
}

class Districts {
  Districts({
    this.id,
    this.province,
    this.distId,
    this.publishStatus,
    this.npName,
    this.createdAt,
    this.updatedAt,
    this.localarea,
  });

  int? id;
  int? province;
  int? distId;
  int? publishStatus;
  String? npName;
  String? createdAt;
  String? updatedAt;
  List<Localarea>? localarea;

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
        id: json["id"],
        province: json["province"],
        distId: json["dist_id"],
        publishStatus: json["publishStatus"],
        npName: json["np_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        localarea: List<Localarea>.from(
            json["localarea"].map((x) => Localarea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province": province,
        "dist_id": distId,
        "publishStatus": publishStatus,
        "np_name": npName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "localarea": List<dynamic>.from(localarea!.map((x) => x.toJson())),
      };
}

class Localarea {
  Localarea({
    this.id,
    this.provinceId,
    this.distId,
    this.localLevelId,
    this.localId,
    this.publishStatus,
    this.localName,
    this.createdAt,
    this.updatedAt,
    this.getRouteCharge,
  });

  int? id;
  int? provinceId;
  int? distId;
  int? localLevelId;
  double? localId;
  int? publishStatus;
  String? localName;
  String? createdAt;
  String? updatedAt;
  List<GetRouteCharge>? getRouteCharge;

  factory Localarea.fromJson(Map<String, dynamic> json) => Localarea(
        id: json["id"],
        provinceId: json["province_id"],
        distId: json["dist_id"],
        localLevelId: json["local_level_id"],
        localId: json["local_id"],
        publishStatus: json["publishStatus"],
        localName: json["city_name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        getRouteCharge: List<GetRouteCharge>.from(
            json["get_route_charge"].map((x) => GetRouteCharge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "dist_id": distId,
        "local_level_id": localLevelId,
        "local_id": localId,
        "publishStatus": publishStatus,
        "city_name": localName,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "get_route_charge":
            List<dynamic>.from(getRouteCharge!.map((x) => x.toJson())),
      };
}

class GetRouteCharge {
  GetRouteCharge({
    this.id,
    this.localId,
    this.title,
    this.slug,
    this.image,
    this.zipCode,
  });

  int? id;
  int? localId;
  String? title;
  String? slug;
  dynamic image;
  String? zipCode;

  factory GetRouteCharge.fromJson(Map<String, dynamic> json) => GetRouteCharge(
        id: json["id"],
        localId: json["local_id"],
        title: json["title"],
        slug: json["slug"],
        image: json["image"],
        zipCode: json["zip_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "local_id": localId,
        "title": title,
        "slug": slug,
        "image": image,
        "zip_code": zipCode,
      };
}
