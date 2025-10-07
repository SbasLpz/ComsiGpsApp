import 'package:flutter/cupertino.dart';

import '../../Models/command_model.dart';

class CommandManager extends ChangeNotifier{

    //CommandModel? selected;
    String? selected;
    var infoCmd = "";
    bool estaCargando = false;

    bool hayComandos = false;

    bool showMessage = false;
    String message = "";

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

    changeHayComandos(bool newValue) {
      hayComandos = newValue;
      notifyListeners();
    }

    changeShowMessage(bool newValue) {
      showMessage = newValue;
      notifyListeners();
    }
    setMessage(String newValue) {
      message = newValue;
      notifyListeners();
    }

}