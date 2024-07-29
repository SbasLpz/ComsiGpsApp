class HistorialModel {
  String? latitud;
  String? longitud;
  String? fecha;
  String? fecha_pc;
  String? id;
  String? orientacion;
  String? velocidad;
  String? descripcion;
  String? zoom;
  String? icono;
  String? size;
  String? desc_evento;
  String? lugar;
  String? nombreevento;
  String? fecha1;
  String? estado;

  HistorialModel({
    this.latitud,
    this.longitud,
    this.fecha,
    this.fecha_pc,
    this.id,
    this.orientacion,
    this.velocidad,
    this.descripcion,
    this.zoom,
    this.icono,
    this.size,
    this.desc_evento,
    this.lugar,
    this.nombreevento,
    this.fecha1,
    this.estado
  });

  HistorialModel.fromJson(Map<String, dynamic> json) {
    latitud = json['latitud'];
    longitud = json['longitud'];
    fecha = json['fecha'];
    fecha_pc = json['fecha_pc'];
    id = json['id'];
    orientacion = json['orientacion'];
    velocidad = json['velocidad'];
    descripcion = json['descripcion'];
    zoom = json['zoom'];
    icono = json['icono'];
    size = json['size'];
    desc_evento = json['desc_evento'];
    lugar = json['lugar'];
    nombreevento = json['nombreevento'];
    fecha1 = json['fecha1'];
    estado = json['estado'];
  }
}