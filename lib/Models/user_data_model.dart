class UserDataModel {
  int? idUsuario;
  String? usuario;
  String? nombre;
  String? nuser;
  int? idCliente;
  int? idGrupo;
  int? idSubclientes;
  String? paisUsr;
  String? zonaHoraria;
  String? ip;
  String? siccap;
  String? logo;
  int? tipo;
  String? token;

  UserDataModel({
    this.idUsuario,
    this.usuario,
    this.nombre,
    this.nuser,
    this.idCliente,
    this.idGrupo,
    this.idSubclientes,
    this.paisUsr,
    this.zonaHoraria,
    this.ip,
    this.siccap,
    this.logo,
    this.tipo,
    this.token,
  });

  UserDataModel.fromJson(Map<String, dynamic> json) {
    idUsuario = json["id_usuario"];
    usuario = json["usuario"];
    nombre = json["nombre"];
    nuser = json["nuser"];
    idCliente = json["id_cliente"];
    idGrupo = json["id_grupo"];
    idSubclientes = json["id_subclientes"];
    paisUsr = json["pais_usr"];
    zonaHoraria = json["zona_horaria"];
    ip = json["ip"];
    siccap = json["siccap"];
    logo = json["logo"];
    tipo = json["tipo"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id_usuario": idUsuario,
      "usuario": usuario,
      "nombre": nombre,
      "nuser": nuser,
      "id_cliente": idCliente,
      "id_grupo": idGrupo,
      "id_subclientes": idSubclientes,
      "pais_usr": paisUsr,
      "zona_horaria": zonaHoraria,
      "ip": ip,
      "siccap": siccap,
      "logo": logo,
      "tipo": tipo,
      "token": token,
    };
  }
}