class AdvertismentModel {
  bool? error;
  List<AdsList>? data;
  String? msg;

  AdvertismentModel({this.error, this.data, this.msg});

  AdvertismentModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <AdsList>[];
      json['data'].forEach((v) {
        data!.add(AdsList.fromJson(v));
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

class AdsList {
  int? id;
  int? advertisementId;
  int? positionId;
  Ads? ads;

  AdsList({this.id, this.advertisementId, this.positionId, this.ads});

  AdsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertisementId = json['advertisement_id'];
    positionId = json['position_id'];
    ads = json['ads'] != null ? Ads.fromJson(json['ads']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advertisement_id'] = advertisementId;
    data['position_id'] = positionId;
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

  Ads({this.id, this.title, this.url, this.image, this.mobileImage});

  Ads.fromJson(Map<String, dynamic> json) {
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