
import 'package:flutter/material.dart';
import 'package:flutter_map_marker_popup/extension_api.dart';

import '../Models/historial_model.dart';
import '../Utils/global_context.dart';

class InfoDialogHistory2 extends StatefulWidget {
  const InfoDialogHistory2({super.key, required this.data, required this.popupController});

  final HistorialModel data;
  final PopupController popupController;

  @override
  State<InfoDialogHistory2> createState() => _InfoDialogHistory2State();
}

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

class _InfoDialogHistory2State extends State<InfoDialogHistory2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 178,
          width: 300,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.grey[200],
              border: Border.all(color: Color(0xffd5d5d5))
              //border: Border.all(color: Colors.black)
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
                                          text: widget.data.fecha_pc,
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
                                          text: widget.data.latitud,
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
                                          text: widget.data.longitud,
                                          style: txtTheme.bodySmall!.copyWith(color: Colors.black)
                                      )
                                    ]
                                )
                            ),
                          ),
                          SizedBox(height: 15,),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: InkWell(
                              onTap: () {
                                widget.popupController.hideAllPopups();
                              },
                              child: Text("Cerrar", style: Theme.of(context).textTheme.displayMedium
                                  !.copyWith(color: Colors.red),),
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
            child: Image.asset('assets/images/downgris1.png', width: 50, height: 20, fit: BoxFit.fitHeight,)
        )
      ],
    );;
  }
}
