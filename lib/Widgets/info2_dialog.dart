import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/CommandScreen/command_screen.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Screens/InfoUnitScreen/unit_info_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_manager.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/SiccapScreen/siccap_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

Widget infoDialog2 (UnidadDataModel unidad, String siccap, BuildContext context) {
  const padd = 8.0;
  const widd = 100.0;
  print("SICCAP VALUE IS ${siccap}");
  print("UNIDAD VALUE IS idgps:${unidad.IDGPS}, desc:${unidad.Descripcion}");
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        //color: Colors.white,
        child: FutureBuilder(
          future: getOneVehicle(unidad.IDGPS!),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                  height: 200.0,
                  child: Center(child: CircularProgressIndicator())
              );
            } else if (snapshot.hasData){
              var miUnidad = snapshot.data!.first;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    //color: Colors.yellowAccent,
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                                unidad.Descripcion.toString(),
                                style: txtTheme.titleLarge?.copyWith(fontSize: 18)
                            )
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(GlobalContext.navKey.currentContext!).pop();
                            }, icon: Icon(Icons.close, size: 30,)
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Container(
                              //color: Colors.redAccent,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Dirección:",
                                    style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Text("Aldea sibada kokokok, gfhghgggg, CR a 100002255 km", style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary ))
                                  Text(
                                      miUnidad.Coordenadas!.isEmpty ? "Sin ubicación" : miUnidad.Coordenadas!,
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                  )
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ID del GPS:",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      unidad.IDGPS!,
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Conductor:",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      miUnidad.Conductor == null ? "No definido" : miUnidad.Conductor!,
                                      //"Manuelito Ejemplo",
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   //color: Colors.purpleAccent,
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: widd,
                  //           child: Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 "Placa:",
                  //                 style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         SizedBox(width: 30.0,),
                  //         Expanded(
                  //           child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               mainAxisAlignment: MainAxisAlignment.center,
                  //               children: [
                  //                 Text(
                  //                     unidad.placa!.isEmpty ? "000000" : unidad.placa!,
                  //                     //"000000",
                  //                     style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                  //                 ),
                  //               ]
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha del GPS:",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      miUnidad.fecha_gps == "" || miUnidad.fecha_gps == null ? "No reportada" : convertDateFormat(miUnidad.fecha_gps!),
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Fecha del servidor:",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      miUnidad.fecha_servidor == "" || miUnidad.fecha_servidor == null ? "No reportada" : convertDateFormat(miUnidad.fecha_servidor!),
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //color: Colors.purpleAccent,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, padd, 0, padd),
                      child: Row(
                        children: [
                          SizedBox(
                            width: widd,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Bateria:",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.secondary),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 30.0,),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "${miUnidad.bateria.toString()} %",
                                      style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )
                                  ),
                                ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    //color: Colors.orangeAccent,
                    child: Row(
                      children: [
                        Expanded(
                          child: IconButton(
                              onPressed: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => UnitInfoScreen(unidad: miUnidad,))
                                );
                              },
                              icon: Icon(Icons.info_outline, color: Colors.blue[800],)
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CommandScreen(idgps: unidad.IDGPS!,))
                              );
                            },
                            icon: Icon(Icons.terminal),
                          ),
                        ),
                        Expanded(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HistorialScreen(unidad: unidad,))
                                  );
                                },
                                icon: Icon(Icons.history)
                            )
                        ),
                        // Expanded(
                        //     child: Consumer<MapManager>(
                        //       builder: (context, mpMan, child){
                        //         return IconButton(
                        //           onPressed: () {
                        //             // mpMan.trackSingleUnit(unidad.id_gps!);
                        //             // Navigator.of(GlobalContext.navKey.currentContext!).pop();
                        //           },
                        //           icon: Icon(Icons.remove_red_eye_rounded),
                        //           color: mpMan.trackUnit ? Colors.white : Colors.grey,
                        //           style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(mpMan.trackUnit ? Colors.blueAccent : Colors.transparent)),
                        //         );
                        //       },
                        //     )
                        // ),
                        Expanded(
                            child: IconButton(
                              onPressed: () {

                              },
                              icon: () {
                                int batteryLevel = miUnidad.bateria == null ? -1 : int.parse(miUnidad.bateria!);
                                //int batteryLevel = int.parse("97");
                                if(batteryLevel >= 90){
                                  return Icon(Icons.battery_std_sharp, color: Colors.green,);
                                } else if (batteryLevel >= 60 && batteryLevel < 90){
                                  return Icon(Icons.battery_4_bar_rounded, color: Colors.green[400],);
                                } else if (batteryLevel >= 40 && batteryLevel < 60){
                                  return Icon(Icons.battery_3_bar, color: Colors.orangeAccent,);
                                } else if (batteryLevel >= 20 && batteryLevel < 40){
                                  return Icon(Icons.battery_2_bar, color: Colors.orangeAccent,);
                                } else if (batteryLevel >= 0 && batteryLevel < 20){
                                  return Icon(Icons.battery_1_bar, color: Colors.redAccent,);
                                } else {
                                  return Icon(Icons.battery_unknown_outlined, color: Colors.grey,);
                                }
                              }(),
                            )
                        ),
                        // Expanded(
                        //   child: siccap == "1"
                        //       ? Center(
                        //     child: Container(
                        //       color: Colors.yellow,
                        //       width: 100,
                        //       height: 70,
                        //       child: IconButton(
                        //           iconSize: 50,
                        //           onPressed: () {
                        //             print("Botón SICCAP presionado");
                        //             Navigator.push(
                        //                 context,
                        //                 MaterialPageRoute(builder: (context) => SiccapScreen(idgps: unidad.IDGPS!))
                        //             );
                        //           },
                        //           icon: Image.asset(
                        //             "assets/images/btn_siccap.png",
                        //
                        //             width: 100,
                        //             height: 70,
                        //           ),
                        //
                        //       ),
                        //     ),
                        //   )
                        //       : const SizedBox.shrink(), // no renderiza nada si no cumple
                        // )
                        Expanded(
                          child: siccap == "1"
                              ? Center(
                            child: GestureDetector(
                              onTap: () {
                                print("Botón SICCAP presionado");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SiccapScreen(idgps: unidad.IDGPS!),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 120, // aumenta el tamaño aquí
                                height: 90,
                                child: Image.asset(
                                  "assets/images/btn_siccap.png",
                                  fit: BoxFit.contain, // o .cover si quieres llenarlo
                                ),
                              ),
                            ),
                          )
                              : const SizedBox.shrink(),
                        )

                      ],
                    ),
                  )
                ],
              );
            } else {
              return Center(child: Text("No se pudo obtener datos del servidor."),);
            }
          }
        ),
      )
    ),
  );
}