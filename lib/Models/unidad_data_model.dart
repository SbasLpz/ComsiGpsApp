class UnidadDataModel {
  String? Descripcion;
  String? IDGPS;
  String? Placa;
  String? Coordenadas;
  String? fecha;
  int? tiempoReporte;
  String? velocidad;
  String? nombrePiloto;

  UnidadDataModel({
    this.Descripcion,
    this.IDGPS,
    this.Placa,
    this.Coordenadas,
    this.fecha,
    this.tiempoReporte,
    this.velocidad,
    this.nombrePiloto,
  });

  UnidadDataModel.fromJson(Map<String, dynamic> json) {
    Descripcion = json["Descripcion"];
    IDGPS = json["IDGPS"];
    Placa = json["Placa"];
    Coordenadas = json["Coordenadas"];
    fecha = json["fecha"];
    tiempoReporte = json["tiempoReporte"];
    velocidad = json["velocidad"];
    nombrePiloto = json["nombrePiloto"];
  }
}