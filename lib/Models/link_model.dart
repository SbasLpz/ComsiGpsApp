class LinkModel {
  bool? success;
  String? link;

  LinkModel({
    this.success,
    this.link,
  });

  LinkModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    link = json['link'];
  }
}