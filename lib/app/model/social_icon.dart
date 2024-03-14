// To parse this JSON data, do
//
//     final socialIconModel = socialIconModelFromJson(jsonString);

import 'dart:convert';

SocialIconModel socialIconModelFromJson(String str) =>
    SocialIconModel.fromJson(json.decode(str));

String socialIconModelToJson(SocialIconModel data) =>
    json.encode(data.toJson());

class SocialIconModel {
  SocialIconModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  SocialIconHeadingModel? data;
  String? msg;

  factory SocialIconModel.fromJson(Map<String, dynamic> json) =>
      SocialIconModel(
        error: json["error"],
        data: SocialIconHeadingModel.fromJson(json["data"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data!.toJson(),
        "msg": msg,
      };
}

class SocialIconHeadingModel {
  SocialIconHeadingModel(
      {this.facebook,
      this.youtube,
      this.instagram,
      this.twitter,
      this.address,
      this.email,
      this.name,
      this.phone});

  String? facebook;
  String? youtube;
  String? instagram;
  String? twitter;
  String? address;
  String? email;
  String? phone;
  String? name;

  factory SocialIconHeadingModel.fromJson(Map<String, dynamic> json) =>
      SocialIconHeadingModel(
        facebook: json["facebook"],
        youtube: json["youtube"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        address: json['address'],
        email: json['email'],
        phone: json['phone'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "youtube": youtube,
        "instagram": instagram,
        "twitter": twitter,
        "address": address,
        "name": name,
        "phone": phone,
        "email": email,
      };
}
