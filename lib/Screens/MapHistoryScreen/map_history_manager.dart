import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapHistoryManager extends ChangeNotifier {
  bool showMarkers = true;

  MapType tipoMapaActual = MapType.normal;


  void changeMarkersState(show) {
    if (showMarkers == show) return;
    showMarkers = show;
    notifyListeners();
  }

  void changeMapsView() {
    //showSatyellite = !showSatyellite;
    tipoMapaActual = tipoMapaActual == MapType.normal ? MapType.satellite : MapType.normal;
    notifyListeners();
  }
}