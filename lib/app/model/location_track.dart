// To parse this JSON data, do
//
//     final locationTrackModel = locationTrackModelFromJson(jsonString);

import 'dart:convert';

LocationTrackModel locationTrackModelFromJson(String str) =>
    LocationTrackModel.fromJson(json.decode(str));

String locationTrackModelToJson(LocationTrackModel data) =>
    json.encode(data.toJson());

class LocationTrackModel {
  LocationTrackModel({
    this.error,
    this.data,
    this.msg,
  });

  bool? error;
  List<LocationTrackHeadingModel>? data;
  String? msg;

  factory LocationTrackModel.fromJson(Map<String, dynamic> json) =>
      LocationTrackModel(
        error: json["error"],
        data: List<LocationTrackHeadingModel>.from(
            json["data"].map((x) => LocationTrackHeadingModel.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class LocationTrackHeadingModel {
  LocationTrackHeadingModel({
    this.createdAt,
    this.time,
    this.items,
    this.statusValue,
  });

  String? createdAt;
  String? time;
  int? items;
  String? statusValue;

  factory LocationTrackHeadingModel.fromJson(Map<String, dynamic> json) =>
      LocationTrackHeadingModel(
        createdAt: json["created_at"],
        time: json["time"],
        items: json["items"],
        statusValue: json["status_value"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "time": time,
        "items": items,
        "status_value": statusValue,
      };
}
