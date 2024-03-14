// To parse this JSON data, do
//
//     final slider = sliderFromJson(jsonString);

import 'dart:convert';

List<SliderModel> sliderFromJson(String str) => List<SliderModel>.from(
    json.decode(str).map((x) => SliderModel.fromJson(x)));

String sliderToJson(List<SliderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SliderModel {
  SliderModel({
    this.id,
    this.title,
    this.body,
    this.image,
    this.link,
    this.metaDesc,
    this.metaKeyword,
    this.metaTitle,
    this.altImg,
    this.publishStatus,
    this.deleteStatus,
    this.hideStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? body;
  String? image;
  String? link;
  dynamic metaDesc;
  dynamic metaKeyword;
  dynamic metaTitle;
  String? altImg;
  String? publishStatus;
  String? deleteStatus;
  String? hideStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        link: json["link"],
        metaDesc: json["meta_desc"],
        metaKeyword: json["meta_keyword"],
        metaTitle: json["meta_title"],
        altImg: json["alt_img"],
        publishStatus: json["publish_status"],
        deleteStatus: json["delete_status"],
        hideStatus: json["hide_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "image": image,
        "link": link,
        "meta_desc": metaDesc,
        "meta_keyword": metaKeyword,
        "meta_title": metaTitle,
        "alt_img": altImg,
        "publish_status": publishStatus,
        "delete_status": deleteStatus,
        "hide_status": hideStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
