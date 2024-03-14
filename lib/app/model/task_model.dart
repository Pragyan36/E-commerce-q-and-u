class TaskModel {
  int? status;
  bool? error;
  Data? data;

  TaskModel({this.status, this.error, this.data});

  TaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Tasks>? tasks;
  List<StaffTasks>? staffTasks;

  Data({this.tasks, this.staffTasks});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
    if (json['staff_tasks'] != null) {
      staffTasks = <StaffTasks>[];
      json['staff_tasks'].forEach((v) {
        staffTasks!.add(StaffTasks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (staffTasks != null) {
      data['staff_tasks'] = staffTasks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tasks {
  int? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  String? startDate;
  String? dueDate;
  int? actionId;
  int? orderId;
  int? productId;
  int? assignedBy;
  int? createdBy;
  int? updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? reassignedBy;
  String? reassignDateTime;
  Order? order;
  Action? action;

  Tasks(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.priority,
      this.startDate,
      this.dueDate,
      this.actionId,
      this.orderId,
      this.productId,
      this.assignedBy,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.reassignedBy,
      this.reassignDateTime,
      this.order,
      this.action});

  Tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    actionId = json['action_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    assignedBy = json['assigned_by'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    reassignedBy = json['reassigned_by'];
    reassignDateTime = json['reassign_date_time'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    action =
        json['action'] != null ? Action.fromJson(json['action']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['priority'] = priority;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['action_id'] = actionId;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['assigned_by'] = assignedBy;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['reassigned_by'] = reassignedBy;
    data['reassign_date_time'] = reassignDateTime;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (action != null) {
      data['action'] = action!.toJson();
    }
    return data;
  }
}

class Order {
  int? id;
  int? userId;
  int? shippingCharge;
  int? totalQuantity;
  int? totalPrice;
  String? refId;
  int? totalDiscount;
  dynamic couponName;
  int? couponDiscountPrice;
  dynamic couponCode;
  int? pending;
  int? readyToShip;
  int? paymentStatus;
  int? deletedByCustomer;
  int? failedDelivery;
  dynamic merchantName;
  String? paymentWith;
  dynamic transactionRefId;
  String? paymentDate;
  dynamic mobile;
  int? approved;
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
  String? sellerApprove;
  String? adminApprove;
  String? createdAt;
  String? updatedAt;
  String? status;
  int? isNew;
  int? vatAmount;
  List<OrderAssets>? orderAssets;

  Order(
      {this.id,
      this.userId,
      this.shippingCharge,
      this.totalQuantity,
      this.totalPrice,
      this.refId,
      this.totalDiscount,
      this.couponName,
      this.couponDiscountPrice,
      this.couponCode,
      this.pending,
      this.readyToShip,
      this.paymentStatus,
      this.deletedByCustomer,
      this.failedDelivery,
      this.merchantName,
      this.paymentWith,
      this.transactionRefId,
      this.paymentDate,
      this.mobile,
      this.approved,
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
      this.sellerApprove,
      this.adminApprove,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.isNew,
      this.vatAmount,
      this.orderAssets});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    shippingCharge = json['shipping_charge'];
    totalQuantity = json['total_quantity'];
    totalPrice = json['total_price'];
    refId = json['ref_id'];
    totalDiscount = json['total_discount'];
    couponName = json['coupon_name'];
    couponDiscountPrice = json['coupon_discount_price'];
    couponCode = json['coupon_code'];
    pending = json['pending'];
    readyToShip = json['ready_to_ship'];
    paymentStatus = json['payment_status'];
    deletedByCustomer = json['deleted_by_customer'];
    failedDelivery = json['failed_delivery'];
    merchantName = json['merchant_name'];
    paymentWith = json['payment_with'];
    transactionRefId = json['transaction_ref_id'];
    paymentDate = json['payment_date'];
    mobile = json['mobile'];
    approved = json['approved'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    province = json['province'];
    district = json['district'];
    area = json['area'];
    additionalAddress = json['additional_address'];
    zip = json['zip'];
    bName = json['b_name'];
    bEmail = json['b_email'];
    bPhone = json['b_phone'];
    bProvince = json['b_province'];
    bDistrict = json['b_district'];
    bArea = json['b_area'];
    bAdditionalAddress = json['b_additional_address'];
    bZip = json['b_zip'];
    sellerApprove = json['seller_approve'];
    adminApprove = json['admin_approve'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    isNew = json['is_new'];
    vatAmount = json['vat_amount'];
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
    data['shipping_charge'] = shippingCharge;
    data['total_quantity'] = totalQuantity;
    data['total_price'] = totalPrice;
    data['ref_id'] = refId;
    data['total_discount'] = totalDiscount;
    data['coupon_name'] = couponName;
    data['coupon_discount_price'] = couponDiscountPrice;
    data['coupon_code'] = couponCode;
    data['pending'] = pending;
    data['ready_to_ship'] = readyToShip;
    data['payment_status'] = paymentStatus;
    data['deleted_by_customer'] = deletedByCustomer;
    data['failed_delivery'] = failedDelivery;
    data['merchant_name'] = merchantName;
    data['payment_with'] = paymentWith;
    data['transaction_ref_id'] = transactionRefId;
    data['payment_date'] = paymentDate;
    data['mobile'] = mobile;
    data['approved'] = approved;
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
    data['seller_approve'] = sellerApprove;
    data['admin_approve'] = adminApprove;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['is_new'] = isNew;
    data['vat_amount'] = vatAmount;
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
  String? image;
  int? discount;
  List<Options>? options;
  String? createdAt;
  String? updatedAt;
  String? cancelStatus;
  int? vatamountfield;
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
      this.image,
      this.discount,
      this.options,
      this.createdAt,
      this.updatedAt,
      this.cancelStatus,
      this.vatamountfield,
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
    image = json['image'];
    discount = json['discount'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    cancelStatus = json['cancel_status'];
    vatamountfield = json['vatamountfield'];
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
    data['image'] = image;
    data['discount'] = discount;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cancel_status'] = cancelStatus;
    data['vatamountfield'] = vatamountfield;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Options {
  dynamic id;
  String? title;
  String? value;

  Options({this.id, this.title, this.value});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  int? vatPercent;
  String? shortDescription;
  String? longDescription;
  String? minOrder;
  String? returnableTime;
  dynamic returnPolicy;
  String? deliveryTime;
  dynamic keyword;
  String? packageWeight;
  dynamic dimensionLength;
  dynamic dimensionWidth;
  dynamic dimensionHeight;
  String? warrantyType;
  dynamic warrantyPeriod;
  dynamic warrantyPolicy;
  int? brandId;
  dynamic countryId;
  int? categoryId;
  int? userId;
  String? rating;
  bool? publishStatus;
  int? isNew;
  String? status;
  dynamic url;
  String? createdAt;
  String? updatedAt;
  int? sellerId;
  int? totalSell;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  String? ogImage;
  dynamic deletedAt;
  int? policyData;

  Product(
      {this.id,
      this.name,
      this.slug,
      this.vatPercent,
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
      this.policyData});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    vatPercent = json['vat_percent'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    minOrder = json['min_order'];
    returnableTime = json['returnable_time'];
    returnPolicy = json['return_policy'];
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
    isNew = json['is_new'];
    status = json['status'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sellerId = json['seller_id'];
    totalSell = json['total_sell'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    ogImage = json['og_image'];
    deletedAt = json['deleted_at'];
    policyData = json['policy_data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['vat_percent'] = vatPercent;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['min_order'] = minOrder;
    data['returnable_time'] = returnableTime;
    data['return_policy'] = returnPolicy;
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
    data['is_new'] = isNew;
    data['status'] = status;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['seller_id'] = sellerId;
    data['total_sell'] = totalSell;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['og_image'] = ogImage;
    data['deleted_at'] = deletedAt;
    data['policy_data'] = policyData;
    return data;
  }
}

class Action {
  int? id;
  String? title;
  int? status;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Action(
      {this.id,
      this.title,
      this.status,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Action.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class StaffTasks {
  int? id;
  String? title;
  String? description;
  String? status;
  String? priority;
  String? startDate;
  String? dueDate;
  int? actionId;
  int? orderId;
  dynamic productId;
  int? assignedBy;
  int? createdBy;
  int? updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? reassignedBy;
  String? reassignDateTime;

  StaffTasks(
      {this.id,
      this.title,
      this.description,
      this.status,
      this.priority,
      this.startDate,
      this.dueDate,
      this.actionId,
      this.orderId,
      this.productId,
      this.assignedBy,
      this.createdBy,
      this.updatedBy,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.reassignedBy,
      this.reassignDateTime});

  StaffTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    priority = json['priority'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    actionId = json['action_id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    assignedBy = json['assigned_by'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    reassignedBy = json['reassigned_by'];
    reassignDateTime = json['reassign_date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['status'] = status;
    data['priority'] = priority;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['action_id'] = actionId;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['assigned_by'] = assignedBy;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['reassigned_by'] = reassignedBy;
    data['reassign_date_time'] = reassignDateTime;
    return data;
  }
}