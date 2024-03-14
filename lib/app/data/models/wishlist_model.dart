class Wishlist {
  bool? error;
  WishlistData? data;
  String? msg;

  Wishlist({this.error, this.data, this.msg});

  Wishlist.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? WishlistData.fromJson(json['data']) : null;
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

class WishlistData {
  List<GetProduct>? getProduct;

  WishlistData({this.getProduct});

  WishlistData.fromJson(Map<String, dynamic> json) {
    if (json['get_product'] != null) {
      getProduct = <GetProduct>[];
      json['get_product'].forEach((v) {
        getProduct!.add(GetProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getProduct != null) {
      data['get_product'] = getProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetProduct {
  int? id;
  String? name;
  String? slug;
  String? rating;
  int? varientId;
  List<Images>? images;
  GetPrice? getPrice;

  GetProduct(
      {this.id,
      this.name,
      this.slug,
      this.rating,
      this.varientId,
      this.images,
      this.getPrice});

  GetProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    rating = json['rating'];
    varientId = json['varient_id'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    getPrice =
        json['get_price'] != null ? GetPrice.fromJson(json['get_price']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['rating'] = rating;
    data['varient_id'] = varientId;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (getPrice != null) {
      data['get_price'] = getPrice!.toJson();
    }
    return data;
  }
}

class Images {
  int? id;
  String? image;

  Images({this.id, this.image});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}

class GetPrice {
  int? id;
  int? productId;
  int? colorId;
  int? price;
  int? specialPrice;
  String? specialFrom;
  String? specialTo;
  int? quantity;
  int? freeItems;
  String? sellersku;
  String? createdAt;
  String? updatedAt;

  GetPrice(
      {this.id,
      this.productId,
      this.colorId,
      this.price,
      this.specialPrice,
      this.specialFrom,
      this.specialTo,
      this.quantity,
      this.freeItems,
      this.sellersku,
      this.createdAt,
      this.updatedAt});

  GetPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    price = json['price'];
    specialPrice = json['special_price'];
    specialFrom = json['special_from'];
    specialTo = json['special_to'];
    quantity = json['quantity'];
    freeItems = json['free_items'];
    sellersku = json['sellersku'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['color_id'] = colorId;
    data['price'] = price;
    data['special_price'] = specialPrice;
    data['special_from'] = specialFrom;
    data['special_to'] = specialTo;
    data['quantity'] = quantity;
    data['free_items'] = freeItems;
    data['sellersku'] = sellersku;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
