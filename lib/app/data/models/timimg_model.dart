class TimingModel {
  int? status;
  TimingData? data;
  String? message;

  TimingModel({this.status, this.data, this.message});

  TimingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? TimingData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class TimingData {
  int? id;
  String? day;
  String? startTime;
  String? endTime;
  int? dayOff;
  String? createdAt;
  String? updatedAt;

  TimingData(
      {this.id,
      this.day,
      this.startTime,
      this.endTime,
      this.dayOff,
      this.createdAt,
      this.updatedAt});

  TimingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    dayOff = json['day_off'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['day_off'] = dayOff;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
