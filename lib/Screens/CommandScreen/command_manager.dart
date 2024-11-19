import 'package:flutter/cupertino.dart';

import '../../Models/command_model.dart';

class CommandManager extends ChangeNotifier{

    //CommandModel? selected;
    String? selected;
    var infoCmd = "";
    bool estaCargando = false;

    toggleButton(String? newValue) {
      selected = newValue;
      notifyListeners();
    }

    alert(String valor){
      infoCmd = valor;
      notifyListeners();
    }

    changeEstaCargando(bool newValue) {
      estaCargando = newValue;
      notifyListeners();
    }
}