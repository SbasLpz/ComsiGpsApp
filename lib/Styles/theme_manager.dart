import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {



  // ------- Instancia unica compartida - Singleton ------
  static final ThemeManager instancia = ThemeManager._internal();
  factory ThemeManager() {
    return instancia;
  }
  ThemeManager._internal();

  ThemeMode thMode = ThemeMode.light;

  get myThMode => thMode;

  toggleMode(bool isDark) {
    // ? es el If y : es el else
    print("Hola buenas, estoy en el Toggle del Theme");
    thMode = isDark?ThemeMode.dark:ThemeMode.light;
    notifyListeners();
  }
}