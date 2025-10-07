import 'package:apprutas/Models/info_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Widgets/foto_element.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'unit_info_controller.dart';

class UnitInfoScreen extends StatefulWidget {
  const UnitInfoScreen({super.key, required this.unidad});

  final InfoDataModel unidad;

  @override
  State<UnitInfoScreen> createState() => _UnitInfoScreenState();
}

class _UnitInfoScreenState extends State<UnitInfoScreen> {

  @override
  Widget build(BuildContext context) {
    var latlong = GlobalContext.getLatLng(widget.unidad.Coordenadas!);
    var lat = latlong["lat"];
    var long = latlong["long"];

    var vehiculo = getValueFromDescripcion(widget.unidad.Descripcion!, "Vehiculo");
    var placa = getValueFromDescripcion(widget.unidad.Descripcion!, "Placa");
    var idgps = getValueFromDescripcion(widget.unidad.Descripcion!, "IDGPS");

    var ignicion = "DESCONOCIDO";
    if(widget.unidad.ignicion == 0){
      ignicion = "APAGADO";
    }
    if(widget.unidad.ignicion == 1){
      ignicion = "ENCENDIDO";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                child: Text(
                  "Información",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, color: COLOR_PRIMARY),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                vehiculo,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Placa: ${placa} ; ID GPS: ${idgps}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
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
                            child: Text("Parámetro"),
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
                                Text("Piloto", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                //Text(widget.unidad.id!, style: TextStyle(fontSize: tam))
                                Text(widget.unidad.Conductor == null || widget.unidad.Conductor!.isEmpty
                                    ? "-" : widget.unidad.Conductor!, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Lugar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.Direccion == null || widget.unidad.Direccion!.isEmpty
                                    ? "-" : widget.unidad.Direccion!, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Ignición", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(ignicion, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Coordenadas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                //Text(widget.unidad.long!.isEmpty ? "-" : widget.unidad.long!, style: TextStyle(fontSize: tam))
                                Text(widget.unidad.Coordenadas == null || widget.unidad.Coordenadas!.isEmpty
                                    ? "-" : widget.unidad.Coordenadas!, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Velocidad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.velocidad == null || widget.unidad.velocidad!.isEmpty
                                    ? "-" : widget.unidad.velocidad! + " km/h", style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Ultimo reporte", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.tiempoReporte == null || widget.unidad.tiempoReporte!.isEmpty 
                                    ? "-" : minutesToTime(int.parse(widget.unidad.tiempoReporte!.trim())), style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Fecha GPS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.fecha_gps == null || widget.unidad.fecha_gps!.isEmpty
                                    ? "-" : widget.unidad.fecha_gps!, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Fecha Servidor", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.fecha_servidor == null || widget.unidad.fecha_servidor!.isEmpty
                                    ? "-" : widget.unidad.fecha_servidor!, style: TextStyle(fontSize: tam))
                            )
                          ]
                      ),
                      DataRow(
                          cells: [
                            DataCell(
                                Text("Bateria", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                            ),
                            DataCell(
                                Text(widget.unidad.bateria == null || widget.unidad.bateria!.isEmpty
                                    ? "-" : widget.unidad.bateria!+" %", style: TextStyle(fontSize: tam))
                            )
                          ]
                      )
                    ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
