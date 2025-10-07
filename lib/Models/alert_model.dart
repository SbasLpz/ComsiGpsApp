import 'dart:ffi';

import 'package:apprutas/Models/alert_data_model.dart';

class AlertModel {
  bool? success;
  String? message;
  List<AlertDataModel>? data;


  AlertModel({
    this.success,
    this.message,
    this.data
  });

  factory AlertModel.fromJson(Map<String, dynamic> json){
    return AlertModel(
      success: json["success"] ?? '',
      message: json["message"] ?? '',
      data: json['data'] is List
          ? (json['data'] as List<dynamic>)
          .map((cmd) => AlertDataModel.fromJson(cmd))
          .toList()
          : [],
    );
  }

}