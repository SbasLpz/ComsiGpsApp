import 'package:apprutas/Models/siccap_data_model.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'siccap_controller.dart';

class SiccapScreen extends StatefulWidget {

  const SiccapScreen({super.key, required String this.idgps});
  final String idgps;

  @override
  State<StatefulWidget> createState() => _SiccapScreenState();

}

class _SiccapScreenState extends State<SiccapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,

          child: FutureBuilder(
              future: getSiccapData(widget.idgps),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Center(
                      child: Text("No se encontraron datos"),
                    );
                  } else {
                    if (snapshot.data!.status != "success") {
                      return Center(
                        child: Text("Consulta exitosa, pero ocurrio un problema: ${snapshot.data!.message}"),
                      );
                    } else {
                      SiccapDataModel data = snapshot.data!.data!;

                      return Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width * 0.9, // ancho relativo a la pantalla
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: double.maxFinite,
                              color: Colors.lightBlue,
                              child: Text(
                                "Datos de la misión",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, color: Colors.white),
                              ),
                            ),
                            Container(
                              color: Color(0xffEBEBEB),
                              child: FittedBox(
                                child: DataTable(
                                    dataRowHeight: 90.0,
                                    //dataTextStyle: TextStyle(fontSize: 20),
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                            child: Text("Dato"),
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
                                                Text("ID GPS", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                              //Text(widget.unidad.id!, style: TextStyle(fontSize: tam))
                                                Text(data.idgps == null ? "-"
                                                    : data.idgps!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("En Misión:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.enMision == null ? "-"
                                                    : data.enMision!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Asignado desde:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.fechaAsignado == null ? "-"
                                                    : data.fechaAsignado!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Finalizado:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.fechaFin == null ? "-"
                                                    : data.fechaFin!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("RUI:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.rui == null ? "-"
                                                    : data.rui!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Nombramiento:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.nombramiento == null ? "-"
                                                    : data.nombramiento!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Referencia:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam, color: Colors.blueAccent),)
                                            ),
                                            DataCell(
                                                Text(data.referencia == null ? "-"
                                                    : data.referencia!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam, color: Colors.blueAccent))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Piloto:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.piloto == null ? "-"
                                                    : data.piloto!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Teléfono", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.telefono == null ? "-"
                                                    : data.telefono!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Dirección de destino:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.direccionDestino == null ? "-"
                                                    : data.direccionDestino!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("País destino:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.paisDestino == null ? "-"
                                                    : data.paisDestino!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("N° Contenedor:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.contenedor == null ? "-"
                                                    : data.contenedor!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Placa TC:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.placaTc == null ? "-"
                                                    : data.placaTc!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Color:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.color == null ? "-"
                                                    : data.color!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                    ]
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.maxFinite,
                              color: Colors.green,
                              child: Text(
                                "Datos del Custodio",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30, color: Colors.white),
                              ),
                            ),
                            Container(
                              color: Color(0xffEBEBEB),
                              child: FittedBox(
                                child: DataTable(
                                    dataRowHeight: 90.0,
                                    //dataTextStyle: TextStyle(fontSize: 20),
                                    columns: [
                                      DataColumn(
                                          label: Expanded(
                                            child: Text("Dato"),
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
                                                Text("Indicativo", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.indicarivo == null ? "-"
                                                    : data.indicarivo!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Ultimo reporte:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.ultimoReporte == null ? "-"
                                                    : data.ultimoReporte!, style: TextStyle(fontSize: tam, fontWeight: FontWeight.bold))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Lugar:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.lugar == null ? "-"
                                                    : data.lugar!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                      DataRow(
                                          cells: [
                                            DataCell(
                                                Text("Acción reportada:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                            ),
                                            DataCell(
                                                Text(data.accion == null ? "-"
                                                    : data.accion!, style: TextStyle(fontSize: tam))
                                            )
                                          ]
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ],
                        ),
                      );

                    }
                  }
                } else {
                  return Center(
                    child: Text("Error al cargar los datos"),
                  );
                }
              }
          )
        ),
      )
    );
  }
}