import 'dart:convert';

CustomerCareModel customerCareModelFromJson(String str) =>
    CustomerCareModel.fromJson(json.decode(str));

String customerCareModelToJson(CustomerCareModel data) =>
    json.encode(data.toJson());

class CustomerCareModel {
  CustomerCareModel({
    this.data,
    this.msg,
  });

  List<CustomCareHeadingModel>? data;
  String? msg;

  factory CustomerCareModel.fromJson(Map<String, dynamic> json) =>
      CustomerCareModel(
        data: List<CustomCareHeadingModel>.from(
            json["data"].map((x) => CustomCareHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class CustomCareHeadingModel {
  CustomCareHeadingModel({
    this.id,
    this.title,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? content;
  int? status;
  String? createdAt;
  String? updatedAt;

  factory CustomCareHeadingModel.fromJson(Map<String, dynamic> json) =>
      CustomCareHeadingModel(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
