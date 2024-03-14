class SiteDetail {
  bool? error;
  List<SiteDetailData>? data;
  String? msg;

  SiteDetail({
    this.error,
    this.data,
    this.msg,
  });

  SiteDetail.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json["data"] != null) {
      data = List.from(json['data'])
          .map((e) => SiteDetailData.fromJson(e))
          .toList();
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final mainData = <String, dynamic>{};
    mainData['error'] = error;
    if (data != null) {
      mainData['data'] = data!.map((e) => e.toJson()).toList();
    }
    mainData['msg'] = msg;
    return mainData;
  }
}

class SiteDetailData {
  SiteDetailData({
    this.id,
    this.key,
    this.value,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.address,
    this.favIcon,
  });
  int? id;
  String? key;
  String? value;
  String? type;
  dynamic createdAt;
  String? updatedAt;
  String? address;
  String? favIcon;

  SiteDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json["value"];
    type = json['type'];
    createdAt = json["created_at"];
    updatedAt = json['updated_at'];
    address = json["address"];
    favIcon = json["fav_icon"];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['value'] = value;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address'] = address;
    data['fav_icon'] = favIcon;
    return data;
  }
}
