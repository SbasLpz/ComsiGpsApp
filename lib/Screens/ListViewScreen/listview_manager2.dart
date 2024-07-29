import 'package:apprutas/Models/foto_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:flutter/cupertino.dart';

class ListviewManager2 extends ChangeNotifier{

  List<UnidadModel> units = [];
  List<UnidadModel> allUnits = [];

  bool isChecked = false;

  // ListviewManager2({
  //   this.mp = "HolaMundo"
  // });

  search(String query){
    //print("All Units: ${allUnits.length}");
    if (query.isEmpty){
      units = allUnits;
    } else {
      units = allUnits.where((f) => f.desc!.toLowerCase().contains(query.toLowerCase())).toList();
    }
    print("buscando... ${query}, encontrados: ${units.length}");
    notifyListeners();
  }

  resetSearchText() {
    units = allUnits;
  }

  resetAllSelected(bool value) {
    if(value){
      isChecked = value;
    } else {

    }
  }
}