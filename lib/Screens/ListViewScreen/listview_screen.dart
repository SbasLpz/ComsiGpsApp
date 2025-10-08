import 'dart:convert';
import 'dart:core';
import 'dart:ui';
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Screens/ListViewScreen/last_report_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager2.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Styles/theme_manager2.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Widgets/foto_element.dart';
import 'package:apprutas/Widgets/foto_item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:theme_manager/theme_manager.dart';

import '../../Models/foto_model.dart';

part 'listview_controller.dart';

class ListviewScreen extends StatefulWidget {
  const ListviewScreen({Key? key}) : super(key: key);

  @override
  State<ListviewScreen> createState() => _ListviewScreen();

}

class _ListviewScreen extends State<ListviewScreen> {
  final GlobalKey _listKey = GlobalKey();
  @override
  void initState() {

    // setState(() {
    //
    // });
    statusManeger.stopUpdater = false;
    statusManeger.intervalUpdate();
    print("Puse los 2 Listener en UnidadesScreen");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalContext.appBar.value = "Unidades";
    });
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
    final navManager = context.watch<NavigationManager>();
    //final thm = context.watch<ThemeManager2>();

    return Scaffold(
      body: Consumer<ThemeManager2>(
        builder: (context, themeManeger, child){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            //setState(() {});
          });
          return ConstrainedBox(
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
                              hintText: "Nombre o ID unidad...",
                              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
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
                              //idsManager.quitarSelecteds();
                              //srchManager.units.clear();

                              idsManager1.isChecked = false;
                              idsManager1.quitarSelecteds();
                              print("Presione RESET icon");
                              unidadesFuture;
                              },
                            icon: Icon(Icons.refresh),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text("Seleccionar todos: "),
                          Checkbox(
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.all(Theme.of(context).colorScheme.tertiary),
                              side: BorderSide(width: 2, color: Theme.of(context).colorScheme.tertiary),
                              value: idsManager1.isChecked,
                              onChanged: (bool? newValue){
                                //idsManager1.selectAll(srchManager.units, newValue!);
                                idsManager1.selectAll(srchManager.allUnits, newValue!);
                                print("Checked dice hola");
                                if(!newValue){
                                  idsManager1.quitarSelecteds();
                                }
                              }
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(EdgeInsets.fromLTRB(20, 10, 20, 10))
                                ),
                                icon: Icon(Icons.map, size: 15, color: Theme.of(context).colorScheme.onPrimary,),
                                onPressed: () {
                                    navManager.setIndex(1);
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) =>  MapScreen(),));
                                },
                                label: Text(
                                    "Ver unidades",
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                                ),
                            ),
                          )
                        ],
                      ),
                      // Container(
                      //   color: Colors.blue[200],
                      //   child: Row(
                      //     children: [
                      //       IconButton(
                      //           onPressed: (){
                      //
                      //           },
                      //           icon: Icon(Icons.close_outlined,color: Colors.grey,)
                      //       ),
                      //       Text("Para ver las unidades seleccione la opcion Mapa.")
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 10,
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
                              var dataList = snapshot.data;

                              if(dataList == null) {
                                //print("DATALIST DEL SNAPSHOT 222 ES NULL");
                              } else {
                                //print("DATALIST DEL SNAPSHOT HAS DATA (LAST ONE): ${dataList.last.Descripcion}");
                              }
                              //print("\n Snapshot DATA refreshed \n");
                              var mydata = ordenarUnidades2(dataList!);
                              if(unitsInfo.unidadesInfo.isNotEmpty) {
                                mydata = ordenarUnidades2(dataList);
                                //print("☻ LAST from MILTON ☻: "+unitsInfo.unidadesInfo.where((u)=>u.desc == "TCI2428 MILTON MUNGUIA " ).first!.last!);
                              }
                              var unidades = srchManager.units.isEmpty ? mydata : ordenarUnidades2(srchManager.units);
                              //print("Size of Unidades 2222 $unidades");
                              if(srchManager.units.isEmpty) {
                                //print("☺☺ ☺ The If for Unidades i equal to mydata ☺☺ ☺");
                              } else {
                                //mydata = mydata.where((item) => srchManager.units.any((unit) => unit.id_gps == item.id_gps)).toList();
                                var dataUpdated = mydata.where((item) => srchManager.units.any((unit) => unit.IDGPS == item.IDGPS)).toList();
                                unidades = dataUpdated;
                              }
                              srchManager.allUnits = mydata!;
                              //print("Size of Unidades =a $unidades");
                              return buildFotos(unidades!, context, _listKey);
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Ocurrio un problema: ${snapshot.data}"),
                                  Image.asset(
                                    'assets/images/noData.png',
                                    width: 200,
                                    height: 200,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
              )
          );
        },
      )
    );
  }
}
