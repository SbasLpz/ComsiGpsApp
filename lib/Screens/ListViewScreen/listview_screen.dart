import 'dart:convert';
import 'dart:ui';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/ListViewScreen/last_report_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager2.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/fotos_api.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Widgets/foto_element.dart';
import 'package:apprutas/Widgets/foto_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../Models/foto_model.dart';

part 'listview_controller.dart';

class ListviewScreen extends StatefulWidget {
  const ListviewScreen({super.key});

  @override
  State<ListviewScreen> createState() => _ListviewScreen();

}

class _ListviewScreen extends State<ListviewScreen> {

  @override
  void initState() {
    statusManeger.stopUpdater = false;
    statusManeger.intervalUpdate();
    print("Puse los 2 Listener en UnidadesScreen");
    super.initState();
  }
  
  @override
  void dispose() {
    //searchController.dispose();
    statusManeger.stopUpdater = true;
    print("Ejecute el Dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final srchManager = context.watch<ListviewManager2>();
    final idsManager1 = context.watch<ListviewManager>();
    final unitsInfo = context.watch<LastReportManager>();
    bool isChecked = false;

    return Scaffold(
      body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SearchBar(
                          controller: searchController,
                          hintText: "Nombre de la unidad...",
                          backgroundColor: MaterialStateProperty.all(Color(0xffE5E0C9)),
                          onChanged: (value) {
                            print("New Value Detected: ${value}");
                            context.read<ListviewManager2>().search(value);
                          },
                          leading: IconButton(
                              onPressed: () {
                                //print("Controllerop: ${searchController.text}");
                              },
                              icon: Icon(Icons.search)
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          searchController.text = "";
                          srchManager.resetSearchText();
                          idsManager.quitarSelecteds();
                          idsManager1.isChecked = false;
                          idsManager1.quitarSelecteds();
                          print("Presione RESET icon");},
                        icon: Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Seleccionar todos: "),
                      Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(COLOR_SENCONDARY),
                          side: BorderSide(width: 2, color: COLOR_SENCONDARY),
                          value: idsManager1.isChecked,
                          onChanged: (bool? newValue){
                            idsManager1.selectAll(srchManager.units, newValue!);
                            print("Checked dice hola");
                          }
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    height: 30,
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: unidadesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData){
                          var mydata = ordenarUnidades(snapshot.data!);
                          if(unitsInfo.unidadesInfo.isNotEmpty) {
                            mydata = ordenarUnidades(unitsInfo.unidadesInfo);
                          }
                          final unidades = srchManager.units.isEmpty ? mydata : ordenarUnidades(srchManager.units);
                          srchManager.allUnits = mydata!;
                          return buildFotos(unidades!, context);
                        } else {
                          return Center(
                            child: Text("Algo salio mal..."),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
          )
      ),
    );
  }
}
