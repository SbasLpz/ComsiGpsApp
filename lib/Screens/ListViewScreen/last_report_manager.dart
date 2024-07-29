import 'dart:async';

import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';

class LastReportManager extends ChangeNotifier {

  // ------- Instancia unica compartida - Singleton ------
  static final LastReportManager instancia = LastReportManager._internal();
  factory LastReportManager() {
    return instancia;
  }
  LastReportManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  List<UnidadModel> unidadesInfo = [];
  var stopUpdater = false;

  intervalUpdate() {
    Timer.periodic(Duration(seconds: 60), (timer) {
      if(stopUpdater) {
        timer.cancel();
      } else {
        updateUnitState();
      }
    });
  }

  updateUnitState() async {
    print("°°|°° Data de las Unidades ACTUALIZADA para su STATE °°|°°");
    unidadesInfo = await getUnidades();
    notifyListeners();
  }
}