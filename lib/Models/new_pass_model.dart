class NewPassModel {
  bool? success;
  String? msg;

  NewPassModel({
    this.success,
    this.msg,
  });

  NewPassModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    msg = json['msg'];
  }
}