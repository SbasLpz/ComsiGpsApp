class SendModel {
  String? status;
  String? message;

  SendModel({
    this.status,
    this.message,
  });

  SendModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}