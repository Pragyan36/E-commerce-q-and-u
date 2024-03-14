class TopOfferModel {
  int? status;
  String? msg;
  List<TopOfferModelData>? data;

  TopOfferModel({this.status, this.msg, this.data});

  TopOfferModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <TopOfferModelData>[];
      json['data'].forEach((v) {
        data!.add(TopOfferModelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopOfferModelData {
  String? title;
  String? slug;
  String? image;
  String? from;
  String? to;
  int? offer;
  int? isFixed;

  TopOfferModelData(
      {this.title,
      this.slug,
      this.image,
      this.from,
      this.to,
      this.offer,
      this.isFixed});

  TopOfferModelData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    from = json['from'];
    to = json['to'];
    offer = json['offer'];
    isFixed = json['is_fixed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['slug'] = slug;
    data['image'] = image;
    data['from'] = from;
    data['to'] = to;
    data['offer'] = offer;
    data['is_fixed'] = isFixed;
    return data;
  }
}
