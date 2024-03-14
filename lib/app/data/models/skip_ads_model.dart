class SkipAds {
  bool? error;
  List<SkipAdslist>? data;
  String? msg;

  SkipAds({this.error, this.data, this.msg});

  SkipAds.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <SkipAdslist>[];
      json['data'].forEach((v) {
        data!.add(SkipAdslist.fromJson(v));
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

class SkipAdslist {
  int? id;
  String? title;
  dynamic url;
  String? image;
  String? mobileImage;

  SkipAdslist({this.id, this.title, this.url, this.image, this.mobileImage});

  SkipAdslist.fromJson(Map<String, dynamic> json) {
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
