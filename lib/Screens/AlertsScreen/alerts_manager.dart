import 'package:apprutas/Models/alert_data_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:flutter/cupertino.dart';

class AlertsManager extends ChangeNotifier {

  List<AlertDataModel> alertFiltradas = [];
  List<AlertDataModel> alertAll = [];

  toDeleteItem(int idx) {
    alertas.removeAt(idx);
    notifyListeners();
  }

  search(String query){
    if (query.isEmpty){
      alertFiltradas = alertAll;
    } else {
      alertFiltradas = alertAll
          .where((f) => f.Descripcion!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    print("buscando alertas... ${query}, encontradas: ${alertFiltradas.length}");
    notifyListeners();
  }

  resetSearchText() {
    alertFiltradas = alertAll;
  }
}