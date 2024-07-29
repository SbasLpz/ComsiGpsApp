import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ValidatorManager extends ChangeNotifier {

  // ------- Instancia unica compartida - Singleton ------
  static final ValidatorManager instancia = ValidatorManager._internal();
  factory ValidatorManager() {
    return instancia;
  }
  ValidatorManager._internal();
  // ------- Instancia unica compartida - Singleton ------


  DateTime initDate = DateTime(2023);
  TimeOfDay initTime = TimeOfDay(hour: 00, minute: 00);

  TimeOfDay endTime = TimeOfDay(hour: 00, minute: 00);
  var sameDay = false;
  var previousHour = false;

  var validDates = false;
  var textoAdver =  "";
  //var dateTimeIniSelected = false;

  validar() {
    print("ENTRE AL VALIDAR()");

    if(sameDay && previousHour) {
      validDates = false;
      textoAdver = "NOTA: Al ser el mismo dia, la hora NO puede ser anterior a la hora de inicio.";
      notifyListeners();
    } else {
      validDates = true;
      textoAdver =  " ";
      notifyListeners();
    }
  }
}