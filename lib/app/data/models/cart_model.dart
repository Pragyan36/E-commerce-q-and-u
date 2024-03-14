class CartModel {
  bool? error;
  List<CartModelData>? data;
  int? totalAmount;
  String? materialPrice;
  int? totalQty;
  int? vat;
  int? grandTotal;
  String? msg;

  CartModel(
      {this.error,
      this.data,
      this.totalAmount, this.materialPrice,
      this.totalQty,
      this.vat,
      this.grandTotal,
      this.msg});

  CartModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <CartModelData>[];
      json['data'].forEach((v) {
        data!.add(CartModelData.fromJson(v));
      });
    }
    totalAmount = json['total_amount'];
    materialPrice = json['material_price'];
    totalQty = json['total_qty'];
    vat = json['vat'];
    grandTotal = json['grand_total'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_amount'] = totalAmount;
    data['material_price'] = materialPrice;
    data['total_qty'] = totalQty;
    data['vat'] = vat;
    data['grand_total'] = grandTotal;
    data['msg'] = msg;
    return data;
  }
}

class CartModelData {
  int? id;
  int? userId;
  int? totalPrice;
  int? totalQty;
  int? totalDiscount;
  String? createdAt;
  String? updatedAt;
  List<CartAssets>? cartAssets;

  CartModelData(
      {this.id,
      this.userId,
      this.totalPrice,
      this.totalQty,
      this.totalDiscount,
      this.createdAt,
      this.updatedAt,
      this.cartAssets});

  CartModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalPrice = json['total_price'];
    totalQty = json['total_qty'];
    totalDiscount = json['total_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['cart_assets'] != null) {
      cartAssets = <CartAssets>[];
      json['cart_assets'].forEach((v) {
        cartAssets!.add(CartAssets.fromJson(v));
      });
    }
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
    if (cartAssets != null) {
      data['cart_assets'] = cartAssets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartAssets {
  int? id;
  int? cartId;
  int? productId;
  String? productName;
  int? price;
  int? qty;
  int? subTotalPrice;
  String? color;
  String? image;
  int? discount;
  int? varientId;
  int? isOrdered;
  int? vatamountfield;
  List<ProductImage>? productImage;
  String? options;
  String? createdAt;
  String? updatedAt;
  String? slug;

  CartAssets(
      {this.id,
      this.cartId,
      this.productId,
      this.productName,
      this.price,
      this.qty,
      this.subTotalPrice,
      this.color,
      this.image,
      this.discount,
      this.varientId,
      this.isOrdered,
      this.vatamountfield,
      this.productImage,
      this.options,
      this.slug,
      this.createdAt,
      this.updatedAt});

  CartAssets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cartId = json['cart_id'];
    slug = json['slug'];
    productId = json['product_id'];
    productName = json['product_name'];
    price = json['price'];
    qty = json['qty'];
    subTotalPrice = json['sub_total_price'];
    color = json['color'];
    image = json['image'];
    discount = json['discount'];
    varientId = json['varient_id'];
    isOrdered = json['is_ordered'];
    vatamountfield = json['vatamountfield'];
    if (json['product_image'] != null) {
      productImage = <ProductImage>[];
      json['product_image'].forEach((v) {
        productImage!.add(ProductImage.fromJson(v));
      });
    }
    options = json['options'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cart_id'] = cartId;
    data['slug'] = slug;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['price'] = price;
    data['qty'] = qty;
    data['sub_total_price'] = subTotalPrice;
    data['color'] = color;
    data['image'] = image;
    data['discount'] = discount;
    data['varient_id'] = varientId;
    data['is_ordered'] = isOrdered;
    data['vatamountfield'] = vatamountfield;
    if (productImage != null) {
      data['product_image'] =
          productImage!.map((v) => v.toJson()).toList();
    }
    data['options'] = options;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ProductImage {
  int? id;
  String? image;
  int? colorId;
  int? productId;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;

  ProductImage(
      {this.id,
      this.image,
      this.colorId,
      this.productId,
      this.isFeatured,
      this.createdAt,
      this.updatedAt});

  ProductImage.fromJson(Map<String, dynamic> json) {
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
