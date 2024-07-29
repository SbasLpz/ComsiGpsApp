import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_manager.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/book_model.dart';

Widget buildAlert(List<AlertModel> alerts, BuildContext context){

  final alertsManaeger = context.watch<AlertsManager>();

  return ListView.builder(
      itemCount: alerts.length,
      itemBuilder: (context, index) {
        final alert = alerts[index];
        return InkWell(
          onTap: () {

          },
          child: Dismissible(
            key: ValueKey(alert.id_log),
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
                          flex: 3,
                          child: Container(
                            //color: Colors.redAccent,
                            child: Column(
                              children: [
                                Text("Unidad (ID)", style: TextStyle(fontWeight: FontWeight.w600),),
                                Text(alert.id_vehiculo.toString(), textAlign: TextAlign.center,)
                              ],
                            ),
                          )
                      ),
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text("Fecha", style: TextStyle(fontWeight: FontWeight.w600)),
                              Center(
                                  child: Text(
                                    "${alert.fecha1}",
                                    textAlign: TextAlign.center,
                                  )
                              )
                            ],
                          )
                      ),
                      // Expanded(
                      //     flex: 1,
                      //     child: Container(
                      //       //color: Colors.lightBlueAccent,
                      //       child: RotatedBox(
                      //           quarterTurns: -45,
                      //           child: IconButton(
                      //             icon: Icon(Icons.arrow_back_ios_rounded),
                      //             onPressed: () {
                      //
                      //             },
                      //           )
                      //       ),
                      //     )
                      // )
                    ],
                  ),
                ),
                children: [
                  Container(
                    color: COLOR_PRIMARY,
                    child: Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(alert.descripcion.toString(), style: TextStyle(color: Colors.white),),
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