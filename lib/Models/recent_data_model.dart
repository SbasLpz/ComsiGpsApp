class RecentDataModel {
  String? fecha_gps;
  String? fecha;
  String? velocidad;
  String? punto_cercano;
  String? latitud;
  String? longitud;

  RecentDataModel({
    this.fecha_gps,
    this.fecha,
    this.velocidad,
    this.punto_cercano,
    this.latitud,
    this.longitud
  });

  RecentDataModel.fromJson(Map<String, dynamic> json) {
    fecha_gps = json['fecha_gps'];
    fecha = json['fecha'];
    velocidad = json['velocidad'];
    punto_cercano = json['punto_cercano'];
    latitud = json['latitud'];
    longitud = json['longitud'];
  }
}