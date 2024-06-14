

import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/colors.dart' as globalClr;
import '../Models/foto_model.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;

Widget buildFotos(List<FotoModel> fotos) {
  return ListView.builder(
    itemCount: fotos.length,
    itemBuilder: (context, index) {
      final foto = fotos[index];
      return InkWell(
        onTap: () {
          mostrarSnackbar(context, foto.id!.toInt());
        },
        child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                        child: Text(
                          foto.title.toString(),
                          style: txtTheme.titleMedium,
                        ),
                      flex: 3,
                    ),
                    Flexible(
                        child: IconButton(
                            onPressed: () {

                            },
                            icon: Icon(Icons.circle_outlined)
                        )
                    )
                  ],
                ),
                ListTile(
                  onTap: () {
                  },
                  leading: Icon(
                    Icons.circle_outlined,
                    color: Colors.grey[400],
                  ),
                  title: Text(
                    foto.title.toString(),
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  textColor: Colors.black,
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.location_on_sharp,
                            color: Colors.grey[400],
                          ),
                          title: Text(
                            foto.thumbnail.toString(),
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey[600]
                            ),
                          ),
                        )
                    ),
                    Flexible(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                            Icons.circle,
                            color: globalClr.primary,
                          ),
                          title: Text(
                              "Encendido",
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 15.0
                              )
                          ),
                        )
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: ListTile(
                          leading: Icon(
                              Icons.car_crash,
                              color: Colors.grey[400]
                          ),
                          title: Text(foto.id.toString()),
                        )
                    )
                  ],
                )
              ],
            ),
        ),
      );
    },
  );
}

showMessage() {

}