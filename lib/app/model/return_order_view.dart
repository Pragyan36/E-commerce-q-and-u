// To parse this JSON data, do
//
//     final returnOrderViewModel = returnOrderViewModelFromJson(jsonString);

import 'dart:convert';

ReturnOrderViewModel returnOrderViewModelFromJson(String str) =>
    ReturnOrderViewModel.fromJson(json.decode(str));

String returnOrderViewModelToJson(ReturnOrderViewModel data) =>
    json.encode(data.toJson());

class ReturnOrderViewModel {
  ReturnOrderViewModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<ReturnOrderViewHeadingModel>? data;
  String? msg;

  factory ReturnOrderViewModel.fromJson(Map<String, dynamic> json) =>
      ReturnOrderViewModel(
        error: json["error"],
        data: List<ReturnOrderViewHeadingModel>.from(
            json["data"].map((x) => ReturnOrderViewHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ReturnOrderViewHeadingModel {
  ReturnOrderViewHeadingModel(
      {this.id,
      this.updatedBy,
      this.userId,
      this.productId,
      this.orderAssetId,
      this.qty,
      this.amount,
      this.reason,
      this.comment,
      this.status,
      this.isNew,
      this.createdAt,
      this.updatedAt,
      this.applyRefund,
      this.returnStatus,
      this.refundShowStatus,
      this.refundMessageValue,
      this.productname,
      // this.getproduct,
      this.refundData,
      this.image});

  int? id;
  dynamic updatedBy;
  int? userId;
  int? productId;
  String? productname;
  int? orderAssetId;
  int? qty;
  String? image;
  String? amount;
  String? reason;
  String? comment;
  String? status;
  int? isNew;
  String? createdAt;
  String? updatedAt;
  bool? applyRefund;
  String? returnStatus;
  String? refundShowStatus;
  String? refundMessageValue;

  // Getproduct? getproduct;
  dynamic refundData;

  factory ReturnOrderViewHeadingModel.fromJson(Map<String, dynamic> json) =>
      ReturnOrderViewHeadingModel(
        id: json["id"],
        updatedBy: json["updated_by"],
        userId: json["user_id"],
        productId: json["product_id"],
        orderAssetId: json["order_asset_id"],
        qty: json["qty"],
        amount: json["amount"],
        reason: json["reason"],
        comment: json["comment"],
        status: json["status"],
        isNew: json["is_new"],
        image: json["image"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        applyRefund: json["applyRefundStatus"],
        refundMessageValue: json["refundMessageValue"],
        returnStatus: json["returnStatusValue"],
        refundShowStatus: json["refundStatusValue"],
        productname: json["name"],
        // getproduct: json["getproduct"] == null
        //     ? null
        //     : Getproduct.fromJson(json["getproduct"]),
        refundData: json["refund_data"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "updated_by": updatedBy,
        "user_id": userId,
        "product_id": productId,
        "order_asset_id": orderAssetId,
        "qty": qty,
        "amount": amount,
        "reason": reason,
        "comment": comment,
        "status": status,
        "is_new": isNew,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "applyRefundStatus": applyRefund,
        "returnStatusValue": returnStatus,
        "refundMessageValue": refundMessageValue,
        "refundStatusValue": refundShowStatus,
        "image": image,
        "name": productname,
        // "getproduct": getproduct!.toJson(),
        "refund_data": refundData,
      };
}

class Getproduct {
  Getproduct({
    this.id,
    this.name,
    this.slug,
    this.shortDescription,
    this.longDescription,
    this.minOrder,
    this.returnableTime,
    this.returnPolicy,
    this.deliveryTime,
    this.keyword,
    this.packageWeight,
    this.dimensionLength,
    this.dimensionWidth,
    this.dimensionHeight,
    this.warrantyType,
    this.warrantyPeriod,
    this.warrantyPolicy,
    this.brandId,
    this.countryId,
    this.categoryId,
    this.userId,
    this.rating,
    this.publishStatus,
    this.isNew,
    this.status,
    this.url,
    this.createdAt,
    this.updatedAt,
    this.sellerId,
    this.totalSell,
    this.metaTitle,
    this.metaKeywords,
    this.metaDescription,
    this.ogImage,
    this.deletedAt,
    this.images,
  });

  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
  String? minOrder;
  String? returnableTime;
  dynamic returnPolicy;
  String? deliveryTime;
  dynamic keyword;
  String? packageWeight;
  String? dimensionLength;
  String? dimensionWidth;
  String? dimensionHeight;
  String? warrantyType;
  String? warrantyPeriod;
  String? warrantyPolicy;
  int? brandId;
  dynamic countryId;
  int? categoryId;
  int? userId;
  String? rating;
  bool? publishStatus;
  int? isNew;
  String? status;
  dynamic url;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sellerId;
  int? totalSell;
  dynamic metaTitle;
  dynamic metaKeywords;
  dynamic metaDescription;
  dynamic ogImage;
  dynamic deletedAt;
  List<Image>? images;

  factory Getproduct.fromJson(Map<String, dynamic> json) => Getproduct(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        shortDescription: json["short_description"],
        longDescription: json["long_description"],
        minOrder: json["min_order"],
        returnableTime: json["returnable_time"],
        returnPolicy: json["return_policy"],
        deliveryTime: json["delivery_time"],
        keyword: json["keyword"],
        packageWeight: json["package_weight"],
        dimensionLength: json["dimension_length"],
        dimensionWidth: json["dimension_width"],
        dimensionHeight: json["dimension_height"],
        warrantyType: json["warranty_type"],
        warrantyPeriod: json["warranty_period"],
        warrantyPolicy: json["warranty_policy"],
        brandId: json["brand_id"],
        countryId: json["country_id"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        rating: json["rating"],
        publishStatus: json["publishStatus"],
        isNew: json["is_new"],
        status: json["status"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        sellerId: json["seller_id"],
        totalSell: json["total_sell"],
        metaTitle: json["meta_title"],
        metaKeywords: json["meta_keywords"],
        metaDescription: json["meta_description"],
        ogImage: json["og_image"],
        deletedAt: json["deleted_at"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "short_description": shortDescription,
        "long_description": longDescription,
        "min_order": minOrder,
        "returnable_time": returnableTime,
        "return_policy": returnPolicy,
        "delivery_time": deliveryTime,
        "keyword": keyword,
        "package_weight": packageWeight,
        "dimension_length": dimensionLength,
        "dimension_width": dimensionWidth,
        "dimension_height": dimensionHeight,
        "warranty_type": warrantyType,
        "warranty_period": warrantyPeriod,
        "warranty_policy": warrantyPolicy,
        "brand_id": brandId,
        "country_id": countryId,
        "category_id": categoryId,
        "user_id": userId,
        "rating": rating,
        "publishStatus": publishStatus,
        "is_new": isNew,
        "status": status,
        "url": url,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "seller_id": sellerId,
        "total_sell": totalSell,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "og_image": ogImage,
        "deleted_at": deletedAt,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  Image({
    this.id,
    this.image,
    this.colorId,
    this.productId,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? image;
  int? colorId;
  int? productId;
  int? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
        colorId: json["color_id"],
        productId: json["product_id"],
        isFeatured: json["is_featured"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "color_id": colorId,
        "product_id": productId,
        "is_featured": isFeatured,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
