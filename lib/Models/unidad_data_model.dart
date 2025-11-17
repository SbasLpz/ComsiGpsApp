class UnidadDataModel {
  String? Descripcion;
  String? descripcion_ordenada;
  String? Placa;
  String? IDGPS;
  String? empresa;
  String? asignado;
  String? icono;
  String? Coordenadas;
  String? fecha;
  int? tiempoReporte;
  String? velocidad;
  String? nombrePiloto;

  UnidadDataModel({
    this.Descripcion,
    this.descripcion_ordenada,
    this.Placa,
    this.IDGPS,
    this.empresa,
    this.asignado,
    this.icono,
    this.Coordenadas,
    this.fecha,
    this.tiempoReporte,
    this.velocidad,
    this.nombrePiloto,
  });

  UnidadDataModel.fromJson(Map<String, dynamic> json) {
    Descripcion = json["Descripcion"];
    descripcion_ordenada = json["descripcion_ordenada"];
    Placa = json["Placa"];
    IDGPS = json["IDGPS"];
    empresa = json["empresa"];
    asignado = json["asignado"];
    icono = json["icono"];
    Coordenadas = json["Coordenadas"];
    fecha = json["fecha"];
    tiempoReporte = json["tiempoReporte"];
    velocidad = json["velocidad"];
    nombrePiloto = json["nombrePiloto"];
  }
}