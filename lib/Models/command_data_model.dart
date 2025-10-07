class CommandDataModel {
  String? id_sms_hardware;
  String? smsComand;
  String? descripcion;

  CommandDataModel({
    this.id_sms_hardware,
    this.smsComand,
    this.descripcion,
  });

  CommandDataModel.fromJson(Map<String, dynamic> json) {
    id_sms_hardware = json["id_sms_hardware"];
    smsComand = json["smsComand"];
    descripcion = json["descripcion"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id_sms_hardware": id_sms_hardware,
      "smsComand": smsComand,
      "descripcion": descripcion
    };
  }
}