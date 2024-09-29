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

  Set<int> selectedIds = {};
  bool isChecked = false;

  void selectedItems(int id) {
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

  void selectAll(List<UnidadModel> units, bool value) {
    isChecked = value;
    print("SELECT ALL VAL: ${value}");
    for(UnidadModel unidad in units){
      selectedIds.add(int.parse(unidad.id_gps!));
    }
    notifyListeners();
  }

}