// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class AdsModel {
  bool? error;
  List<AdsData>? data;
  String? msg;

  AdsModel({this.error, this.data, this.msg});

  AdsModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <AdsData>[];
      json['data'].forEach((v) {
        data!.add(AdsData.fromJson(v));
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

class AdsData {
  int? id;
  int? advertisementId;
  int? positionId;
  Null? createdAt;
  Null? updatedAt;
  Ads? ads;

  AdsData(
      {this.id,
      this.advertisementId,
      this.positionId,
      this.createdAt,
      this.updatedAt,
      this.ads});

  AdsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    positionId = json['position_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    ads = json['ads'] != null ? Ads.fromJson(json['ads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advertisement_id'] = advertisementId;
    data['position_id'] = positionId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (ads != null) {
      data['ads'] = ads!.toJson();
    }
    return data;
  }
}

class Ads {
  int? id;
  String? title;
  String? url;
  String? image;
  String? mobileImage;
  int? size;
  String? createdAt;
  String? updatedAt;

  Ads(
      {this.id,
      this.title,
      this.url,
      this.image,
      this.mobileImage,
      this.size,
      this.createdAt,
      this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    image = json['image'];
    mobileImage = json['mobile_image'];
    size = json['size'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['url'] = url;
    data['image'] = image;
    data['mobile_image'] = mobileImage;
    data['size'] = size;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
