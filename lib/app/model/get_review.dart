// To parse this JSON data, do
//
//     final getReviewModel = getReviewModelFromJson(jsonString);

import 'dart:convert';

GetReviewModel getReviewModelFromJson(String str) =>
    GetReviewModel.fromJson(json.decode(str));

String getReviewModelToJson(GetReviewModel data) => json.encode(data.toJson());

class GetReviewModel {
  GetReviewModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<GetReviewHeadingModel>? data;
  String? msg;

  factory GetReviewModel.fromJson(Map<String, dynamic> json) => GetReviewModel(
        error: json["error"],
        data: List<GetReviewHeadingModel>.from(
            json["data"].map((x) => GetReviewHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class GetReviewHeadingModel {
  GetReviewHeadingModel({
    this.id,
    this.orderId,
    this.productId,
    this.productName,
    this.price,
    this.qty,
    this.subTotalPrice,
    this.color,
    this.image,
    this.discount,
    this.options,
    this.createdAt,
    this.updatedAt,
    this.cancelStatus,
  });

  int? id;
  int? orderId;
  int? productId;
  String? productName;
  int? price;
  int? qty;
  int? subTotalPrice;
  String? color;
  String? image;
  int? discount;
  List<dynamic>? options;
  String? createdAt;
  String? updatedAt;
  String? cancelStatus;

  factory GetReviewHeadingModel.fromJson(Map<String, dynamic> json) =>
      GetReviewHeadingModel(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        price: json["price"],
        qty: json["qty"],
        subTotalPrice: json["sub_total_price"],
        color: json["color"],
        image: json["image"],
        discount: json["discount"],
        options: List<dynamic>.from(json["options"].map((x) => x)),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        cancelStatus: json["cancel_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "qty": qty,
        "sub_total_price": subTotalPrice,
        "color": color,
        "image": image,
        "discount": discount,
        "options": List<dynamic>.from(options!.map((x) => x)),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "cancel_status": cancelStatus,
      };
}
