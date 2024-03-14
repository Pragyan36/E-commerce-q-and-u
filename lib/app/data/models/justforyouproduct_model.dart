class JustForYouProductModel {
  int? status;
  String? msg;
  JustForYouProductModelData? data;

  JustForYouProductModel({this.status, this.msg, this.data});

  JustForYouProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null
        ? JustForYouProductModelData.fromJson(json['data'])
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

class JustForYouProductModelData {
  Tag? tag;
  List<JustForYouProductModelProducts>? products;

  JustForYouProductModelData({this.tag, this.products});

  JustForYouProductModelData.fromJson(Map<String, dynamic> json) {
    tag = json['tag'] != null ? Tag.fromJson(json['tag']) : null;
    if (json['products'] != null) {
      products = <JustForYouProductModelProducts>[];
      json['products'].forEach((v) {
        products!.add(JustForYouProductModelProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tag != null) {
      data['tag'] = tag!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  int? id;
  String? title;
  String? summary;
  String? description;
  String? image;
  String? thumbnail;
  String? slug;

  Tag(
      {this.id,
      this.title,
      this.summary,
      this.description,
      this.image,
      this.thumbnail,
      this.slug});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    description = json['description'];
    image = json['image'];
    thumbnail = json['thumbnail'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['summary'] = summary;
    data['description'] = description;
    data['image'] = image;
    data['thumbnail'] = thumbnail;
    data['slug'] = slug;
    return data;
  }
}

class JustForYouProductModelProducts {
  int? id;
  String? name;
  String? slug;
  int? totalSell;
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
  String? rating;
  bool? publishStatus;
  String? url;
  String? colorId;
  String? price;
  String? specialPrice;
  String? image;
  int? varient;
  String? percent;

  JustForYouProductModelProducts({
    this.id,
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
    this.rating,
    this.publishStatus,
    this.url,
    this.colorId,
    this.price,
    this.specialPrice,
    this.image,
    this.varient,
    this.percent,
  });

  JustForYouProductModelProducts.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    publishStatus = json['publishStatus'];
    url = json['url'];
    colorId = json['color_id'];
    price = json['price'];
    specialPrice = json['special_price'];
    image = json['image'];
    varient = json['varient'];
    percent = json['percent'];
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
    data['percent'] = percent;
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
    data['rating'] = rating;
    data['publishStatus'] = publishStatus;
    data['url'] = url;
    data['color_id'] = colorId;
    data['price'] = price;
    data['orginal_price'] = specialPrice;
    data['image'] = image;
    data['varient'] = varient;
    return data;
  }
}
