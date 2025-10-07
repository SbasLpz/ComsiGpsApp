import 'package:apprutas/Models/alert_data_model.dart';
import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_manager.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/book_model.dart';

Widget buildAlert(List<AlertDataModel> alerts, BuildContext context){

  final alertsManaeger = context.watch<AlertsManager>();

  return ListView.builder(
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return InkWell(
          onTap: () {

          },
          child: Dismissible(
            key: ValueKey(index),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              alertsManaeger.toDeleteItem(index);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
              child: ExpansionTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                //backgroundColor: Theme.of(context).colorScheme.primary,
                title: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,//3
                          child: Container(
                            //color: Colors.redAccent,
                            child: Column(
                              children: [
                                Text("", style: TextStyle(fontWeight: FontWeight.w600),),
                                Text(alert.NombreEvento.toString(), textAlign: TextAlign.center,)
                              ],
                            ),
                          )
                      ),
                      // Expanded(
                      //     flex: 2,
                      //     child: Column(
                      //       children: [
                      //         Text("Fecha", style: TextStyle(fontWeight: FontWeight.w600)),
                      //         Center(
                      //             child: Text(
                      //               "${alert.FechaServidor}",
                      //               textAlign: TextAlign.center,
                      //             )
                      //         )
                      //       ],
                      //     )
                      // ),
                    ],
                  ),
                ),
                children: [
                  Container(
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(alert.Descripcion.toString()+"\n\nFecha: ${alert.FechaServidor}", style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
  );
}