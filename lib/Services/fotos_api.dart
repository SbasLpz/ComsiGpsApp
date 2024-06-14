import 'package:apprutas/Models/foto_model.dart';
import 'package:apprutas/Utils/Global/strings.dart' as globalStr;
import 'dart:convert';      // required to encode/decode json data
import 'package:http/http.dart' as http;

Future<List<FotoModel>> fotosFuture = getFotos();

Future<List<FotoModel>> getFotos() async {
  var url = Uri.parse(globalStr.urlApiFotos);
  final response = await http.get(url, headers: {"Content-Type": "application/json"});
  final List body = json.decode(response.body);

  return body.map((item) => FotoModel.fromJson(item)).toList();
}