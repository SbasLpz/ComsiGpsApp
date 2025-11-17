import 'package:apprutas/Models/recent_data_model.dart';

class RecentModel {
  String? status;
  String? message;
  List<RecentDataModel>? data;

  RecentModel({
    this.status,
    this.message,
    this.data
  });

  RecentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is List
        ? (json['data'] as List<dynamic>)
        .map((cmd) => RecentDataModel.fromJson(cmd))
        .toList()
        : [];
  }
}