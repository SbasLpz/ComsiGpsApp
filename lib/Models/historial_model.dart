import 'package:apprutas/Models/historial_data_model.dart';

class HistorialModel {
  String? status;
  String? message;
  List<HistorialDataModel>? data;

  HistorialModel({
    this.status,
    this.message,
    this.data
  });

  HistorialModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] is List
        ? (json['data'] as List<dynamic>)
        .map((cmd) => HistorialDataModel.fromJson(cmd))
        .toList()
        : [];
  }
}