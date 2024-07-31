part of 'listview_screen.dart';

bool isActive = false;

ListviewManager idsManager = ListviewManager();
ListviewManager2 srchManager = ListviewManager2();
final searchController = TextEditingController();
LastReportManager statusManeger = LastReportManager();
//Set<int> selectedIds = {};
//ListviewManager2 searchManager = ListviewManager2();


mostrarSnackbar(context, int id) {
  print("Se presesiono el elemento: "+id.toString());
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
UnitStatus determineUnitStatus(String lastReport) {
  Duration tiempo = parsearDuracion(lastReport);
  //print("ULTIMO REPORTE FUE HACE: ${tiempo.inMinutes} minutos. ");
  if(tiempo.inMinutes <= 5){
    Color code = Color(0xFF2ECC71);
    return UnitStatus(color: code, tiempo: lastReport);
  } else {
    return UnitStatus(color: Color(0xFF808B96), tiempo: lastReport);
  }
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

List<UnidadModel> ordenarUnidades(List<UnidadModel> lista) {
  lista.sort((a, b) {
    Duration dA = parsearDuracion(a.last!);
    Duration dB = parsearDuracion(b.last!);
    return dA.compareTo(dB);
  });
  return lista;
}



