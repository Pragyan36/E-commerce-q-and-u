class ChildCategoryModel {
  bool? error;
  List<Category>? category;
  String? msg;

  ChildCategoryModel({this.error, this.category, this.msg});

  ChildCategoryModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['msg'] = msg;
    return data;
  }
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? image;
  int? parentId;
  List<Products>? products;

  Category(
      {this.id,
      this.title,
      this.slug,
      this.image,
      this.parentId,
      this.products});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    parentId = json['parent_id'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['parent_id'] = parentId;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
  String? rating;
  String? price;
  String? specialPrice;
  String? image;
  int? varientId;
  String? percent;

  Products({
    this.id,
    this.name,
    this.slug,
    this.shortDescription,
    this.longDescription,
    this.rating,
    this.price,
    this.specialPrice,
    this.image,
    this.varientId,
    this.percent,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    rating = json['rating'];
    price = json['price'].toString();
    specialPrice = json['special_price'].toString();
    image = json['image'];
    varientId = json['varient_id'];
    percent = json['percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['rating'] = rating;
    data['price'] = price;
    data['special_price'] = specialPrice;
    data['image'] = image;
    data['varient_id'] = varientId;
    data['percent'] = percent;
    return data;
  }
}
