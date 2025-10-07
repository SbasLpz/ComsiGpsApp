import 'package:apprutas/Models/info_data_model.dart';

class InfoModel {
  String? status;
  String? message;
  InfoDataModel? data;

  InfoModel({
    this.status,
    this.message,
    this.data,
  });

  InfoModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    if (json["data"] != null) {
      // Si la data no es nula, se crea un objeto UserDataModel a partir de ella
      data = InfoDataModel.fromJson(json["data"]);
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