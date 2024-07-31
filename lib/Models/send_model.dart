class SendModel {
  bool? success;
  String? msg;

  SendModel({
    this.success,
    this.msg,
  });

  SendModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }
}