class SiccapDataModel {
  String? tipoServicio;
  String? idgps;
  String? enMision;
  String? fechaAsignado;
  String? fechaFin;
  String? rui;
  String? nombramiento;
  String? referencia;
  String? piloto;
  String? telefono;
  String? direccionDestino;
  String? paisDestino;
  String? contenedor;
  String? placaTc;
  String? color;
  String? indicarivo;
  String? ultimoReporte;
  String? lugar;
  String? accion;

  SiccapDataModel({
    this.tipoServicio,
    this.idgps,
    this.enMision,
    this.fechaAsignado,
    this.fechaFin,
    this.rui,
    this.nombramiento,
    this.referencia,
    this.piloto,
    this.telefono,
    this.direccionDestino,
    this.paisDestino,
    this.contenedor,
    this.placaTc,
    this.color,
    this.indicarivo,
    this.ultimoReporte,
    this.lugar,
    this.accion
  });

  SiccapDataModel.fromJson(Map<String, dynamic> json) {
    tipoServicio = json['tipoServicio'];
    idgps = json['idgps'];
    enMision = json['enMision'];
    fechaAsignado = json['fechaAsignado'];
    fechaFin = json['fechaFin'];
    rui = json['rui'];
    nombramiento = json['nombramiento'];
    referencia = json['referencia'];
    piloto = json['piloto'];
    telefono = json['telefono'];
    direccionDestino = json['direccionDestino'];
    paisDestino = json['paisDestino'];
    contenedor = json['contenedor'];
    placaTc = json['placaTc'];
    color = json['color'];
    indicarivo = json['indicarivo'];
    ultimoReporte = json['ultimoReporte'];
    lugar = json['lugar'];
    accion = json['accion'];
  }
}