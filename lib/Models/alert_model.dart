class AlertModel {
  String? id_log;
  String? placa;
  String? id_usuario;
  String? comentario;
  String? fecha;
  String? id_gps;
  String? descripcion;
  String? activo;
  String? id_reporte;
  String? tipo_log;
  String? id_geocerca;
  String? fecha_cierre;
  String? evento;
  String? nombreevento;
  String? correo_enviado;
  String? latitud;
  String? longitud;
  String? id_alerta_activa;
  String? id_tipo_alerta;
  String? id_tipo_evento;
  String? correos;
  String? alertar_pantalla;
  String? wa_enviado;
  String? telefonos_wa;
  String? descripcion_corta;
  String? velocidad;
  String? descr;
  String? sonido;
  String? nusuario;
  String? ngrupo;
  String? fecha1;
  String? id_vehiculo;

  AlertModel({
    this.id_log,
    this.placa,
    this.id_usuario,
    this.comentario,
    this.fecha,
    this.id_gps,
    this.descripcion,
    this.activo,
    this.id_reporte,
    this.tipo_log,
    this.id_geocerca,
    this.fecha_cierre,
    this.evento,
    this.nombreevento,
    this.correo_enviado,
    this.latitud,
    this.longitud,
    this.id_alerta_activa,
    this.id_tipo_alerta,
    this.id_tipo_evento,
    this.correos,
    this.alertar_pantalla,
    this.wa_enviado,
    this.telefonos_wa,
    this.descripcion_corta,
    this.velocidad,
    this.descr,
    this.sonido,
    this.nusuario,
    this.ngrupo,
    this.fecha1,
    this.id_vehiculo,
  });

  AlertModel.fromJson(Map<String, dynamic> json){
    id_log = json["id_log"];
    placa = json["placa"];
    id_usuario = json["id_usuario"];
    comentario = json["comentario"];
    fecha = json["fecha"];
    id_gps = json["id_gps"];
    descripcion = json["descripcion"];
    activo = json["activo"];
    id_reporte = json["id_reporte"];
    tipo_log = json["tipo_log"];
    id_geocerca = json["id_geocerca"];
    fecha_cierre = json["fecha_cierre"];
    evento = json["evento"];
    nombreevento = json["nombreevento"];
    correo_enviado = json["correo_enviado"];
    latitud = json["latitud"];
    longitud = json["longitud"];
    id_alerta_activa = json["id_alerta_activa"];
    id_tipo_alerta = json["id_tipo_alerta"];
    id_tipo_evento = json["id_tipo_evento"];
    correos = json["correos"];
    alertar_pantalla = json["alertar_pantalla"];
    wa_enviado = json["wa_enviado"];
    telefonos_wa = json["telefonos_wa"];
    descripcion_corta = json["descripcion_corta"];
    velocidad = json["velocidad"];
    descr = json["descr"];
    sonido = json["sonido"];
    nusuario = json["nusuario"];
    ngrupo = json["ngrupo"];
    fecha1 = json["fecha1"];
    id_vehiculo = json["id_vehiculo"];
  }
}