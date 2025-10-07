part of 'unit_info_screen.dart';

const tam = 25.0;

String getValueFromDescripcion(String descripcion, String key) {

  final parts = descripcion.split(',');

  for (var part in parts) {

    final kv = part.split(':');
    if (kv.length == 2) {
      final k = kv[0].trim();
      final v = kv[1].trim();

      if (k.toLowerCase() == key.toLowerCase()) {
        return v;
      }
    }
  }

  return "No definido"; // si no se encuentra
}

String minutesToTime(int minutos) {
  int dias = minutos ~/ (24 * 60);
  int horasRestantes = (minutos % (24 * 60)) ~/ 60;
  int minutosRestantes = minutos % 60;

  String resultado = '';
  if (dias > 0) resultado += '$dias' + 'd ';
  if (horasRestantes > 0 || dias > 0) resultado += '$horasRestantes' + 'h ';
  if (minutosRestantes > 0 || (dias == 0 && horasRestantes == 0)) resultado += '$minutosRestantes' + 'm';

  return resultado.trim();  // Elimina espacios finales
}