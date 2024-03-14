class RewardModel {
  bool? error;
  RewardData? data;
  String? msg;

  RewardModel({this.error, this.data, this.msg});

  RewardModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    data = json['data'] != null ? RewardData.fromJson(json['data']) : null;
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

class RewardData {
  int? totalShare;
  int? totalPoints;
  int? pointsValue;

  RewardData({this.totalShare, this.totalPoints});

  RewardData.fromJson(Map<String, dynamic> json) {
    totalShare = json['totalShare'];
    pointsValue = json['pointsValue'];
    totalPoints = json['totalPoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalShare'] = totalShare;
    data['totalPoints'] = totalPoints;
    data['pointsValue'] = pointsValue;
    return data;
  }
}
