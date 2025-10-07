import 'package:apprutas/Models/command_data_model.dart';

class CommandModel {
  String? status;
  String? message;
  List<CommandDataModel>? data;

  CommandModel({
    this.status,
    this.message,
    this.data,
  });

  // CommandModel.fromJson(Map<String, dynamic> json) {
  //   status = json['status'];
  //   message = json['message'];
  //   data: (json['data'] as List<dynamic>?)
  //       ?.map((cmd) => CommandDataModel.fromJson(cmd))
  //       .toList()
  //       ?? [];
  // }
  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] is List
          ? (json['data'] as List<dynamic>)
          .map((cmd) => CommandDataModel.fromJson(cmd))
          .toList()
          : [],
    );
  }
}