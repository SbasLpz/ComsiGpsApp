class ValidationModel {
  bool? success;
  String? msg;
  String? token;
  String? nombres;
  String? apellidos;
  int? msg_vencido;
  int? dias_vencido;

  ValidationModel({
    this.success,
    this.msg,
    this.token,
    this.nombres,
    this.apellidos,
    this.msg_vencido,
    this.dias_vencido
  });

  ValidationModel.fromJson(Map<String, dynamic> json) {
    //print("AAAAA: ${json["success"] as bool}");
    success = json["success"] as bool;
    msg = json["msg"];
    token = json["token"];
    nombres = json["nombres"];
    apellidos = json["apellidos"];
    msg_vencido = json["msg_vencido"];
    dias_vencido = json["dias_vencido"];
  }
}