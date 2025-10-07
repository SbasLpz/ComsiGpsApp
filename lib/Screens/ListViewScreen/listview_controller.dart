part of 'listview_screen.dart';

bool isActive = false;

ListviewManager idsManager = ListviewManager();
ListviewManager2 srchManager = ListviewManager2();
final searchController = TextEditingController();
LastReportManager statusManeger = LastReportManager();
//Set<int> selectedIds = {};
//ListviewManager2 searchManager = ListviewManager2();


mostrarSnackbar(context, String id) {
  print("Se presesiono el elemento: "+id);
}

// searchListener() {
//   print("Dentro del SearchListener(), valor: ${searchController.text}");
//   searchManager.search(searchController.text);
//
// }

class UnitStatus {
  final Color color;
  final String tiempo;

  UnitStatus({required this.color, required this.tiempo});
}
UnitStatus determineUnitStatus(String? lastReport) {
  //print("@@♠4♠4♠4♠4♠♠ Refresque el LastREPORT de la UNIDAD ---|||");
  if(lastReport == null){
    return UnitStatus(color: Color(0xFF808B96), tiempo: "undefined");
  }
  Duration tiempo = parsearDuracion("${lastReport}m");
  //print("ULTIMO REPORTE FUE HACE: ${tiempo.inMinutes} minutos. ");
  if(tiempo.inMinutes < 6){
    Color code = Color(0xFF2ECC71);
    return UnitStatus(color: code, tiempo: minutesToTime(int.parse(lastReport.trim())));
  } else {
    return UnitStatus(color: Color(0xFF808B96), tiempo: minutesToTime(int.parse(lastReport.trim())));
  }
}

UnitStatus calculateUnitStatus(String? dateLatReport) {
  var currentDate = DateTime.now();
  print("DEVICE current DateTime is $currentDate");
  return UnitStatus(color: Colors.black, tiempo: currentDate.toString());
}

Duration parsearDuracion(String tiempo) {
  List<String> partes = tiempo.split(' ');

  int dias = 0, horas = 0, minutos = 0;

  for (String parte in partes) {
    if (parte.endsWith('d')) {
      dias = int.parse(parte.substring(0, parte.length - 1));
    } else if (parte.endsWith('h')) {
      horas = int.parse(parte.substring(0, parte.length - 1));
    } else if (parte.endsWith('m')) {
      minutos = int.parse(parte.substring(0, parte.length - 1));
    }
  }

  return Duration(days: dias, hours: horas, minutes: minutos);
}

// List<UnidadDataModel> ordenarUnidades(List<UnidadDataModel> lista) {
//   //print("estoy en ordenarUnidades ${lista.length}");
//   lista.sort((a, b) {
//     //print("a value: ${a.tiempoReporte} - b value: ${b.tiempoReporte}");
//     if (a.tiempoReporte == null && b.tiempoReporte == null) return 0;
//
//     if (a.tiempoReporte == null) return 1;
//     if (b.tiempoReporte == null) return -1;
//
//     Duration dA = parsearDuracion(a.tiempoReporte.toString().trim());
//     Duration dB = parsearDuracion(b.tiempoReporte.toString().trim());
//
//     return dA.compareTo(dB);
//   });
//   return lista;
// }

List<UnidadDataModel> ordenarUnidades(List<UnidadDataModel> lista) {
  lista.sort((a, b) {
    if (a.tiempoReporte == null && b.tiempoReporte == null) return 0;
    if (a.tiempoReporte == null) return 1;
    if (b.tiempoReporte == null) return -1;

    // Asume que tiempoReporte es num en minutos; conviértelo directamente a Duration
    int minutosA = int.parse(a.tiempoReporte.toString().trim());
    int minutosB = int.parse(b.tiempoReporte.toString().trim());

    Duration dA = Duration(minutes: minutosA);
    Duration dB = Duration(minutes: minutosB);

    return dA.compareTo(dB);  // Ascendente: menor (reciente) primero
  });
  return lista;
}

List<UnidadDataModel> ordenarUnidades2(List<UnidadDataModel> lista) {
  lista.sort((a, b) {
    if (a.tiempoReporte == null && b.tiempoReporte == null) return 0;
    if (a.tiempoReporte == null) return 1;
    if (b.tiempoReporte == null) return -1;

    int minutosA = int.tryParse(a.tiempoReporte.toString().trim()) ?? 0;
    int minutosB = int.tryParse(b.tiempoReporte.toString().trim()) ?? 0;

    // Reglas de orden:
    // 1. Los negativos siempre al final
    if (minutosA < 0 && minutosB < 0) {
      return minutosA.compareTo(minutosB); // entre negativos, orden normal
    } else if (minutosA < 0) {
      return 1; // A va después de B
    } else if (minutosB < 0) {
      return -1; // B va después de A
    }

    // 2. Entre no-negativos, orden ascendente normal
    return minutosA.compareTo(minutosB);
  });

  return lista;
}

// String minutesToTime(int minutos) {
//   int horas = minutos ~/ 60;  // División entera para horas
//   int minutosRestantes = minutos % 60;  // Minutos restantes
//
//   String resultado = '';
//   if (horas > 0) resultado += '$horas' + 'h ';
//   if (minutosRestantes > 0 || horas == 0) resultado += '$minutosRestantes' + 'm';
//
//   return resultado.trim();  // Elimina espacios finales
// }

String minutesToTime(int minutos) {
  int dias = minutos ~/ (24 * 60);  // Días (división entera por 1440 min/día)
  int horasRestantes = (minutos % (24 * 60)) ~/ 60;  // Horas restantes
  int minutosRestantes = minutos % 60;  // Minutos restantes

  String resultado = '';
  if (dias > 0) resultado += '$dias' + 'd ';
  if (horasRestantes > 0 || dias > 0) resultado += '$horasRestantes' + 'h ';
  if (minutosRestantes > 0 || (dias == 0 && horasRestantes == 0)) resultado += '$minutosRestantes' + 'm';

  return resultado.trim();  // Elimina espacios finales
}