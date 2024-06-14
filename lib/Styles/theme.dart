import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color(0xff7E26FF);

/** Tema de la App Claro (Por Default) **/
ThemeData lightMyAppTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: COLOR_PRIMARY
  ),
  iconTheme: IconThemeData(
    color: COLOR_PRIMARY
  )
);

/** Tema de la App Oscuro (Dark Mode) **/
ThemeData darkMyAppTheme = ThemeData(
    brightness: Brightness.dark
);