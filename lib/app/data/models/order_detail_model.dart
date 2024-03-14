class OrderDetailModel {
  bool? error;
  Data? data;
  String? msg;

  OrderDetailModel({this.error, this.data, this.msg});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? billId;
  List<CartDetail>? cartDetail;

  Data({this.billId, this.cartDetail});

  Data.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    if (json['cart_detail'] != null) {
      cartDetail = <CartDetail>[];
      json['cart_detail'].forEach((v) {
        cartDetail!.add(CartDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_id'] = billId;
    if (cartDetail != null) {
      data['cart_detail'] = cartDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartDetail {
  int? id;
  int? userId;
  int? totalPrice;
  int? totalQty;
  int? totalDiscount;
  String? createdAt;
  String? updatedAt;

  CartDetail(
      {this.id,
      this.userId,
      this.totalPrice,
      this.totalQty,
      this.totalDiscount,
      this.createdAt,
      this.updatedAt});

  CartDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    totalQty = json['total_qty'];
    totalDiscount = json['total_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['total_price'] = totalPrice;
    data['total_qty'] = totalQty;
    data['total_discount'] = totalDiscount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
