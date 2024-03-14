// To parse this JSON data, do
//
//     final returnOrderModel = returnOrderModelFromJson(jsonString);

import 'dart:convert';

ReturnOrderModel returnOrderModelFromJson(String str) =>
    ReturnOrderModel.fromJson(json.decode(str));

String returnOrderModelToJson(ReturnOrderModel data) =>
    json.encode(data.toJson());

class ReturnOrderModel {
  ReturnOrderModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<ReturnOrderHeadingModel>? data;
  String? msg;

  factory ReturnOrderModel.fromJson(Map<String, dynamic> json) =>
      ReturnOrderModel(
        error: json["error"],
        data: List<ReturnOrderHeadingModel>.from(
            json["data"].map((x) => ReturnOrderHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ReturnOrderHeadingModel {
  ReturnOrderHeadingModel({
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
    // this.options,
    this.createdAt,
    this.updatedAt,
    this.cancelStatus,
    this.statusData,
    // this.getImage,
    this.product,
    // this.getReturnOrder,
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
  // List<Option>? options;
  String? createdAt;
  String? updatedAt;
  String? cancelStatus;
  bool? statusData;
  // List<GetImage>? getImage;
  Product? product;
  // GetReturnOrder? getReturnOrder;

  factory ReturnOrderHeadingModel.fromJson(Map<String, dynamic> json) =>
      ReturnOrderHeadingModel(
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
        // options:
        //     List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        cancelStatus: json["cancel_status"],
        statusData: json["statusData"],
        // getImage: List<GetImage>.from(
        //     json["get_image"].map((x) => GetImage.fromJson(x))),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        // getReturnOrder: GetReturnOrder.fromJson(json["get_return_order"]),
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
        // "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "created_at": createdAt,
        "updated_at": updatedAt,
        "cancel_status": cancelStatus,
        "statusData": statusData,
        // "get_image": List<dynamic>.from(getImage!.map((x) => x.toJson())),
        "product": product!.toJson(),
        // "get_return_order": getReturnOrder!.toJson(),
      };
}

class GetImage {
  GetImage({
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
  String? createdAt;
  String? updatedAt;

  factory GetImage.fromJson(Map<String, dynamic> json) => GetImage(
        id: json["id"],
        image: json["image"],
        colorId: json["color_id"],
        productId: json["product_id"],
        isFeatured: json["is_featured"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "color_id": colorId,
        "product_id": productId,
        "is_featured": isFeatured,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class GetReturnOrder {
  GetReturnOrder({
    this.id,
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
  });

  int? id;
  dynamic updatedBy;
  int? userId;
  int? productId;
  int? orderAssetId;
  int? qty;
  String? amount;
  String? reason;
  String? comment;
  String? status;
  int? isNew;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetReturnOrder.fromJson(Map<String, dynamic> json) => GetReturnOrder(
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
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
      };
}

class Option {
  Option({
    this.id,
    this.title,
    this.value,
  });

  int? id;
  String? title;
  String? value;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        title: json["title"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "value": value,
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "seller_id": sellerId,
        "total_sell": totalSell,
        "meta_title": metaTitle,
        "meta_keywords": metaKeywords,
        "meta_description": metaDescription,
        "og_image": ogImage,
        "deleted_at": deletedAt,
      };
}

// enum WarrantyPeriod { THE_3_MONTHS, THE_1_YEARS }

// final warrantyPeriodValues = EnumValues({
//     "1 Years": WarrantyPeriod.THE_1_YEARS,
//     "3 Months": WarrantyPeriod.THE_3_MONTHS
// });

// enum WarrantyType { LOCAL_SELLER_WARRANTY, BRAND_WARRANTY, NO_WARRANTY, SELLER_WARRANTY }

// final warrantyTypeValues = EnumValues({
//     "Brand Warranty": WarrantyType.BRAND_WARRANTY,
//     "Local Seller Warranty": WarrantyType.LOCAL_SELLER_WARRANTY,
//     "No Warranty": WarrantyType.NO_WARRANTY,
//     "Seller Warranty": WarrantyType.SELLER_WARRANTY
// });

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
