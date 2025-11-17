class InfoDataModel {
  String? Descripcion;
  String? Coordenadas;
  String? fecha;
  String? tiempoReporte;
  String? velocidad;
  String? Direccion;
  String? Conductor;
  String? modelo;
  String? Telefono;
  String? fecha_gps;
  String? fecha_servidor;
  String? bateria;
  int? ignicion;
  String? enmision;
  String? tipo_vehiculo;

  InfoDataModel({
    this.Descripcion,
    this.Coordenadas,
    this.fecha,
    this.tiempoReporte,
    this.velocidad,
    this.Direccion,
    this.Conductor,
    this.modelo,
    this.Telefono,
    this.fecha_gps,
    this.fecha_servidor,
    this.bateria,
    this.ignicion,
    this.enmision,
    this.tipo_vehiculo
  });

  InfoDataModel.fromJson(Map<String, dynamic> json) {
    Descripcion = json["Descripcion"];
    Coordenadas = json["Coordenadas"];
    fecha = json["fecha"];
    tiempoReporte = json["tiempoReporte"];
    velocidad = json["velocidad"];
    Direccion = json["Direccion"];
    Conductor = json["Conductor"];
    modelo = json["modelo"];
    Telefono = json["Telefono"];
    fecha_gps = json["fecha_gps"];
    fecha_servidor = json["fecha_servidor"];
    bateria = json["bateria"];
    ignicion = json["ignicion"];
    enmision = json["enmision"];
    tipo_vehiculo = json["tipo_vehiculo"];
  }

  Map<String, dynamic> toJson() {
    return {
      "Descripcion": Descripcion,
      "Coordenadas": Coordenadas,
      "fecha": fecha,
      "tiempoReporte": tiempoReporte,
      "velocidad": velocidad,
      "Direccion": Direccion,
      "Conductor": Conductor,
      "modelo": modelo,
      "Telefono": Telefono,
      "fecha_gps": fecha_gps,
      "fecha_servidor": fecha_servidor,
      "bateria": bateria,
      "ignicion": ignicion,
      "enmision": enmision,
      "tipo_vehiculo": tipo_vehiculo,
    };
  }
}