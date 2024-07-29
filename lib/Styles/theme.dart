import 'package:apprutas/Utils/Global/colors.dart';
import 'package:flutter/material.dart';

//const COLOR_PRIMARY = Color(0xff7E26FF);
const COLOR_PRIMARY = Color(0xffcc2936);
const COLOR_GREY = Color(0xff818181);
const COLOR_SENCONDARY = Color(0xffef8409);
const COLOR_TER = Color(0xffb80c09);
const COLOR_DARK = Color(0xff1B3239);

abstract class ThemeAttrs {
  ThemeMode get mode;

  //String get name;
  //IconData get icon;
  ThemeData get mycolors;
}

class LightThemeAttrs implements ThemeAttrs {
  @override
  ThemeMode get mode => ThemeMode.light;

  @override
  ThemeData get mycolors => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color(0xffE8E8E8),
        colorScheme: const ColorScheme.light(
          primary: Color(0xff1B3239),
          onPrimary: Color(0xffFFFFFF),
          secondary: COLOR_SENCONDARY,
          surface: Color(0xffE8E8E8),
        ),
        textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
                color: COLOR_PRIMARY),
            titleMedium: TextStyle(
              fontSize: 18,
              color: COLOR_DARK
            ),
            titleSmall: TextStyle(fontSize: 20),
            bodySmall: TextStyle(
              fontSize: 12,
            ),
            displayMedium: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: COLOR_PRIMARY),
        iconTheme: IconThemeData(
          color: COLOR_PRIMARY,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          backgroundColor: WidgetStateProperty.all(COLOR_SENCONDARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        )),
        cardTheme: CardTheme(color: Color(0xFFE5E0C9)),
      );
}

class DarkThemeAttrs implements ThemeAttrs {
  @override
  ThemeMode get mode => ThemeMode.dark;

  @override
  ThemeData get mycolors => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFFFFFF),
          background: Color(0xFF202020),
          surface: Color(0xFF202020),
          tertiary: Color(0xFF3B3B3B)),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w600, color: COLOR_PRIMARY),
          titleMedium: TextStyle(
            fontSize: 24,
          ),
          titleSmall: TextStyle(fontSize: 20),
          bodySmall: TextStyle(
            fontSize: 15,
          ),
          displayMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
      cardTheme: CardTheme(
          color: Color(0xFF292929)
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          backgroundColor: WidgetStateProperty.all(COLOR_PRIMARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        )),
  );
}
