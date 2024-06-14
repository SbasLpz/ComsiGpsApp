import 'dart:convert';
import 'package:apprutas/Services/fotos_api.dart';
import 'package:apprutas/Widgets/foto_element.dart';
import 'package:apprutas/Widgets/foto_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:apprutas/Models/foto_model.dart' as FotoModel;

part 'listview_controller.dart';

class ListviewScreen extends StatelessWidget {
  const ListviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: fotosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData){
                final fotos = snapshot.data;
                return buildFotos(fotos!);
              } else {
                return Center(
                  child: Text("Algo salio mal..."),
                );
              }
            },
          )
        )
      ),
    );
  }

}
