import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeManager2 extends ChangeNotifier {
  // ------- Instancia unica compartida - Singleton ------
  static final ThemeManager2 instancia = ThemeManager2._internal();
  factory ThemeManager2() {
    return instancia;
  }
  ThemeManager2._internal();
  // ------- Instancia unica compartida - Singleton ------

  ThemeAttrs myAttrs = LightThemeAttrs();
  ThemeAttrs get attrs => myAttrs;

  void toggleTheme() {
    bool isLight = attrs.mode == ThemeMode.light;
    myAttrs = isLight ? DarkThemeAttrs() : LightThemeAttrs();
    notifyListeners();  
  }
}