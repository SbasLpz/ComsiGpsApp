class NewPassModel {
  String? status;
  String? message;
  String? data;

  NewPassModel({
    this.status,
    this.message,
    this.data,
  });

  NewPassModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }
}