import 'dart:convert';

import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Models/command_model.dart';
import 'package:apprutas/Models/historial_model.dart';
import 'package:apprutas/Models/link_model.dart';
import 'package:apprutas/Models/new_pass_model.dart';
import 'package:apprutas/Models/recover_model.dart';
import 'package:apprutas/Models/send_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:http/http.dart' as http;
import 'package:session_manager/session_manager.dart';
import '../Models/validation_model.dart';

//Future<ValidationModel> validate = postLogin("", "", "");
Future<List<UnidadModel>> unidadesFuture = getUnidades();

Future<ValidationModel> postLogin(String cuenta, String user, String pass) async {
  Map<String, dynamic> request = {
    'cuenta': cuenta,
    'user': user,
    'pass': pass
  };

  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/login/validarlogin");
  // final req = await http.MultipartRequest('POST', url)
  //   ..fields['cuenta'] = cuenta
  //   ..fields['user'] = user
  //   ..fields['pass'] = pass;
  //var response = await req.send();
  var res = await http.post(url, body: request);
  final body = jsonDecode(res.body);
  // var miRes =  ValidationModel.fromJson(body);
  //
  // if(res.statusCode == 200){
  //
  // } else {
     print("Consulta HECHA: ${ValidationModel.fromJson(body).success}, ${body['msg']}");
  // }

  return ValidationModel.fromJson(body);
}

Future<List<UnidadModel>> getUnidades() async {
  String token = await SessionManager().getString("tokenUser");
  token;
  //print("Token de Usuario a usar: ${token}");
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getAll/"+token);
  //print("URL del enspoint: ${url.toString()}");
  final response = await http.get(url, headers: {});
  //final List body = json.decode(response.body);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];
  //print("DataResp number of units: ${dataResp.length}");
  //print("Code Response: ${response.statusCode}");
  //print("Response SUCCESS: ${json.decode(response.body)['success']}");

  print("ACTUALICE LAS UBICACIONES");

  return dataResp.map((unit) => UnidadModel.fromJson(unit)).toList();
}

Future<List<HistorialModel>> postHistory(String cuenta, String fehaIni, String fechaFin) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': cuenta,
    'fechad': fehaIni,
    'fechah': fechaFin
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getHistory/"+token);

  final response = await http.post(url, headers: {}, body: request);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  return dataResp.map((history)=>HistorialModel.fromJson(history)).toList();
}

Future<List<AlertModel>> getAlerts() async {
  String token = await SessionManager().getString("tokenUser");
  token;
  //print("Token de Usuario a usar: ${token}");
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getAlerts/"+token);
  //print("URL del enspoint: ${url.toString()}");
  final response = await http.get(url, headers: {});
  //final List body = json.decode(response.body);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];
  //print("DataResp number of units: ${dataResp.length}");
  //print("Code Response: ${response.statusCode}");
  //print("Response SUCCESS: ${json.decode(response.body)['success']}");

  print("ACTUALICE LAS ALERTAS !");

  return dataResp.map((alerta) => AlertModel.fromJson(alerta)).toList();
}

Future<List<CommandModel>> getCommands(String id) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/commands/getList/"+token);

  final response = await http.post(url, headers: {}, body: request);

  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  return dataResp.map((cmd)=>CommandModel.fromJson(cmd)).toList();
}

Future<SendModel> sendCommand(String id, String sms) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id,
    'sms': sms
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/commands/sendcommand/"+token);

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie le COMANDO ${sms}, SUCCESS: ${SendModel.fromJson(body).success}");
  return SendModel.fromJson(body);
}

Future<LinkModel> getLink(String id, String timeExp, String typeExp) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id,
    'tiempExp': timeExp,
    'tipoExp': typeExp
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/sharedVehicle/"+token);

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie: ${id}, ${timeExp}, ${typeExp}. SUCCESS del LINK: ${LinkModel.fromJson(body).success}");
  return LinkModel.fromJson(body);
}

Future<NewPassModel> changePassword(String oldPass, String newPass) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'passold': oldPass,
    'passnew': newPass
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/usuarios/changePass/"+token);

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie: ${oldPass}, ${newPass}. SUCCESS del CHANGE PASS: ${NewPassModel.fromJson(body).success}");
  return NewPassModel.fromJson(body);
}

Future<RecoverModel> recuperarPassword(String correo,) async {
  //String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'email': correo
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/usuarios/forgotpassword");

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie: ${correo}. SUCCESS del RECOVER PASS: ${NewPassModel.fromJson(body).success}");
  return RecoverModel.fromJson(body);
}

Future<List<UnidadModel>> getOneVehicle(String id,) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'id': id
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/vehiculo/getOne/"+token);

  final response = await http.post(url, headers: {}, body: request);
  //final body = jsonDecode(response.body);
  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  //print("Envie: ${id}. SUCCESS del GET ONE VEHICLE: ${UnidadModel.fromJson(body).success}");
  return dataResp.map((unit)=>UnidadModel.fromJson(unit)).toList();
}