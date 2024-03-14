class UserOrder {
  bool? error;
  List<UserOrderData>? data;
  String? msg;

  UserOrder({this.error, this.data, this.msg});

  UserOrder.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <UserOrderData>[];
      json['data'].forEach((v) {
        data!.add(UserOrderData.fromJson(v));
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

class UserOrderData {
  int? id;
  int? userId;
  String? affId;
  int? totalQuantity;
  int? totalPrice;
  String? refId;
  int? totalDiscount;
  String? couponName;
  int? pending;
  int? readyToShip;
  String? shipped;
  String? delivered;
  String? cancelled;
  int? paymentStatus;
  int? deletedByCustomer;
  int? failedDelivery;
  String? merchantName;
  String? paymentWith;
  String? transactionRefId;
  String? paymentDate;
  String? name;
  String? email;
  String? phone;
  String? province;
  String? district;
  String? area;
  String? additionalAddress;
  String? zip;
  String? bName;
  String? bEmail;
  String? bPhone;
  String? bProvince;
  String? bDistrict;
  String? bArea;
  String? bAdditionalAddress;
  String? bZip;
  String? mobile;
  String? createdAt;
  String? updatedAt;
  String? statusvalue;
  String? refundStatusValue;
  String? refundRejectReason;
  bool? cancelReasonStatus;
  List<OrderAssets>? orderAssets;
  bool? refundStatus;
  String? pdf_url;
  bool? cancelStatus;

  UserOrderData({
    this.id,
    this.userId,
    this.pdf_url,
    this.affId,
    this.totalQuantity,
    this.refundStatusValue,
    this.refundRejectReason,
    this.totalPrice,
    this.refId,
    this.totalDiscount,
    this.couponName,
    this.pending,
    this.readyToShip,
    this.shipped,
    this.delivered,
    this.cancelled,
    this.paymentStatus,
    this.deletedByCustomer,
    this.failedDelivery,
    this.merchantName,
    this.paymentWith,
    this.transactionRefId,
    this.paymentDate,
    this.name,
    this.email,
    this.phone,
    this.province,
    this.district,
    this.area,
    this.additionalAddress,
    this.zip,
    this.bName,
    this.bEmail,
    this.bPhone,
    this.bProvince,
    this.bDistrict,
    this.bArea,
    this.bAdditionalAddress,
    this.bZip,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.orderAssets,
    this.statusvalue,
    this.cancelStatus,
    this.refundStatus,
    this.cancelReasonStatus,
  });

  UserOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    pdf_url=json['pdf_url'];
    affId = json['aff_id'];
    totalQuantity = json['total_quantity'];
    refundRejectReason = json['refundRejectReason'];
    refundStatusValue = json['refundStatusValue'];
    totalPrice = json['total_price'];
    refId = json['ref_id'];
    totalDiscount = json['total_discount'];
    couponName = json['coupon_name'];
    pending = json['pending'];
    readyToShip = json['ready_to_ship'];
    shipped = json['shipped'];
    delivered = json['delivered'];
    cancelled = json['cancelled'];
    paymentStatus = json['payment_status'];
    deletedByCustomer = json['deleted_by_customer'];
    failedDelivery = json['failed_delivery'];
    merchantName = json['merchant_name'];
    paymentWith = json['payment_with'];
    transactionRefId = json['transaction_ref_id'];
    paymentDate = json['payment_date'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    cancelStatus = json['cancelStatus'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    additionalAddress = json['additional_address'];
    zip = json['zip'];
    bName = json['b_name'];
    statusvalue = json['status_value'];
    bEmail = json['b_email'];
    bPhone = json['b_phone'];
    bProvince = json['b_province'];
    bDistrict = json['b_district'];
    bArea = json['b_area'];
    refundStatus = json['refundStatus'];

    bAdditionalAddress = json['b_additional_address'];
    bZip = json['b_zip'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cancelReasonStatus = json['cancelReasonStatus'];
    if (json['order_assets'] != null) {
      orderAssets = <OrderAssets>[];
      json['order_assets'].forEach((v) {
        orderAssets!.add(OrderAssets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['pdf_url']=pdf_url;
    data['aff_id'] = affId;
    data['refundStatus'] = refundStatus;
    data['refundStatusValue'] = refundStatusValue;
    data['refundRejectReason'] = refundRejectReason;
    data['total_quantity'] = totalQuantity;
    data['total_price'] = totalPrice;
    data['ref_id'] = refId;
    data['total_discount'] = totalDiscount;
    data['coupon_name'] = couponName;
    data['pending'] = pending;
    data['status_value'] = statusvalue;
    data['ready_to_ship'] = readyToShip;
    data['shipped'] = shipped;
    data['delivered'] = delivered;
    data['cancelled'] = cancelled;
    data['cancelStatus'] = cancelStatus;
    data['payment_status'] = paymentStatus;
    data['deleted_by_customer'] = deletedByCustomer;
    data['failed_delivery'] = failedDelivery;
    data['merchant_name'] = merchantName;
    data['payment_with'] = paymentWith;
    data['transaction_ref_id'] = transactionRefId;
    data['payment_date'] = paymentDate;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['province'] = province;
    data['district'] = district;
    data['area'] = area;
    data['additional_address'] = additionalAddress;
    data['zip'] = zip;
    data['b_name'] = bName;
    data['b_email'] = bEmail;
    data['b_phone'] = bPhone;
    data['b_province'] = bProvince;
    data['b_district'] = bDistrict;
    data['b_area'] = bArea;
    data['b_additional_address'] = bAdditionalAddress;
    data['b_zip'] = bZip;
    data['mobile'] = mobile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cancelReasonStatus'] = cancelReasonStatus;
    if (orderAssets != null) {
      data['order_assets'] = orderAssets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderAssets {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  int? price;
  int? qty;
  int? subTotalPrice;
  String? color;
  int? discount;
  String? createdAt;
  String? updatedAt;
  Product? product;

  OrderAssets(
      {this.id,
      this.orderId,
      this.productId,
      this.productName,
      this.price,
      this.qty,
      this.subTotalPrice,
      this.color,
      this.discount,
      this.createdAt,
      this.updatedAt,
      this.product});

  OrderAssets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    subTotalPrice = json['sub_total_price'];
    color = json['color'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['price'] = price;
    data['qty'] = qty;
    data['sub_total_price'] = subTotalPrice;
    data['color'] = color;
    data['discount'] = discount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
  String? onSale;
  String? newArrival;
  String? topRanked;
  String? minOrder;
  String? returnableTime;
  String? deliveryTime;
  String? keyword;
  String? packageWeight;
  String? dimensionLength;
  String? dimensionWidth;
  String? dimensionHeight;
  String? warrantyType;
  String? warrantyPeriod;
  String? warrantyPolicy;
  int? brandId;
  int? countryId;
  int? categoryId;
  int? userId;
  String? rating;
  bool? publishStatus;
  String? url;
  String? createdAt;
  String? updatedAt;
  List<Images>? images;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.shortDescription,
      this.longDescription,
      this.onSale,
      this.newArrival,
      this.topRanked,
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
      this.updatedAt,
      this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    onSale = json['on_sale'];
    newArrival = json['new_arrival'];
    topRanked = json['top_ranked'];
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
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['on_sale'] = onSale;
    data['new_arrival'] = newArrival;
    data['top_ranked'] = topRanked;
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
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  String? image;
  int? colorId;
  int? productId;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
      this.image,
      this.colorId,
      this.productId,
      this.isFeatured,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    colorId = json['color_id'];
    productId = json['product_id'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['color_id'] = colorId;
    data['product_id'] = productId;
    data['is_featured'] = isFeatured;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
