class AddTaskValuesModel {
  int? status;
  bool? error;
  Data? data;
  String? message;

  AddTaskValuesModel({this.status, this.error, this.data, this.message});

  AddTaskValuesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<String>? status;
  List<String>? priority;
  List<Actionsdata>? actions;
  List<Orders>? orders;

  Data({this.status, this.priority, this.actions, this.orders});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'].cast<String>();
    priority = json['priority'].cast<String>();
    if (json['actions'] != null) {
      actions = <Actionsdata>[];
      json['actions'].forEach((v) {
        actions!.add(Actionsdata.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['priority'] = priority;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actionsdata {
  int? id;
  String? title;

  Actionsdata({this.id, this.title});

  Actionsdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class Orders {
  dynamic id;
  String? refId;

  Orders({this.id, this.refId});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    refId = json['ref_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ref_id'] = refId;
    return data;
  }
}
