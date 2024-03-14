class UserReviewModel {
  bool? error;
  List<UserReviewData>? data;
  String? msg;

  UserReviewModel({this.error, this.data, this.msg});

  UserReviewModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <UserReviewData>[];
      json['data'].forEach((v) {
        data!.add(UserReviewData.fromJson(v));
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

class UserReviewData {
  int? id;
  int? userId;
  int? productId;
  int? rating;
  String? image;
  dynamic attributes;
  String? message;
  User? user;
  Product? product;

  UserReviewData(
      {this.id,
      this.userId,
      this.productId,
      this.rating,
      this.image,
      this.attributes,
      this.message,
      this.user,
      this.product});

  UserReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    rating = json['rating'];
    image = json['image'];
    attributes = json['attributes'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['rating'] = rating;
    data['image'] = image;
    data['attributes'] = attributes;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  dynamic status;
  String? photo;
  String? province;
  String? district;
  String? area;
  int? zip;
  String? companyName;
  String? verifyToken;
  int? verifyOtp;
  dynamic userId;
  String? emailVerifiedAt;
  String? socialProvider;

  User(
      {this.id,
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
      this.userId,
      this.emailVerifiedAt,
      this.socialProvider});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    photo = json['photo'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    zip = json['zip'];
    companyName = json['company_name'];
    verifyToken = json['verify_token'];
    verifyOtp = json['verify_otp'];
    userId = json['user_id'];
    emailVerifiedAt = json['email_verified_at'];
    socialProvider = json['social_provider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    data['photo'] = photo;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['zip'] = zip;
    data['company_name'] = companyName;
    data['verify_token'] = verifyToken;
    data['verify_otp'] = verifyOtp;
    data['user_id'] = userId;
    data['email_verified_at'] = emailVerifiedAt;
    data['social_provider'] = socialProvider;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? totalSell;
  String? shortDescription;
  String? longDescription;
  String? minOrder;
  String? returnableTime;
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
  String? url;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.totalSell,
      this.shortDescription,
      this.longDescription,
      this.minOrder,
      this.returnableTime,
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
      this.url,
      this.createdAt,
      this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    totalSell = json['total_sell'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    minOrder = json['min_order'];
    returnableTime = json['returnable_time'];
    deliveryTime = json['delivery_time'];
    keyword = json['keyword'];
    packageWeight = json['package_weight'];
    dimensionLength = json['dimension_length'];
    dimensionWidth = json['dimension_width'];
    dimensionHeight = json['dimension_height'];
    warrantyType = json['warranty_type'];
    warrantyPeriod = json['warranty_period'];
    warrantyPolicy = json['warranty_policy'];
    brandId = json['brand_id'];
    countryId = json['country_id'];
    categoryId = json['category_id'];
    userId = json['user_id'];
    rating = json['rating'];
    publishStatus = json['publishStatus'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['total_sell'] = totalSell;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['min_order'] = minOrder;
    data['returnable_time'] = returnableTime;
    data['delivery_time'] = deliveryTime;
    data['keyword'] = keyword;
    data['package_weight'] = packageWeight;
    data['dimension_length'] = dimensionLength;
    data['dimension_width'] = dimensionWidth;
    data['dimension_height'] = dimensionHeight;
    data['warranty_type'] = warrantyType;
    data['warranty_period'] = warrantyPeriod;
    data['warranty_policy'] = warrantyPolicy;
    data['brand_id'] = brandId;
    data['country_id'] = countryId;
    data['category_id'] = categoryId;
    data['user_id'] = userId;
    data['rating'] = rating;
    data['publishStatus'] = publishStatus;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
