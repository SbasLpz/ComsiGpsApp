import 'dart:async';
import 'dart:ffi';

import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:session_manager/session_manager.dart';

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
  int intervalo = 10;

  intervalUpdate() {
    print("INTERVALOR A USAR: ${intervalo}");
    Timer.periodic(Duration(seconds: intervalo), (timer) {
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