import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
//UnidadModel unit = UnidadModel();
TextStyle bodySmall = TextStyle(fontSize: 15);

Widget infoDialog(UnidadModel unidad, BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  unidad.desc.toString(),
                  textAlign: TextAlign.left,
                  style: txtTheme.titleLarge?.copyWith(fontSize: 22),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(GlobalContext.navKey.currentContext!).pop();
                },
                icon: Icon(Icons.close),
                iconSize: 30,
              ),
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
                                text: "ID del Gps: ",
                                style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.id_gps,
                                  style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                                  text: "Conductor: ",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.namePiloto,
                                  style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.primary)
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
                                  text: "ID del vehiculo: ",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.id,
                                  style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                                  text: "Tipo de vehiculo: ",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.tipo,
                                  style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                                  text: "Placa del vehiculo: ",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.placa,
                                  style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
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
                                  text: "Fecha: ",
                                  style: txtTheme.displayMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                              ),
                              TextSpan(
                                  text: unidad.fecha1,
                                  style: txtTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.primary )
                              )
                            ]
                        )
                    ),
                  ),
                ],
              )
          ),
          Row(
            children: [
              Spacer(),
              ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)),
                    backgroundColor: WidgetStateProperty.all(COLOR_PRIMARY),
                    shape: WidgetStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    )),
                  ),
                  onPressed: () {
                    //unit = unidad;
                    //Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistorialScreen(unidad: unidad,))
                    );
                  },
                  child: Text(
                    "Ver historial",
                    style: TextStyle(color: Colors.white),
                  )
              )
            ],
          )
          //Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet suscipit ipsum.")
        ],
      ),
    ),
  );
}