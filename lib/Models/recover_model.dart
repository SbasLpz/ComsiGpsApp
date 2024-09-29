class RecoverModel {
  bool? success;
  String? msg;

  RecoverModel({
    this.success,
    this.msg,
  });

  RecoverModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }
}