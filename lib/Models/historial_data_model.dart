class HistorialDataModel {
  String? fecha_gps;
  String? fecha;
  String? punto_cercano;
  String? latitud;
  String? longitud;


  HistorialDataModel ( {
    this.fecha_gps,
    this.fecha,
    this.punto_cercano,
    this.latitud,
    this.longitud
  });

  HistorialDataModel.fromJson(Map<String, dynamic> json) {
    fecha_gps = json['fecha_gps'];
    fecha = json['fecha'];
    punto_cercano = json['punto_cercano'];
    latitud = json['latitud'];
    longitud = json['longitud'];
  }
}