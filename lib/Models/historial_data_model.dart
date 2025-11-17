class HistorialDataModel {
  String? fecha_gps;
  String? fecha;
  String? velocidad;
  String? punto_cercano;
  String? latitud;
  String? longitud;


  HistorialDataModel ( {
    this.fecha_gps,
    this.fecha,
    this.velocidad,
    this.punto_cercano,
    this.latitud,
    this.longitud
  });

  HistorialDataModel.fromJson(Map<String, dynamic> json) {
    fecha_gps = json['fecha_gps'];
    fecha = json['fecha'];
    fecha = json['velocidad'];
    punto_cercano = json['punto_cercano'];
    latitud = json['latitud'];
    longitud = json['longitud'];
  }
}