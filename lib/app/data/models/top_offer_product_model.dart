class TopOfferProductsModel {
  int? status;
  String? msg;
  TopOfferProductsModelData? data;

  TopOfferProductsModel({this.status, this.msg, this.data});

  TopOfferProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null
        ? TopOfferProductsModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TopOfferProductsModelData {
  dynamic n0;
  dynamic n1;
  int? id;
  String? title;
  String? slug;
  String? from;
  String? to;
  int? isFixed;
  int? offer;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<OfferProducts>? offerProducts;

  TopOfferProductsModelData(
      {this.n0,
      this.n1,
      this.id,
      this.title,
      this.slug,
      this.from,
      this.to,
      this.isFixed,
      this.offer,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.offerProducts});

  TopOfferProductsModelData.fromJson(Map<String, dynamic> json) {
    n0 = json['0'];
    n1 = json['1'];
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    from = json['from'];
    to = json['to'];
    isFixed = json['is_fixed'];
    offer = json['offer'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['offer_products'] != null) {
      offerProducts = <OfferProducts>[];
      json['offer_products'].forEach((v) {
        offerProducts!.add(OfferProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['0'] = n0;
    data['1'] = n1;
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['from'] = from;
    data['to'] = to;
    data['is_fixed'] = isFixed;
    data['offer'] = offer;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (offerProducts != null) {
      data['offer_products'] = offerProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OfferProducts {
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
  int? varientId;
  String? rating;
  bool? publishStatus;
  String? url;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;
  List<Stocks>? stocks;
  List<ProductImages>? productImages;

  OfferProducts(
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
      this.updatedAt,
      this.varientId,
      this.pivot,
      this.stocks,
      this.productImages});

  OfferProducts.fromJson(Map<String, dynamic> json) {
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
    varientId = json['varient_id'];
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
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
    data['varient_id'] = varientId;
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pivot {
  int? topOfferId;
  int? productId;

  Pivot({this.topOfferId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    topOfferId = json['top_offer_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['top_offer_id'] = topOfferId;
    data['product_id'] = productId;
    return data;
  }
}

class Stocks {
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

  Stocks(
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

  Stocks.fromJson(Map<String, dynamic> json) {
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

class ProductImages {
  int? id;
  String? image;
  int? colorId;
  int? productId;
  int? isFeatured;
  String? createdAt;
  String? updatedAt;

  ProductImages(
      {this.id,
      this.image,
      this.colorId,
      this.productId,
      this.isFeatured,
      this.createdAt,
      this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
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
