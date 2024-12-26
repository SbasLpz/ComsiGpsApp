import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/CommandScreen/command_screen.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Screens/InfoUnitScreen/unit_info_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_manager.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

Widget infoDialog2 (UnidadModel unidad, BuildContext context) {
  const padd = 8.0;
  const widd = 100.0;
  return Container(
    color: Theme.of(context).colorScheme.surface,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        //color: Colors.white,
        child: FutureBuilder(
          future: getOneVehicle(unidad.id!),
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
                                unidad.desc.toString(),
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
                                      miUnidad.dirPunto!.isEmpty ? "Sin ubicación" : miUnidad.dirPunto!,
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
                                  Text(unidad.id_gps!, style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.onTertiary )),
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
                                      unidad.namePiloto!.isEmpty ? "No definido" : unidad.namePiloto!,
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
                                  "Placa:",
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
                                      unidad.placa!.isEmpty ? "000000" : unidad.placa!,
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
                                  "Fecha:",
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
                                      unidad.fecha1 == "" || unidad.fecha1 == null ? "No reportada" : convertDateFormat(unidad.fecha1!),
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
                                      "${unidad.bateria!} %",
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
                                    MaterialPageRoute(builder: (context) => UnitInfoScreen(unidad: unidad,))
                                );
                              },
                              icon: Icon(Icons.info_outline, color: Colors.blue[800],)
                          ),
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: getLink(unidad.id!, "10", "1"),
                            builder: (context, snapshot){
                              Widget iconWidget;
                              String msg = "No se puede obtener enlace para esta unidad.";
                              Color? msgColor = Colors.grey[700];

                              if(snapshot.connectionState == ConnectionState.waiting){
                                iconWidget = SizedBox(child: CircularProgressIndicator(strokeWidth: 2.0,), height: 15, width: 15,);
                              } else if (snapshot.hasError){
                                iconWidget = Icon(Icons.link_off, color: Colors.grey);
                              } else if (snapshot.hasData) {
                                if(snapshot.data!.success!){
                                  msg = "Enlace copiado.";
                                  msgColor = Colors.green;
                                  //FlutterClipboard.copy(snapshot.data!.link!);
                                } else {
                                  msg = "Enlace no disponible.";
                                  msgColor = Colors.redAccent;
                                }
                                snapshot.data!.success == true ? iconWidget = Icon(Icons.share, color: Colors.green) : iconWidget = Icon(Icons.share, color: Colors.redAccent);
                              } else {
                                iconWidget = Icon(Icons.link_off, color: Colors.redAccent);
                              }

                              return IconButton(
                                onPressed: () {
                                  if(msg == "Enlace copiado."){
                                    FlutterClipboard.copy(snapshot.data!.link!);
                                  }
                                  print("----- PRESIONES EL BOTÓN -----");
                                  Fluttertoast.showToast(
                                      msg: msg,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: msgColor
                                  );
                                },
                                icon: iconWidget,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => CommandScreen(id_vehiculo: unidad.id!,))
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
                        Expanded(
                            child: Consumer<MapManager>(
                              builder: (context, mpMan, child){
                                return IconButton(
                                  onPressed: () {
                                    mpMan.trackSingleUnit(unidad.id_gps!);
                                    Navigator.of(GlobalContext.navKey.currentContext!).pop();
                                  },
                                  icon: Icon(Icons.remove_red_eye_rounded),
                                  color: mpMan.trackUnit ? Colors.white : Colors.grey,
                                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(mpMan.trackUnit ? Colors.blueAccent : Colors.transparent)),
                                );
                              },
                            )
                        ),
                        Expanded(
                            child: IconButton(
                              onPressed: () {

                              },
                              // icon: int.parse(unidad.bateria!) == 100 ?
                              // Icon(Icons.battery_std_sharp, color: Colors.green,) :
                              // Icon(Icons.battery_3_bar, color: Colors.orangeAccent,)
                              icon: () {
                                int batteryLevel = int.parse(unidad.bateria!);
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