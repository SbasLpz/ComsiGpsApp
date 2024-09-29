import 'package:apprutas/Models/historial_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Screens/MapHistoryScreen/map_history_screen.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
//UnidadModel unit = UnidadModel();

Widget infoDialogHistory(HistorialModel data, BuildContext context) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(
        height: 160,
        width: 300,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Información",
                        textAlign: TextAlign.center,
                        style: txtTheme.titleLarge?.copyWith(fontSize: 22),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     //Navigator.of(GlobalContext.navKey.currentContext!).pop();
                    //   },
                    //   icon: Icon(Icons.close),
                    //   iconSize: 30,
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            //textAlign: TextAlign.left,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Fecha y hora: ",
                                      style: txtTheme.displayMedium!.copyWith(color: Colors.black),
                                    ),
                                    TextSpan(
                                        text: data.fecha_pc,
                                        style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                    )
                                  ]
                              )
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            //textAlign: TextAlign.left,
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Latitud: ",
                                      style: txtTheme.displayMedium!.copyWith(color: Colors.black),
                                    ),
                                    TextSpan(
                                        text: data.latitud,
                                        style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                    )
                                  ]
                              )
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: "Longitud: ",
                                        style: txtTheme.displayMedium!.copyWith(color: Colors.black)
                                    ),
                                    TextSpan(
                                        text: data.longitud,
                                        style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                    )
                                  ]
                              )
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: InkWell(
                        //     onTap: () {
                        //       return null;
                        //     },
                        //     child: Text("Cerrar", style: Theme.of(context).textTheme.displayMedium
                        //         !.copyWith(color: Colors.red),),
                        //   ),
                        // ),
                      ],
                    )
                ),
                //Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet suscipit ipsum.")
              ],
            ),
          ),
        ),
      ),
      Container(
          //color: Colors.yellowAccent,
          padding: EdgeInsets.zero,
          child: Image.asset('assets/images/down.png', width: 50, height: 20, fit: BoxFit.fitHeight,)
      )
    ],
  );
}