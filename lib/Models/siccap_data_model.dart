class SiccapDataModel {
  String? tipoServicio;
  String? idgps;
  String? descripcion;
  String? enMision;
  String? empresa;
  String? fechaAsignado;
  String? fechaFin;
  String? rui;
  String? nombramiento;
  String? referencia;
  String? piloto;
  String? telefono;
  String? telefonoCustodio;
  String? direccionDestino;
  String? paisDestino;
  String? contenedor;
  String? placaCabezal;
  String? placaTc;
  String? color;
  String? indicarivo;
  String? ultimoReporte;
  String? lugar;
  String? accion;

  SiccapDataModel({
    this.tipoServicio,
    this.idgps,
    this.descripcion,
    this.enMision,
    this.empresa,
    this.fechaAsignado,
    this.fechaFin,
    this.rui,
    this.nombramiento,
    this.referencia,
    this.piloto,
    this.telefono,
    this.telefonoCustodio,
    this.direccionDestino,
    this.paisDestino,
    this.contenedor,
    this.placaCabezal,
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
    descripcion = json['descripcion'];
    enMision = json['enMision'];
    empresa = json['empresa'];
    fechaAsignado = json['fechaAsignado'];
    fechaFin = json['fechaFin'];
    rui = json['rui'];
    nombramiento = json['nombramiento'];
    referencia = json['referencia'];
    piloto = json['piloto'];
    telefono = json['telefono'];
    telefonoCustodio = json['telefonoCustodio'];
    direccionDestino = json['direccionDestino'];
    paisDestino = json['paisDestino'];
    contenedor = json['contenedor'];
    placaCabezal = json['placaCabezal'];
    placaTc = json['placaTc'];
    color = json['color'];
    indicarivo = json['indicarivo'];
    ultimoReporte = json['ultimoReporte'];
    lugar = json['lugar'];
    accion = json['accion'];
  }
}