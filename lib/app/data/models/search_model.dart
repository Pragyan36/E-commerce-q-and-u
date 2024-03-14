class SearchModel {
  bool? error;
  List<SearchModelData>? data;
  String? msg;

  SearchModel({this.error, this.data, this.msg});

  SearchModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <SearchModelData>[];
      json['data'].forEach((v) {
        data!.add(SearchModelData.fromJson(v));
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

class SearchModelData {
  int? id;
  String? name;
  String? slug;
  int? vatPercent;
  String? shortDescription;
  String? longDescription;
  String? minOrder;
  String? returnableTime;
  Null returnPolicy;
  String? deliveryTime;
  String? packageWeight;
  String? dimensionLength;
  String? dimensionWidth;
  String? dimensionHeight;
  String? warrantyType;
  String? warrantyPeriod;
  Null warrantyPolicy;
  int? brandId;
  String? rating;
  int? isNew;
  String? status;
  Null url;
  int? sellerId;
  Null metaTitle;
  Null metaKeywords;
  Null metaDescription;
  Null ogImage;
  Null deletedAt;
  int? policyData;
  int? varientId;
  String? percent;
  List<Images>? images;
  GetPrice? getPrice;
  Null iswish;
  List<Stocks>? stocks;

  SearchModelData(
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
        this.packageWeight,
        this.dimensionLength,
        this.dimensionWidth,
        this.dimensionHeight,
        this.warrantyType,
        this.warrantyPeriod,
        this.warrantyPolicy,
        this.brandId,
        this.rating,
        this.isNew,
        this.status,
        this.url,
        this.sellerId,
        this.metaTitle,
        this.metaKeywords,
        this.metaDescription,
        this.ogImage,
        this.deletedAt,
        this.policyData,
        this.varientId,
        this.percent,
        this.images,
        this.getPrice,
        this.iswish,
        this.stocks});

  SearchModelData.fromJson(Map<String, dynamic> json) {
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
    packageWeight = json['package_weight'];
    dimensionLength = json['dimension_length'];
    dimensionWidth = json['dimension_width'];
    dimensionHeight = json['dimension_height'];
    warrantyType = json['warranty_type'];
    warrantyPeriod = json['warranty_period'];
    warrantyPolicy = json['warranty_policy'];
    brandId = json['brand_id'];
    rating = json['rating'];
    isNew = json['is_new'];
    status = json['status'];
    url = json['url'];
    sellerId = json['seller_id'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    ogImage = json['og_image'];
    deletedAt = json['deleted_at'];
    policyData = json['policy_data'];
    varientId = json['varient_id'];
    percent = json['percent'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    getPrice = json['get_price'] != null
        ? GetPrice.fromJson(json['get_price'])
        : null;
    iswish = json['iswish'];
    if (json['stocks'] != null) {
      stocks = <Stocks>[];
      json['stocks'].forEach((v) {
        stocks!.add(Stocks.fromJson(v));
      });
    }
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
    data['package_weight'] = packageWeight;
    data['dimension_length'] = dimensionLength;
    data['dimension_width'] = dimensionWidth;
    data['dimension_height'] = dimensionHeight;
    data['warranty_type'] = warrantyType;
    data['warranty_period'] = warrantyPeriod;
    data['warranty_policy'] = warrantyPolicy;
    data['brand_id'] = brandId;
    data['rating'] = rating;
    data['is_new'] = isNew;
    data['status'] = status;
    data['url'] = url;
    data['seller_id'] = sellerId;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['og_image'] = ogImage;
    data['deleted_at'] = deletedAt;
    data['policy_data'] = policyData;
    data['varient_id'] = varientId;
    data['percent'] = percent;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (getPrice != null) {
      data['get_price'] = getPrice!.toJson();
    }
    data['iswish'] = iswish;
    if (stocks != null) {
      data['stocks'] = stocks!.map((v) => v.toJson()).toList();
    }
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

class Iswish {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;

  Iswish(
      {this.id, this.userId, this.productId, this.createdAt, this.updatedAt});

  Iswish.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
