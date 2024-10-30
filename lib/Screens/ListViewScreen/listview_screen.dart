import 'dart:convert';
import 'dart:ui';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/ListViewScreen/last_report_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager2.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/fotos_api.dart';
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
    GlobalContext.appBar.value = "Unidades";
    setState(() {

    });
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
    final navManager = context.watch<NavigationManager>();
    //final thm = context.watch<ThemeManager2>();

    return Scaffold(
      body: Consumer<ThemeManager2>(
        builder: (context, themeManeger, child){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {});
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
                              idsManager1.isChecked = false;
                              idsManager1.quitarSelecteds();
                              print("Presione RESET icon");},
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
                                idsManager1.selectAll(srchManager.units, newValue!);
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
                              var mydata = ordenarUnidades(snapshot.data!);
                              if(unitsInfo.unidadesInfo.isNotEmpty) {
                                mydata = ordenarUnidades(unitsInfo.unidadesInfo);
                              }
                              final unidades = srchManager.units.isEmpty ? mydata : ordenarUnidades(srchManager.units);
                              srchManager.allUnits = mydata!;
                              return buildFotos(unidades!, context, _listKey);
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
          );
        },
      )
    );
  }
}
