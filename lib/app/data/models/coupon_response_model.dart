class CouponResponseModel {
  bool? error;
  CouponResponseData? data;

  CouponResponseModel({this.error, this.data});

  CouponResponseModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null
        ? CouponResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CouponResponseData {
  int? discountAmount;
  int? totalCartAmount;
  int? totalCartAmountAfterDiscount;

  CouponResponseData(
      {this.discountAmount,
      this.totalCartAmount,
      this.totalCartAmountAfterDiscount});

  CouponResponseData.fromJson(Map<String, dynamic> json) {
    discountAmount = json['discount_amount'];
    totalCartAmount = json['total_cart_amount'];
    totalCartAmountAfterDiscount = json['total_cart_amount_after_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount_amount'] = discountAmount;
    data['total_cart_amount'] = totalCartAmount;
    data['total_cart_amount_after_discount'] =
        totalCartAmountAfterDiscount;
    return data;
  }
}
