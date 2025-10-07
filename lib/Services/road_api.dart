import 'dart:convert';

import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Models/command_model.dart';
import 'package:apprutas/Models/historial_model.dart';
import 'package:apprutas/Models/info_data_model.dart';
import 'package:apprutas/Models/link_model.dart';
import 'package:apprutas/Models/new_pass_model.dart';
import 'package:apprutas/Models/recover_model.dart';
import 'package:apprutas/Models/send_model.dart';
import 'package:apprutas/Models/siccap_model.dart';
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Utils/session_manager_custom.dart';
import 'package:http/http.dart' as http;
import 'package:session_manager/session_manager.dart';
import '../Models/validation_model.dart';

//Future<ValidationModel> validate = postLogin("", "", "");
Future<ValidationModel> postLogin(String user, String pass) async {
  print("ENTRE EL POST LOGIN");

  Map<String, dynamic> request = {
    'usuario': user,
    'password': pass
  };

  var url = Uri.parse("https://www.comsigps.com/api_v2/login.php");
  final String apiKey = "Cc13Y7MtTDar49fC3mBz9";
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'X-Api-Key': apiKey, // <--- Aquí pasas el apiKey
  };
  // final req = await http.MultipartRequest('POST', url)
  //   ..fields['cuenta'] = cuenta
  //   ..fields['user'] = user
  //   ..fields['pass'] = pass;
  //var response = await req.send();
  //var res = await http.post(url, body: request);
  var res = await http.post(
    url,
    body: jsonEncode(request), // Se usa jsonEncode para enviar el cuerpo como JSON
    headers: headers, // <--- Aquí pasas las cabeceras
  );
  final body = jsonDecode(res.body);
  // var miRes =  ValidationModel.fromJson(body);
  //
  // if(res.statusCode == 200){
  //
  // } else {
  print("Consulta HECHA: ${ValidationModel.fromJson(body).status}, ${body['message']}");
  // }

  return ValidationModel.fromJson(body);
}

Future<List<UnidadDataModel>> unidadesFuture = getUnidades();

Future<List<UnidadDataModel>> getUnidades() async {
  print("ESTOY EN getUnidades()");
  final String? stringData  = await SessionManagerCustom.getLoginData();
  print("StringData: "+stringData!);

  final Map<String, dynamic> jsonMap = jsonDecode(stringData!);
  final data = ValidationModel.fromJson(jsonMap);
  print("seccess getLoginData: ${data.status}");


  Map<String, dynamic> request = {
    'id_grupo': data.data!.idGrupo,
    'token': data.data!.token
  };

  print("id_grupo: ${data.data!.idGrupo} - token ${data.data!.token}");

  //print("Token de Usuario a usar: ${token}");
  var url = Uri.parse("https://www.comsigps.com/api_v2/listadoGeneral.php");

  var res = await http.post(
    url,
    body: jsonEncode(request)
  );
  //final body = jsonDecode(res.body);
  //print("URL del enspoint: ${url.toString()}");
  //final response = await http.get(url, headers: {});
  //final List body = json.decode(response.body);

  final List<dynamic> dataResp = res.statusCode == 200 ? json.decode(res.body)['data'] : [];
  //print("DataResp number of units: ${dataResp.length}");
  //print("Code Response: ${response.statusCode}");
  //print("Response SUCCESS: ${json.decode(response.body)['success']}");

  print("♠♠♠ Unidades obtenidas ♠♠♠: ${const JsonEncoder.withIndent("  ").convert(jsonDecode(res.body))}");

  return dataResp.map((unit) => UnidadDataModel.fromJson(unit)).toList();
}

Future<HistorialModel> postHistory(String idgps, String fehaIni, String horaInicio, String fechaFin, String horaFinal) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'token': token,
    'idgps': idgps,
    'fechaInicio': fehaIni,
    'horaInicio': horaInicio,
    'fechaFinal': fechaFin,
    'horaFinal': horaFinal
  };
  var url = Uri.parse("https://www.comsigps.com/api_v2/historial.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));

  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];
  final body = jsonDecode(response.body);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    print("---> HISTORIAL obtenidas: ${const JsonEncoder.withIndent("  ").convert(jsonDecode(response.body))}");
    return HistorialModel.fromJson(body);
  } else {
    print("---> Error HTTP Historial: ${response.statusCode} ||");
    return HistorialModel(
      status: "error",
      message: "Error HTTP: ${response.statusCode}",
      data: [],
    );
  }

  return HistorialModel.fromJson(body);
}

Future<AlertModel> alertasFuture = getAlerts();

Future<AlertModel> getAlerts() async {
  String token = await SessionManager().getString("tokenUser");
  String idGrupo = await SessionManager().getString("idGrupo");

  Map<String, dynamic> request = {
    'id_grupo': idGrupo,
    'token': token,
  };
  //print("Token de Usuario a usar: ${token}");
  var url = Uri.parse("https://www.comsigps.com/api_v2/listadoAlertas.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));

  //final List body = json.decode(response.body);

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    print("▬▬ ALERTAS obtenidas ♠♠: ${const JsonEncoder.withIndent("  ").convert(jsonDecode(response.body))}");
    return AlertModel.fromJson(body);
  } else {
    print("▬▬ Error HTTP ALERTAS: ${response.statusCode} ▬");
    return AlertModel(
      success: false,
      message: "Error HTTP: ${response.statusCode}",
      data: [],
    );
  }
}

Future<CommandModel> getCommands(String idgps) async {
  String token = await SessionManager().getString("tokenUser");
  String idGrupo = await SessionManager().getString("idGrupo");
  print("GETCOMMANDS / Token de Usuario a usar: ${token} - idGrupo: ${idGrupo} - idgps: ${idgps}");

  Map<String, dynamic> request = {
    'id_grupo': idGrupo,
    'token': token,
    'idgps': idgps
  };
  var url = Uri.parse("https://www.comsigps.com/api_v2/obtenerComandos.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));

  if (response.statusCode == 200) {
    final body = jsonDecode(response.body);
    print("▬▬ Unidades obtenidas GET ONE VEHICLE ♠♠: ${const JsonEncoder.withIndent("  ").convert(jsonDecode(response.body))}");
    return CommandModel.fromJson(body);
  } else {
    print("▬▬ Error HTTP: ${response.statusCode} ▬");
    return CommandModel(
      status: "false",
      message: "Error HTTP: ${response.statusCode}",
      data: [],
    );
  }

  // final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body) : {};
  //
  // return dataResp.map((cmd)=>CommandModel.fromJson(cmd)).toList();
}

Future<SendModel> sendCommand(String idgps, String id_sms) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'token': token,
    'idgps': idgps,
    'id_sms_hardware': id_sms
  };
  var url = Uri.parse("https://www.comsigps.com/api_v2/enviarComandos.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie le COMANDO ${id_sms}, SUCCESS: ${SendModel.fromJson(body).status}");
  return SendModel.fromJson(body);
}

Future<NewPassModel> changePassword(String oldPass, String newPass, String confirmPass) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'token': token,
    'old_password': oldPass,
    'new_password': newPass,
    'confirm_new_password': confirmPass
  };
  var url = Uri.parse("https://www.comsigps.com/api_v2/cambiarPassword.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie: ${oldPass}, ${newPass}. SUCCESS del CHANGE PASS: ${NewPassModel.fromJson(body).status}");
  return NewPassModel.fromJson(body);
}

Future<SiccapModel> getSiccapData(String idgps) async {
  String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'token': token,
    'idgps': idgps
  };
  print("Token de Usuario a usar: ${token}, idgps: ${idgps} SICCAP");
  var url = Uri.parse("https://www.comsigps.com/api_v2/siccap.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));
  print("SICCAP HELLO ${response.statusCode}");
  print("RAW RESPONSE BODY: ${response.body}");
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("SUCCESS del GET SICCAP DATA: ${SiccapModel.fromJson(body).status}");
  return SiccapModel.fromJson(body);
}

Future<RecoverModel> recuperarPassword_____(String correo,) async {
  //String token = await SessionManager().getString("tokenUser");
  Map<String, dynamic> request = {
    'email': correo
  };
  var url = Uri.parse("https://roadcontrol.co/tracking-es/api/usuarios/forgotpassword");

  final response = await http.post(url, headers: {}, body: request);
  final body = jsonDecode(response.body);
  //final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("Envie: ${correo}. SUCCESS del RECOVER PASS: ${NewPassModel.fromJson(body).status}");
  return RecoverModel.fromJson(body);
}

Future<List<InfoDataModel>> getOneVehicle(String idgps) async {
  String token = await SessionManager().getString("tokenUser");
  String idGrupo = await SessionManager().getString("idGrupo");
  print("Token de Usuario a usar: ${token} - idGrupo: ${idGrupo} - idgps: ${idgps}");

  Map<String, dynamic> request = {
    'id_grupo': idGrupo,
    'token': token,
    'idgps': idgps
  };

  var url = Uri.parse("https://www.comsigps.com/api_v2/listadoGeneral2.php");

  final response = await http.post(url, headers: {}, body: jsonEncode(request));
  //final body = jsonDecode(response.body);
  final List<dynamic> dataResp = response.statusCode == 200 ? json.decode(response.body)['data'] : [];

  print("♠♠♠ Unidades obtenidas GET ONE VEHICLE♠♠♠: ${const JsonEncoder.withIndent("  ").convert(jsonDecode(response.body))}");
  //print("Envie: ${id}. SUCCESS del GET ONE VEHICLE: ${UnidadModel.fromJson(body).success}");
  return dataResp.map((unit)=>InfoDataModel.fromJson(unit)).toList();
}