import 'dart:async';

import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';

import '../../Models/unidad_model.dart';

class MapManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final MapManager instancia = MapManager._internal();
  factory MapManager() {
    return instancia;
  }
  MapManager._internal();
  // ------- Instancia unica compartida - Singleton ------
  Future<List<UnidadModel>> listaUnits = getUnidades();
  List<UnidadModel> listUnits = [];
  var count = 0;
  var stopTimer = false;

  intervalUpdate() {
    Timer.periodic(Duration(seconds: 10), (timer) {
      if(stopTimer) {
        timer.cancel();
      } else {
        exe();
      }
    });
    //notifyListeners();
  }

  exe() async {
    print("******Provider Manager: Se actalizo la data de los marcadores");
    listUnits = await getUnidades();
    count++;
    print("Counter: $count");
    notifyListeners();
  }
}