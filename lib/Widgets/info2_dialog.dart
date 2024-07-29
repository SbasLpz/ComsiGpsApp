import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Screens/InfoUnitScreen/unit_info_screen.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

Widget infoDialog2 (UnidadModel unidad, BuildContext context) {
  const padd = 8.0;
  const widd = 100.0;
  return Container(
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        //color: Colors.white,
        child: Column(
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
                              style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                unidad.lugar!.isEmpty ? "Sin ubicación" : unidad.lugar!,
                                style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                            style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                            Text(unidad.id_gps!, style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )),
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
                            style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                            style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                            style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                unidad.fecha1!.isEmpty ? "No reportada" : unidad.fecha1!,
                                style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                            style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
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
                                style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                    child: IconButton(
                        onPressed: (){
                    
                        },
                        icon: Icon(Icons.link),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: (){

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
        ),
      )
    ),
  );
}