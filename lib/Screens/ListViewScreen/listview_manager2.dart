import 'package:apprutas/Models/foto_model.dart';
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
          || f.asignado.toString().toLowerCase().contains(query.toLowerCase())
          || f.empresa.toString().toLowerCase().contains(query.toLowerCase())
          || f.descripcion_ordenada.toString().toLowerCase().contains(query.toLowerCase())
      || f.Placa.toString().toLowerCase().contains(query.toLowerCase()) || f.nombrePiloto.toString().toLowerCase().contains(query.toLowerCase())
          || f.IDGPS.toString().toLowerCase().contains(query.toLowerCase()),
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