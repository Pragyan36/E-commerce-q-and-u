class GraphModel {
  int? status;
  bool? error;
  int? deliveredCount;
  int? pendingCount;
  int? completedCount;
  int? myDeliveryTaskCount;
  String? message;

  GraphModel(
      {this.status,
      this.error,
      this.deliveredCount,
      this.pendingCount,
      this.completedCount,
      this.myDeliveryTaskCount,
      this.message});

  GraphModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    deliveredCount = json['delivered_count'];
    pendingCount = json['pending_count'];
    completedCount = json['completed_count'];
    myDeliveryTaskCount = json['my_delivery_task_count'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error'] = error;
    data['delivered_count'] = deliveredCount;
    data['pending_count'] = pendingCount;
    data['completed_count'] = completedCount;
    data['my_delivery_task_count'] = myDeliveryTaskCount;
    data['message'] = message;
    return data;
  }
}
