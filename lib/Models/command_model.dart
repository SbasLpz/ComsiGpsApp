class CommandModel {
  String? descripcion;
  String? command;
  String? sms_phone;

  CommandModel({
    this.descripcion,
    this.command,
    this.sms_phone,
  });

  CommandModel.fromJson(Map<String, dynamic> json) {
    descripcion = json['descripcion'];
    command = json['command'];
    sms_phone = json['sms_phone'];
  }
}