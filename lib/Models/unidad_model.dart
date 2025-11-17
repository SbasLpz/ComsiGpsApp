import 'dart:ffi';

import 'package:apprutas/Models/unidad_data_model.dart';

class UnidadModel {
    bool? success;
    String? message;
    String? sicap;
    List<UnidadDataModel>? data;

    UnidadModel({
      this.success,
      this.message,
      this.sicap,
      this.data
    });

    UnidadModel.fromJson(Map<String, dynamic> json) {
      success = json['success'];
      message = json['message'];
      sicap = json['sicap'];
      if (json['data'] != null) {
        data = List<UnidadDataModel>.from(
          json['data'].map((x) => UnidadDataModel.fromJson(x)),
        );
      }
    }
}