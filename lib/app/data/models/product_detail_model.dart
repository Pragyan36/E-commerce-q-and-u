class ProductDetailModel {
  bool? error;
  ProductDetailData? data;
  String? msg;

  ProductDetailModel({
    this.error,
    this.data,
    this.msg,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      error: json['error'],
      data: ProductDetailData.fromJson(json['data']),
      msg: json['msg'],
    );
  }
}

class ProductDetailData {
  int? id;
  String? name;
  String? slug;
  String? shortDescription;
  String? longDescription;
  int? brandId;
  int? categoryId;
  String? rating;
  bool? isWish;
  String? vat;
  String? sellerName;
  int? price;
  int? specialPrice;
  String? specialFrom;
  String? specialTo;
  int? quantity;
  Category? category;
  List<ProductImage>? images;
  Map<String, dynamic>? attribute;
  List<SelectedData>? selectedData;
  List<Colors>? colors;
  SpecificationData? specificationData;
  List<SelectedAttributes>? selectedAttributes;
  Map<String, dynamic>? productDetailsAttribute;

  ProductDetailData({
    this.id,
    this.name,
    this.slug,
    this.shortDescription,
    this.longDescription,
    this.brandId,
    this.categoryId,
    this.rating,
    this.isWish,
    this.vat,
    this.sellerName,
    this.price,
    this.specialPrice,
    this.specialFrom,
    this.specialTo,
    this.quantity,
    this.category,
    this.images,
    this.attribute,
    this.selectedData,
    this.colors,
    this.specificationData,
    this.selectedAttributes,
    this.productDetailsAttribute,
  });

  factory ProductDetailData.fromJson(Map<String, dynamic> json) {
    return ProductDetailData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      shortDescription: json['short_description'],
      longDescription: json['long_description'],
      brandId: json['brand_id'],
      categoryId: json['category_id'],
      rating: json['rating'],
      isWish: json['is_wish'],
      vat: json['vat'],
      sellerName: json['seller_name'],
      price: json['price'],
      specialPrice: json['special_price'],
      specialFrom: json['special_from'],
      specialTo: json['special_to'],
      quantity: json['quantity'] ?? 0,
      category: Category.fromJson(json['category']),
      images: List<ProductImage>.from(
          json['image'].map((x) => ProductImage.fromJson(x))),
      attribute: json['attribute'] is List
          ? {}
          : Map<String, dynamic>.from(json['attribute']),
      selectedData: List<SelectedData>.from(
          json['selected_data'].map((x) => SelectedData.fromJson(x))),
      colors: List<Colors>.from(json['colors'].map((x) => Colors.fromJson(x))),
      specificationData: SpecificationData.fromJson(json['specificationData']),
      selectedAttributes: List<SelectedAttributes>.from(
        json['selected_attributes'].map(
          (x) => SelectedAttributes.fromJson(x),
        ),
      ),
      productDetailsAttribute: json['product_details_attribute'],
    );
  }
}

class ProductDetails {
  Map<String, List<List<ProductAttribute>>> details;

  ProductDetails({required this.details});

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    Map<String, List<List<ProductAttribute>>> detailsMap = {};
    json.forEach((key, value) {
      List<List<ProductAttribute>> attributesList = [];
      for (var attributeList in value) {
        List<ProductAttribute> attributes = [];
        for (var attribute in attributeList) {
          attributes.add(ProductAttribute.fromJson(attribute));
        }
        attributesList.add(attributes);
      }
      detailsMap[key] = attributesList;
    });
    return ProductDetails(details: detailsMap);
  }
}

class ProductAttribute {
  int? variantId;
  int? colorId;
  int? indexId;
  String? title;
  String? value;

  ProductAttribute({
    this.variantId,
    this.colorId,
    this.indexId,
    this.title,
    this.value,
  });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) {
    return ProductAttribute(
      variantId: json["variant_id"],
      colorId: json['color_id'],
      indexId: json['indexId'],
      title: json['title'],
      value: json['value'],
    );
  }
}

class Category {
  int? id;
  String? title;
  String? slug;
  String? image;
  String? showOnHome;
  int? parentId;

  Category({
    this.id,
    this.title,
    this.slug,
    this.image,
    this.showOnHome,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      image: json['image'],
      showOnHome: json['showOnHome'],
      parentId: json['parent_id'],
    );
  }
}

class ProductImage {
  int? id;
  String? image;
  int? isFeatured;

  ProductImage({
    this.id,
    this.image,
    this.isFeatured,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image: json['image'],
      isFeatured: json['is_featured'],
    );
  }
}

class SelectedData {
  int? id;
  int? price;
  int? specialPrice;
  int? quantity;
  dynamic freeItems;
  ItemsId? itemsId;

  SelectedData({
    this.id,
    this.price,
    this.specialPrice,
    this.quantity,
    this.freeItems,
    this.itemsId,
  });

  factory SelectedData.fromJson(Map<String, dynamic> json) {
    return SelectedData(
      id: json['id'],
      price: json['price'],
      specialPrice: json['special_price'],
      quantity: json['quantity'],
      freeItems: json['free_items'],
      itemsId: ItemsId.fromJson(json['items_id']),
    );
  }
}

class ItemsId {
  dynamic color;

  ItemsId({
    this.color,
  });

  factory ItemsId.fromJson(Map<String, dynamic> json) {
    return ItemsId(
      color: json['color'],
    );
  }
}

class Colors {
  int? id;
  String? name;
  String? code;

  Colors({
    this.id,
    this.name,
    this.code,
  });

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class SpecificationData {
  String? brand;
  String? color;
  dynamic specification;

  SpecificationData({
    this.brand,
    this.color,
    this.specification,
  });

  factory SpecificationData.fromJson(Map<String, dynamic> json) {
    return SpecificationData(
      brand: json['brand'],
      color: json['color'],
      specification: json['specification'],
    );
  }
}

class SelectedAttributes {
  int? id;
  int? stockId;
  int? key;
  String? value;
  String? createdAt;
  String? updatedAt;
  int? laravelThroughKey;
  int? stockPrice;
  int? specialPrice;
  GetOption? getOption;
  Stock? stock;

  SelectedAttributes(
      {this.id,
      this.stockId,
      this.key,
      this.value,
      this.createdAt,
      this.updatedAt,
      this.laravelThroughKey,
      this.stockPrice,
      this.specialPrice,
      this.getOption,
      this.stock});

  SelectedAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockId = json['stock_id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    laravelThroughKey = json['laravel_through_key'];
    stockPrice = json['stock_price'];
    specialPrice = json['special_price'];
    getOption = json['get_option'] != null
        ? GetOption.fromJson(json['get_option'])
        : null;
    stock = json['stock'] != null ? Stock.fromJson(json['stock']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stock_id'] = stockId;
    data['key'] = key;
    data['value'] = value;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['laravel_through_key'] = laravelThroughKey;
    data['stock_price'] = stockPrice;
    data['special_price'] = specialPrice;
    if (getOption != null) {
      data['get_option'] = getOption!.toJson();
    }
    if (stock != null) {
      data['stock'] = stock!.toJson();
    }
    return data;
  }
}

class GetOption {
  int? id;
  int? categoryId;
  String? title;
  dynamic helpText;
  String? value;
  bool? stock;
  String? createdAt;
  String? updatedAt;

  GetOption(
      {this.id,
      this.categoryId,
      this.title,
      this.helpText,
      this.value,
      this.stock,
      this.createdAt,
      this.updatedAt});

  GetOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    helpText = json['helpText'];
    value = json['value'];
    stock = json['stock'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['helpText'] = helpText;
    data['value'] = value;
    data['stock'] = stock;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Stock {
  int? id;
  int? productId;
  int? colorId;
  int? price;
  dynamic specialPrice;
  dynamic specialFrom;
  dynamic specialTo;
  int? quantity;
  dynamic freeItems;
  dynamic sellersku;
  String? createdAt;
  String? updatedAt;

  Stock(
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

  Stock.fromJson(Map<String, dynamic> json) {
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

class ColorModel {
  final String colorId;
  final List<Map<String, String>> attributes;

  ColorModel({
    required this.colorId,
    required this.attributes,
  });
}
