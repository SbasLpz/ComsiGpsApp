import 'dart:convert';

import 'package:apprutas/Models/validation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManagerCustom {
  static final String _loginDataString = "";

  // Guarda el ValidationModel
  static Future<void> saveLoginData(ValidationModel data) async {
    print("En saveLoginData");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_loginDataString, jsonEncode(data.toJson()));
    print("GUARDADO EL LOGIN DATA: ${data.status}");
  }

  // Recupera el ValidationModel
  static Future<String?> getLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_loginDataString);
  }

  // Borra todos los datos de la sesión (ej: al cerrar sesión)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}