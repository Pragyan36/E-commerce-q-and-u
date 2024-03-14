class HomeModel {
  bool? error;
  HomeModelData? data;
  String? msg;

  HomeModel({this.error, this.data, this.msg});

  HomeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? HomeModelData.fromJson(json['data']) : null;
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

class HomeModelData {
  List<Sliders>? sliders;
  List<Advertisements>? advertisements;
  List<FeaturedSection>? featuredSection;
  List<FeaturedCategory>? featuredCategory;

  HomeModelData(
      {this.sliders,
      this.advertisements,
      this.featuredSection,
      this.featuredCategory});

  HomeModelData.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = <Sliders>[];
      json['sliders'].forEach((v) {
        sliders!.add(Sliders.fromJson(v));
      });
    }
    if (json['advertisements'] != null) {
      advertisements = <Advertisements>[];
      json['advertisements'].forEach((v) {
        advertisements!.add(Advertisements.fromJson(v));
      });
    }
    if (json['featured_section'] != null) {
      featuredSection = <FeaturedSection>[];
      json['featured_section'].forEach((v) {
        featuredSection!.add(FeaturedSection.fromJson(v));
      });
    }
    if (json['featured_category'] != null) {
      featuredCategory = <FeaturedCategory>[];
      json['featured_category'].forEach((v) {
        featuredCategory!.add(FeaturedCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    if (advertisements != null) {
      data['advertisements'] = advertisements!.map((v) => v.toJson()).toList();
    }
    if (featuredSection != null) {
      data['featured_section'] =
          featuredSection!.map((v) => v.toJson()).toList();
    }
    if (featuredCategory != null) {
      data['featured_category'] =
          featuredCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  int? id;
  String? title;
  String? body;
  String? link;
  String? image;
  String? altImage;

  Sliders({
    this.id,
    this.title,
    this.body,
    this.image,
    this.altImage,
    this.link,
  });

  Sliders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    altImage = json['alt_img'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['image'] = image;
    data['alt_img'] = altImage;
    data['link'] = link;
    return data;
  }
}

class Advertisements {
  int? id;
  String? title;
  String? url;
  String? image;
  String? mobileImage;

  Advertisements({this.id, this.title, this.url, this.image, this.mobileImage});

  Advertisements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    mobileImage = json['mobile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['image'] = image;
    data['mobile_image'] = mobileImage;
    return data;
  }
}

class FeaturedSection {
  int? id;
  String? title;
  List<Product>? product;

  FeaturedSection({this.id, this.title, this.product});

  FeaturedSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
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
  int? specialPrice;
  int? price;
  int? varientId;
  String? image;
  bool? isWish;
  Pivot? pivot;

  Product(
      {this.id,
      this.name,
      this.slug,
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
      this.specialPrice,
      this.price,
      this.image,
      this.isWish,
      this.varientId,
      this.pivot});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
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
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    specialPrice = json['special_price'];
    price = json['price'];
    image = json['image'];
    isWish = json['is_wish'];
    varientId = json['varient_id'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
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
    data['url'] = url;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['special_price'] = specialPrice;
    data['price'] = price;
    data['image'] = image;
    data['varient_id'] = varientId;

    data['is_wish'] = isWish;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
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

class FeaturedCategory {
  int? id;
  String? title;
  String? slug;
  String? image;

  FeaturedCategory({this.id, this.title, this.slug, this.image});

  FeaturedCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
