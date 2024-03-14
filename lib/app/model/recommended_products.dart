class RecommendedProducts {
  List<RecommendedProductsData>? data;
  bool? error;
  String? msg;

  RecommendedProducts({
    this.data,
    this.error,
    this.msg,
  });

  RecommendedProducts.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    if (json["data"] != null) {
      data = List.from(json['data'])
          .map((e) => RecommendedProductsData.fromJson(e))
          .toList();
    }
    msg = json["msg"];
  }

  Map<String, dynamic> toJson() {
    final mainData = <String, dynamic>{};
    mainData["error"] = error;
    if (data != null) {
      mainData['data'] = data!.map((e) => e.toJson()).toList();
    }
    mainData["msg"] = msg;
    return mainData;
  }
}

class RecommendedProductsData {
  int? id;
  String? name;
  String? slug;
  String? rating;
  int? varientId;
  String? percent;
  List<Images>? images;
  List<Stocks>? stocks;
  List<dynamic>? getOfferProduct;

  RecommendedProductsData({
    this.id,
    this.name,
    this.slug,
    this.rating,
    this.varientId,
    this.percent,
    this.images,
    this.stocks,
    this.getOfferProduct,
  });

  RecommendedProductsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    rating = json['rating'];
    varientId = json['varient_id'];
    percent = null;
    if (json["images"] != null) {
      images =
          List.from(json['images']).map((e) => Images.fromJson(e)).toList();
    }
    if (json["stocks"] != null) {
      stocks =
          List.from(json['stocks']).map((e) => Stocks.fromJson(e)).toList();
    }
    if (json["get_offer_product"] != null) {
      getOfferProduct =
          List.castFrom<dynamic, dynamic>(json['get_offer_product']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['rating'] = rating;
    data['varient_id'] = varientId;
    data['percent'] = percent;
    if (images != null) {
      data['images'] = images!.map((e) => e.toJson()).toList();
    }
    if (stocks != null) {
      data['stocks'] = stocks!.map((e) => e.toJson()).toList();
    }
    data['get_offer_product'] = getOfferProduct;
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

  Images({
    this.id,
    this.image,
    this.colorId,
    this.productId,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    colorId = null;
    productId = json['product_id'];
    isFeatured = json['is_featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
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

class Stocks {
  Stocks({
    this.id,
    this.productId,
    this.colorId,
    this.price,
    this.specialPrice,
    this.specialTo,
    this.quantity,
    this.freeItems,
    this.sellersku,
    this.createdAt,
    this.updatedAt,
    this.additionalCharge,
    this.wholesaleprice,
    this.mimquantity,
  });
  int? id;
  int? productId;
  int? colorId;
  int? price;
  int? specialPrice;
  String? specialTo;
  int? quantity;
  int? freeItems;
  String? sellersku;
  String? createdAt;
  String? updatedAt;
  int? additionalCharge;
  int? wholesaleprice;
  int? mimquantity;

  Stocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    price = json['price'];
    specialPrice = json["special_price"];
    specialTo = json["special_to"];
    quantity = json['quantity'];
    freeItems = json["free_items"];
    sellersku = json["sellersku"];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    additionalCharge = json["additional_charge"];
    wholesaleprice = json['wholesaleprice'];
    mimquantity = json['mimquantity'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['color_id'] = colorId;
    data['price'] = price;
    data['special_price'] = specialPrice;
    data['special_to'] = specialTo;
    data['quantity'] = quantity;
    data['free_items'] = freeItems;
    data['sellersku'] = sellersku;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['additional_charge'] = additionalCharge;
    data['wholesaleprice'] = wholesaleprice;
    data['mimquantity'] = mimquantity;
    return data;
  }
}
