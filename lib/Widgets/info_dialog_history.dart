import 'package:apprutas/Models/historial_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
                                      style: txtTheme.displayMedium,
                                    ),
                                    TextSpan(
                                        text: data.fecha_pc,
                                        style: txtTheme.bodySmall
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
                                      style: txtTheme.displayMedium,
                                    ),
                                    TextSpan(
                                        text: data.latitud,
                                        style: txtTheme.bodySmall
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
                                        style: txtTheme.displayMedium
                                    ),
                                    TextSpan(
                                        text: data.longitud,
                                        style: txtTheme.bodySmall
                                    )
                                  ]
                              )
                          ),
                        ),
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