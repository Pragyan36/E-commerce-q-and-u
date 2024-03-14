// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<ReviewHeadingModel>? data;
  String? msg;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        error: json["error"],
        data: List<ReviewHeadingModel>.from(
            json["data"].map((x) => ReviewHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class ReviewHeadingModel {
  ReviewHeadingModel({
    this.id,
    this.userId,
    this.productId,
    this.rating,
    this.image,
    this.sellerId,
    this.parentId,
    this.attributes,
    this.message,
    this.response,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.answer,
    this.user,
    this.getReviewReply,
  });

  int? id;
  int? userId;
  int? productId;
  int? rating;
  List<String>? image;
  int? sellerId;
  dynamic parentId;
  dynamic attributes;
  String? message;
  String? response;
  String? createdAt;
  DateTime? updatedAt;
  String? status;
  List<Answer>? answer;
  User? user;
  List<Answer>? getReviewReply;

  factory ReviewHeadingModel.fromJson(Map<String, dynamic> json) =>
      ReviewHeadingModel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        rating: json["rating"],
        image: List<String>.from(json["image"].map((x) => x)),
        sellerId: json["seller_id"],
        parentId: json["parent_id"],
        attributes: json["attributes"],
        message: json["message"],
        response: json["response"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        answer:
            List<Answer>.from(json["answer"].map((x) => Answer.fromJson(x))),
        user: User.fromJson(json["user"]),
        getReviewReply: List<Answer>.from(
            json["get_review_reply"].map((x) => Answer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "rating": rating,
        "image": List<dynamic>.from(image!.map((x) => x)),
        "seller_id": sellerId,
        "parent_id": parentId,
        "attributes": attributes,
        "message": message,
        "response": response,
        "created_at": createdAt,
        "updated_at": updatedAt!.toIso8601String(),
        "status": status,
        "answer": List<dynamic>.from(answer!.map((x) => x.toJson())),
        "user": user!.toJson(),
        "get_review_reply":
            List<dynamic>.from(getReviewReply!.map((x) => x.toJson())),
      };
}

class Answer {
  Answer({
    this.id,
    this.reviewId,
    this.reply,
    this.userId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? reviewId;
  String? reply;
  int? userId;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        reviewId: json["review_id"],
        reply: json["reply"],
        userId: json["user_id"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "review_id": reviewId,
        "reply": reply,
        "user_id": userId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.status,
    this.photo,
    this.province,
    this.district,
    this.area,
    this.zip,
    this.companyName,
    this.verifyToken,
    this.verifyOtp,
    this.emailVerifiedAt,
    this.socialProvider,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.fbId,
    this.googleId,
    this.data,
    this.socialite,
    this.userId,
    this.deletedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic phone;
  String? address;
  String? status;
  String? photo;
  String? province;
  String? district;
  String? area;
  dynamic zip;
  dynamic companyName;
  String? verifyToken;
  int? verifyOtp;
  DateTime? emailVerifiedAt;
  String? socialProvider;
  String? providerId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic fbId;
  dynamic googleId;
  String? data;
  String? socialite;
  int? userId;
  dynamic deletedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        status: json["status"],
        photo: json["photo"],
        province: json["province"],
        district: json["district"],
        area: json["area"],
        zip: json["zip"],
        companyName: json["company_name"],
        verifyToken: json["verify_token"],
        verifyOtp: json["verify_otp"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        socialProvider: json["social_provider"],
        providerId: json["provider_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        fbId: json["fb_id"],
        googleId: json["google_id"],
        data: json["data"],
        socialite: json["socialite"],
        userId: json["user_id"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "status": status,
        "photo": photo,
        "province": province,
        "district": district,
        "area": area,
        "zip": zip,
        "company_name": companyName,
        "verify_token": verifyToken,
        "verify_otp": verifyOtp,
        "email_verified_at": emailVerifiedAt!.toIso8601String(),
        "social_provider": socialProvider,
        "provider_id": providerId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "fb_id": fbId,
        "google_id": googleId,
        "data": data,
        "socialite": socialite,
        "user_id": userId,
        "deleted_at": deletedAt,
      };
}
