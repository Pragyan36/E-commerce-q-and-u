class ShippingChargeModel {
  bool? error;
  List<ShippingChargeData>? data;
  String? msg;

  ShippingChargeModel({this.error, this.data, this.msg});

  ShippingChargeModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <ShippingChargeData>[];
      json['data'].forEach((v) {
        data!.add(ShippingChargeData.fromJson(v));
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

class ShippingChargeData {
  int? id;
  int? localId;
  String? title;
  String? slug;
  String? image;
  int? charge;

  ShippingChargeData(
      {this.id, this.localId, this.title, this.slug, this.image, this.charge});

  ShippingChargeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    localId = json['local_id'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    charge = json['charge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['local_id'] = localId;
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['charge'] = charge;
    return data;
  }
}
