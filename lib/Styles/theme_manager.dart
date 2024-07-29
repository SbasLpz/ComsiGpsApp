import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final ThemeManager instancia = ThemeManager._internal();
  factory ThemeManager() {
    return instancia;
  }
  ThemeManager._internal();
  // ------- Instancia unica compartida - Singleton ------

  ThemeMode thMode = ThemeMode.light;
  //bool darkMd = false;

  //get myThMode => thMode;

  void toggleMode(bool isDark) {
    print("IS DARK VALUE: ${isDark}");
    // ? es el If y : es el else
    thMode = isDark ? ThemeMode.dark : ThemeMode.light;
    print("Hola buenas, estoy en el Toggle del Theme: ${thMode.name}");
    notifyListeners();
  }
}