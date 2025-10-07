import 'package:apprutas/Models/foto_model.dart';
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:flutter/cupertino.dart';

class ListviewManager2 extends ChangeNotifier{

  List<UnidadDataModel> units = [];
  List<UnidadDataModel> allUnits = [];

  bool isChecked = false;

  // ListviewManager2({
  //   this.mp = "HolaMundo"
  // });

  search(String query){
    //print("All Units: ${allUnits.length}");
    if (query.isEmpty){
      units = allUnits;
    } else {
      //|| f.IDGPS.toString().toLowerCase().contains(query)
      units = allUnits.where((f) => f.Descripcion.toString().toLowerCase().contains(query.toLowerCase())
      || f.Placa.toString().toLowerCase().contains(query) || f.nombrePiloto.toString().toLowerCase().contains(query)
          || f.IDGPS.toString().toLowerCase().contains(query)
      ).toList();
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