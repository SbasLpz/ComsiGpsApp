import 'dart:async';
import 'dart:ffi';
import 'package:apprutas/Models/unidad_data_model.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Future<UnidadModel> unidadesFuture = getUnidades();
  //Future<List<UnidadDataModel>> listaUnits = getUnidades();
  List<UnidadDataModel> listUnits = [];

  List<Marker> markersList = [];

  var count = 0;
  var stopTimer = false;
  int intervalo = 10;

  var trackUnit = false;
  var trackUnitId = "";

  var initLocation = LatLng(9.9996, -84.1572);
  var mapZoom = 6.0;

  MapType tipoMapaActual = MapType.normal;

  changeInitLocation(LatLng newInit) {
    initLocation = newInit;
    notifyListeners();
  }

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
    var getUnidades1 = await getUnidades();
    listUnits = getUnidades1.data!;
    count++;
    print("Counter: $count");
    notifyListeners();
  }

  trackSingleUnit(String unidad) {
    trackUnit = !trackUnit;
    print("Valor del TOGGLE de Track Single Unit: ${trackUnit}");
    //trackUnit = value;
    trackUnitId = unidad;
    notifyListeners();
  }

  changeInitZoom (LatLng initLoc, double zoom) {
    if (initLoc == initLocation && zoom == mapZoom) {
      return;
    }
    initLocation = initLoc;
    mapZoom = zoom;
    notifyListeners();
  }

  chagneZoom (double newZoom) {
    if (mapZoom == newZoom) {
      return;
    }
    mapZoom = newZoom;
    notifyListeners();
  }

  void changeMapsView() {
    //showSatyellite = !showSatyellite;
    tipoMapaActual = tipoMapaActual == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }
}