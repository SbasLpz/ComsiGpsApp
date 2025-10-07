import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:flutter/cupertino.dart';

class ListviewManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final ListviewManager instancia = ListviewManager._internal();
  factory ListviewManager() {
    return instancia;
  }
  ListviewManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  Set<String> selectedIds = {};
  bool isChecked = false;

  void selectedItems(String id) {
    if(selectedIds.contains(id)){
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    print("Cantidad de ID's Seleceted: ${selectedIds.length}");
    notifyListeners();
  }

  void quitarSelecteds() {
    selectedIds = {};
    selectedIds.clear();
    notifyListeners();
  }

  void selectAll(List<UnidadDataModel> units, bool value) {
    isChecked = value;
    print("SELECT ALL VAL: ${value}");
    for(UnidadDataModel unidad in units){
      selectedIds.add(unidad.IDGPS!.toString().trim());
    }
    notifyListeners();
  }

}