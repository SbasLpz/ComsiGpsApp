import 'package:apprutas/Screens/AlertsScreen/alerts_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:flutter/cupertino.dart';

class AlertsManager extends ChangeNotifier {
  //int item_idx = -1;

  toDeleteItem(int idx) {
    alertas.removeAt(idx);
    notifyListeners();
  }
}