import 'package:apprutas/Models/siccap_data_model.dart';

class SiccapModel {
  String? status;
  String? message;
  SiccapDataModel? data;

  SiccapModel({
    this.status,
    this.message,
    this.data
  });

  SiccapModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SiccapDataModel.fromJson(json['data']) : null;
  }
}