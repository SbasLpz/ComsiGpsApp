import 'package:apprutas/Utils/Global/colors.dart';
import 'package:flutter/material.dart';

//const COLOR_PRIMARY = Color(0xff7E26FF);
const COLOR_PRIMARY = Color(0xffE5412D);
const COLOR_GREY = Color(0xff818181);
const COLOR_SENCONDARY = Color(0xff393939);
const COLOR_TER = Color(0xff4D4D4D);
const COLOR_DARK = Color(0xff1B3239);
const DARK_PRIMARY = Color(0xff393939);
const DARK_SECONDARY = Color(0xff4D4D4D);
const DARK_TER = Color(0xffE2E2E2);

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
        scaffoldBackgroundColor: Color(0xffF4F4F4),
        colorScheme: ColorScheme.light(
          //primary: Color(0xff1B3239),
          primary: COLOR_PRIMARY,
          onPrimary: Color(0xffF4F4F4),
          secondary: COLOR_SENCONDARY,
          onSecondary: Color(0xffE2E2E2),
          tertiary: COLOR_TER,
          onTertiary: COLOR_SENCONDARY,
          inversePrimary: COLOR_TER,
          onPrimaryContainer: Colors.white,
          surface: Color(0xffF4F4F4),
        ),
        textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 30,
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
                color: Colors.black),
          displaySmall: TextStyle(
            fontSize: 15
          )
        ),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: COLOR_PRIMARY),
        iconTheme: IconThemeData(
          color: COLOR_PRIMARY,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          backgroundColor: WidgetStateProperty.all(COLOR_PRIMARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        )),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: COLOR_PRIMARY,
      backgroundColor: Color(0xffe8e8e8),
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states){
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(color: Color(0xffF4F4F4)); // Color del icono seleccionado
        }
        return IconThemeData(color: COLOR_SENCONDARY);
      }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          side: WidgetStateProperty.all(BorderSide(color: COLOR_SENCONDARY, width: 2),),
          //backgroundColor: WidgetStateProperty.all(COLOR_SENCONDARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        )),
        navigationBarTheme: NavigationBarThemeData(
            indicatorColor: COLOR_PRIMARY,
          backgroundColor: Color(0xffececec),
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states){
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: mycolors.colorScheme.onPrimary); // Color del icono seleccionado
            }
            return IconThemeData(color: mycolors.colorScheme.secondary);
          }),
        ),
        cardTheme: CardTheme(color: Color(0xffE2E2E2)),
    timePickerTheme: TimePickerThemeData(
      dayPeriodColor: Colors.redAccent,
    ),
      );
}

class DarkThemeAttrs implements ThemeAttrs {
  @override
  ThemeMode get mode => ThemeMode.dark;

  @override
  ThemeData get mycolors => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DARK_PRIMARY,
      colorScheme: ColorScheme.dark(
          primary: DARK_PRIMARY,
          onPrimary: Color(0xffF4F4F4),
          secondary: DARK_TER,
          onSecondary: DARK_SECONDARY,
          background: Color(0xFF16282e),
          surface: DARK_PRIMARY,
          tertiary: DARK_SECONDARY,
          inversePrimary: DARK_TER,
          onTertiary: DARK_TER,
        onPrimaryContainer: Colors.black,
      ),
      textTheme: TextTheme(
          titleLarge: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w600, color: COLOR_PRIMARY),
          titleMedium: TextStyle(
            fontSize: 18,
          ),
          titleSmall: TextStyle(fontSize: 20),
          bodySmall: TextStyle(
            fontSize: 12,
          ),
          displayMedium: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: TextStyle(
              fontSize: 15
          )
      ),
      cardTheme: CardTheme(
          color: DARK_SECONDARY
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          //textStyle: WidgetStateProperty.all(TextStyle(color: Color(0xff1B3239))),
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          backgroundColor: WidgetStateProperty.all(COLOR_PRIMARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        )),
    navigationBarTheme: NavigationBarThemeData(
          indicatorColor: COLOR_PRIMARY,
          backgroundColor: Colors.black26,
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states){
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: Color(0xffF4F4F4)); // Color del icono seleccionado
            }
            return IconThemeData(color: DARK_TER);
          }),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0)),
          side: WidgetStateProperty.all(BorderSide(color: COLOR_SENCONDARY, width: 2),),
          //backgroundColor: WidgetStateProperty.all(COLOR_SENCONDARY),
          //textStyle: WidgetStateProperty.all(TextStyle(color: Colors.white)),
          shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
        )),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: COLOR_PRIMARY,
      backgroundColor: Color(0xff4a4a4a),
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states){
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(color: mycolors.colorScheme.onPrimary); // Color del icono seleccionado
        }
        return IconThemeData(color: mycolors.colorScheme.secondary);
      }),
    ),
    timePickerTheme: TimePickerThemeData(
        dialHandColor: Colors.blue,
    ),
    datePickerTheme: DatePickerThemeData(
      todayBackgroundColor: MaterialStateProperty.all(Colors.blue),
        dayBackgroundColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.blue; // Color de fondo del día seleccionado
          }
          return Colors.transparent; // Color de fondo de los días no seleccionados
        })
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.blue), // Color de texto para los botones "Cancelar" y "Confirmar"
      ),
    ),
  );
}


