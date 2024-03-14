class BrandModel {
  bool? error;
  List<BrandData>? data;
  String? msg;

  BrandModel({this.error, this.data, this.msg});

  BrandModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(BrandData.fromJson(v));
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

class BrandData {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
  int? brandId;
  String? rating;
  int? price;
  int? specialPrice;
  int? varientId;
  String? image;

  BrandData(
      {this.id,
      this.name,
      this.slug,
      this.shortDescription,
      this.longDescription,
      this.brandId,
      this.rating,
      this.price,
      this.specialPrice,
      this.varientId,
      this.image});

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    brandId = json['brand_id'];
    rating = json['rating'];
    price = json['price'];
    specialPrice = json['special_price'];
    varientId = json['varient_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['brand_id'] = brandId;
    data['rating'] = rating;
    data['price'] = price;
    data['special_price'] = specialPrice;
    data['varient_id'] = varientId;
    data['image'] = image;
    return data;
  }
}
