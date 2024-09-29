import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Widgets/foto_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'unit_info_controller.dart';

class UnitInfoScreen extends StatefulWidget {
  const UnitInfoScreen({super.key, required this.unidad});

  final UnidadModel unidad;

  @override
  State<UnitInfoScreen> createState() => _UnitInfoScreenState();
}

class _UnitInfoScreenState extends State<UnitInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              color: COLOR_PRIMARY,
              width: double.maxFinite,
              child: Text(
                "Detalles",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.unidad.desc!,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Visualización de todos los datos especificos de la unidad.",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: COLOR_GREY, fontWeight: FontWeight.normal, fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            FittedBox(
              child: DataTable(
                  dataRowHeight: 90.0,
                  //dataTextStyle: TextStyle(fontSize: 20),
                  columns: [
                    DataColumn(
                        label: Expanded(
                          child: Text(""),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Parámetro"),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Nombre"),
                        )
                    ),
                    DataColumn(
                        label: Expanded(
                          child: Text("Valor"),
                        )
                    )
                  ],
                  rows: [
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.car_crash,)
                          ),
                          DataCell(
                              Text("ID Vehiculo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("id_vehiculo", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.id!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.developer_board,)
                          ),
                          DataCell(
                              Text("ID GPS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("id_gps", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.id_gps!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.map_outlined)
                          ),
                          DataCell(
                              Text("Ubicación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("lugar", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lugar!.isEmpty ? "-" : widget.unidad.lugar!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined)
                          ),
                          DataCell(
                              Text("Latitud", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("latitud", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.lat!.isEmpty ? "-" : widget.unidad.lat!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.location_on_outlined)
                          ),
                          DataCell(
                              Text("Longitud", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("longitud", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.long!.isEmpty ? "-" : widget.unidad.long!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.access_time)
                          ),
                          DataCell(
                              Text("Ultimo reporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("last", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.last!.isEmpty ? "-" : widget.unidad.last!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.calendar_month)
                          ),
                          DataCell(
                              Text("Fecha del ultimo reporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("fecha1", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.fecha1!.isEmpty ? "-" : widget.unidad.fecha1!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.speed)
                          ),
                          DataCell(
                              Text("Velocidad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("velocidad", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.velocidad!.isEmpty ? "-" : widget.unidad.velocidad!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(CupertinoIcons.car)
                          ),
                          DataCell(
                              Text("Tipo vehiculo", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("tipo", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.tipo!.isEmpty ? "-" : widget.unidad.tipo!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.battery_unknown_outlined)
                          ),
                          DataCell(
                              Text("Bateria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("bateria", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.bateria!.isEmpty ? "-" : widget.unidad.bateria!+" %", style: TextStyle(fontSize: tam))
                          )
                        ]
                    ),
                    DataRow(
                        cells: [
                          DataCell(
                              Icon(Icons.local_gas_station)
                          ),
                          DataCell(
                              Text("Combustible", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                          ),
                          DataCell(
                              Text("combustible", style: TextStyle(fontSize: tam))
                          ),
                          DataCell(
                              Text(widget.unidad.combustible!.isEmpty ? "-" : widget.unidad.combustible!, style: TextStyle(fontSize: tam))
                          )
                        ]
                    )
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
