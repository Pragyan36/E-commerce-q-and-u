// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class SpecificFeaturedProductModel {
  bool? error;
  SpecificFeaturedProductData? data;
  String? msg;

  SpecificFeaturedProductModel({this.error, this.data, this.msg});

  SpecificFeaturedProductModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null
        ? SpecificFeaturedProductData.fromJson(json['data'])
        : null;
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

class SpecificFeaturedProductData {
  int? id;
  String? title;
  int? count;
  int? publishStatus;
  String? metaTitle;
  String? metaKeywords;
  String? metaDescription;
  int? order;
  String? createdAt;
  String? updatedAt;
  List<FeaturedProducts>? featuredProducts;

  SpecificFeaturedProductData(
      {this.id,
      this.title,
      this.count,
      this.publishStatus,
      this.metaTitle,
      this.metaKeywords,
      this.metaDescription,
      this.order,
      this.createdAt,
      this.updatedAt,
      this.featuredProducts});

  SpecificFeaturedProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    count = json['count'];
    publishStatus = json['publishStatus'];
    metaTitle = json['meta_title'];
    metaKeywords = json['meta_keywords'];
    metaDescription = json['meta_description'];
    order = json['order'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['featured_products'] != null) {
      featuredProducts = <FeaturedProducts>[];
      json['featured_products'].forEach((v) {
        featuredProducts!.add(FeaturedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['count'] = count;
    data['publishStatus'] = publishStatus;
    data['meta_title'] = metaTitle;
    data['meta_keywords'] = metaKeywords;
    data['meta_description'] = metaDescription;
    data['order'] = order;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (featuredProducts != null) {
      data['featured_products'] =
          featuredProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeaturedProducts {
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
  Pivot? pivot;
  List<Images>? images;
  GetPrice? getPrice;

  FeaturedProducts(
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
      this.pivot,
      this.images,
      this.getPrice});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
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
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (getPrice != null) {
      data['get_price'] = getPrice!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? featuredSectionId;
  int? productId;

  Pivot({this.featuredSectionId, this.productId});

  Pivot.fromJson(Map<String, dynamic> json) {
    featuredSectionId = json['featured_section_id'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['featured_section_id'] = featuredSectionId;
    data['product_id'] = productId;
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
  Null? specialPrice;
  Null? specialFrom;
  Null? specialTo;
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
