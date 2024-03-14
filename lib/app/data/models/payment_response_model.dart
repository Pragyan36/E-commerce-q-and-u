/*
class PaymentResponseModel {
  bool? error;
  PaymentData? data;
  String? msg;

  PaymentResponseModel({this.error, this.data, this.msg});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? new PaymentData.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class PaymentData {
  OrderDetails? orderDetails;

  PaymentData({this.orderDetails});

  PaymentData.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? new OrderDetails.fromJson(json['order_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails!.toJson();
    }
    return data;
  }
}

class OrderDetails {
  int? userId;
  String? affId;
  int? totalQuantity;
  int? totalPrice;
  String? refId;
  int? totalDiscount;
  int? paymentStatus;
  String? merchantName;
  String? paymentWith;
  String? paymentDate;
  String? transactionRefId;
  String? name;
  String? email;
  String? phone;
  String? province;
  String? district;
  String? area;
  String? additionalAddress;
  int? zip;
  String? bName;
  String? bEmail;
  String? bPhone;
  String? bProvince;
  String? bDistrict;
  String? bArea;
  String? bAdditionalAddress;
  int? bZip;
  String? updatedAt;
  String? createdAt;
  int? id;

  OrderDetails(
      {this.userId,
      this.affId,
      this.totalQuantity,
      this.totalPrice,
      this.refId,
      this.totalDiscount,
      this.paymentStatus,
      this.merchantName,
      this.paymentWith,
      this.paymentDate,
      this.transactionRefId,
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
      this.updatedAt,
      this.createdAt,
      this.id});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    affId = json['aff_id'];
    totalQuantity = json['total_quantity'];
    totalPrice = json['total_price'];
    refId = json['ref_id'];
    totalDiscount = json['total_discount'];
    paymentStatus = json['payment_status'];
    merchantName = json['merchant_name'];
    paymentWith = json['payment_with'];
    paymentDate = json['payment_date'];
    transactionRefId = json['transaction_ref_id'];
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
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['aff_id'] = this.affId;
    data['total_quantity'] = this.totalQuantity;
    data['total_price'] = this.totalPrice;
    data['ref_id'] = this.refId;
    data['total_discount'] = this.totalDiscount;
    data['payment_status'] = this.paymentStatus;
    data['merchant_name'] = this.merchantName;
    data['payment_with'] = this.paymentWith;
    data['payment_date'] = this.paymentDate;
    data['transaction_ref_id'] = this.transactionRefId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['district'] = this.district;
    data['area'] = this.area;
    data['additional_address'] = this.additionalAddress;
    data['zip'] = this.zip;
    data['b_name'] = this.bName;
    data['b_email'] = this.bEmail;
    data['b_phone'] = this.bPhone;
    data['b_province'] = this.bProvince;
    data['b_district'] = this.bDistrict;
    data['b_area'] = this.bArea;
    data['b_additional_address'] = this.bAdditionalAddress;
    data['b_zip'] = this.bZip;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
*/

class PaymentResponseModel {
  bool? error;
  PaymentData? data;
  String? msg;

  PaymentResponseModel({this.error, this.data, this.msg});

  PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? PaymentData.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['msg'] = msg;
    return data;
  }
}

class KhaltiPaymentModel {
  String? pidx;
  String? paymentUrl;

  KhaltiPaymentModel({this.paymentUrl, this.pidx});

  KhaltiPaymentModel.fromJson(Map<String, dynamic> json) {
    pidx = json['pidx'];
    paymentUrl = json['payment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pidx'] = pidx;
    data['payment_url'] = paymentUrl;
    return data;
  }
}

class PaymentVerification {
  String? pidx;
  int? totalAmount;
  String? status;
  int? transactionId;
  int? fee;
  bool? refunded;

  PaymentVerification(
      {this.pidx,
      this.totalAmount,
      this.status,
      this.transactionId,
      this.fee,
      this.refunded});

  PaymentVerification.fromJson(Map<String, dynamic> json) {
    pidx = json['pidx'];
    totalAmount = json['total_amount'];
    status = json['status'];
    transactionId = json['transaction_id'];
    fee = json['fee'];
    refunded = json['refunded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pidx'] = pidx;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['transaction_id'] = transactionId;
    data['fee'] = fee;
    data['refunded'] = refunded;
    return data;
  }
}

class PaymentData {
  OrderDetails? orderDetails;
  String? pdfUrl;

  PaymentData({this.orderDetails, this.pdfUrl});

  PaymentData.fromJson(Map<String, dynamic> json) {
    orderDetails = json['order_details'] != null
        ? OrderDetails.fromJson(json['order_details'])
        : null;
    pdfUrl = json['pdf_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.toJson();
      data['pdf_url'] = pdfUrl;
    }
    return data;
  }
}

class OrderDetails {
  int? userId;
  String? affId;
  int? totalQuantity;
  int? totalPrice;
  String? refId;
  int? totalDiscount;
  String? paymentStatus;
  String? merchantName;
  String? paymentWith;
  String? paymentDate;
  String? transactionRefId;
  String? name;
  String? email;
  String? phone;
  String? province;
  String? district;
  String? area;
  String? additionalAddress;
  int? zip;
  String? bName;
  String? bEmail;
  String? bPhone;
  String? bProvince;
  String? bDistrict;
  String? bArea;
  String? bAdditionalAddress;
  int? bZip;
  String? updatedAt;
  String? createdAt;
  int? id;

  OrderDetails(
      {this.userId,
      this.affId,
      this.totalQuantity,
      this.totalPrice,
      this.refId,
      this.totalDiscount,
      this.paymentStatus,
      this.merchantName,
      this.paymentWith,
      this.paymentDate,
      this.transactionRefId,
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
      this.updatedAt,
      this.createdAt,
      this.id});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    affId = json['aff_id'];
    totalQuantity = json['total_quantity'];
    totalPrice = json['total_price'];
    refId = json['ref_id'];
    totalDiscount = json['total_discount'];
    paymentStatus = json['payment_status'];
    merchantName = json['merchant_name'];
    paymentWith = json['payment_with'];
    paymentDate = json['payment_date'];
    transactionRefId = json['transaction_ref_id'];
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
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['aff_id'] = affId;
    data['total_quantity'] = totalQuantity;
    data['total_price'] = totalPrice;
    data['ref_id'] = refId;
    data['total_discount'] = totalDiscount;
    data['payment_status'] = paymentStatus;
    data['merchant_name'] = merchantName;
    data['payment_with'] = paymentWith;
    data['payment_date'] = paymentDate;
    data['transaction_ref_id'] = transactionRefId;
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
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
