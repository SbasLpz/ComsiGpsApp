import 'package:apprutas/Models/user_data_model.dart';

class ValidationModel {
  String? status;
  String? message;
  UserDataModel? data;

  ValidationModel({
    this.status,
    this.message,
    this.data,
  });

  ValidationModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      // Si la data no es nula, se crea un objeto UserDataModel a partir de ella
      data = UserDataModel.fromJson(json["data"]);
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": data?.toJson(), // ⚡ Ojo: tu UserDataModel también necesita un toJson()
    };
  }
}