import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/colors.dart' as globalClr;

import '../Models/foto_model.dart';

class FotoItem extends StatelessWidget {
  const FotoItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.circle_outlined,
              color: Colors.grey[400],
            ),
            title: Text(
                "Cargamento Express 01",
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
                        "WXF3+HR5, A024, San José, Curridabat, El Prado, 11801.",
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
                    title: Text('012002'),
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
