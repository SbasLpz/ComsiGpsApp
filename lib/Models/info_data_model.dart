class InfoDataModel {
  String? Descripcion;
  String? Coordenadas;
  String? fecha;
  String? tiempoReporte;
  String? velocidad;
  String? Direccion;
  String? Conductor;
  String? fecha_gps;
  String? fecha_servidor;
  String? bateria;
  int? ignicion;

  InfoDataModel({
    this.Descripcion,
    this.Coordenadas,
    this.fecha,
    this.tiempoReporte,
    this.velocidad,
    this.Direccion,
    this.Conductor,
    this.fecha_gps,
    this.fecha_servidor,
    this.bateria,
    this.ignicion
  });

  InfoDataModel.fromJson(Map<String, dynamic> json) {
    Descripcion = json["Descripcion"];
    Coordenadas = json["Coordenadas"];
    fecha = json["fecha"];
    tiempoReporte = json["tiempoReporte"];
    velocidad = json["velocidad"];
    Direccion = json["Direccion"];
    Conductor = json["Conductor"];
    fecha_gps = json["fecha_gps"];
    fecha_servidor = json["fecha_servidor"];
    bateria = json["bateria"];
    ignicion = json["ignicion"];
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
      "fecha_gps": fecha_gps,
      "fecha_servidor": fecha_servidor,
      "bateria": bateria,
      "ignicion": ignicion,
    };
  }
}