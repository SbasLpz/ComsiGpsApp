class AlertDataModel {
  String? NombreEvento;
  String? Descripcion;
  String? FechaServidor;

  AlertDataModel({
    this.NombreEvento,
    this.Descripcion,
    this.FechaServidor,
  });

  factory AlertDataModel.fromJson(Map<String, dynamic> json) {
    return AlertDataModel(
        NombreEvento: json["NombreEvento"] ?? 'Alerta de segundo nivel',
        Descripcion: json["Descripcion"] ?? 'No hay información adicional.',
        FechaServidor: json["FechaServidor"] ?? ''
    );
  }
}