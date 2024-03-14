class AttributeModel {
  bool? error;
  AttributeData? data;
  String? msg;

  AttributeModel({this.error, this.data, this.msg});

  AttributeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? AttributeData.fromJson(json['data']) : null;
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

class AttributeData {
  List<Brands>? brands;
  List<Colors>? colors;

  AttributeData({this.brands, this.colors});

  AttributeData.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(Brands.fromJson(v));
      });
    }
    if (json['colors'] != null) {
      colors = <Colors>[];
      json['colors'].forEach((v) {
        colors!.add(Colors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int? id;
  String? name;
  String? logo;

  Brands({this.id, this.name, this.logo});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}

class Colors {
  int? id;
  String? title;
  String? colorCode;

  Colors({this.id, this.title, this.colorCode});

  Colors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    colorCode = json['colorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['colorCode'] = colorCode;
    return data;
  }
}
