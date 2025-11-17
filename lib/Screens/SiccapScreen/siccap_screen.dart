import 'package:apprutas/Models/siccap_data_model.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

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
        scrollDirection: Axis.vertical,
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

                        child: Expanded(
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
                                width: double.maxFinite,
                                child: Text(
                                  data.tipoServicio ?? "Sin tipo de servicio especificado.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 15, color: Theme.of(context).colorScheme.secondary),
                                ),
                              ),
                              Container(
                                color: Color(0xffEBEBEB),
                                //padding: EdgeInsets.all(15.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                      dataRowMaxHeight: 45,
                                      dataRowMinHeight: 45,
                                      headingRowHeight: 0,
                                      dataTextStyle: TextStyle(fontSize: 18),
                                      columns: [
                                        DataColumn(

                                            label: Text("")
                                        ),
                                        DataColumn(
                                            label: Text("")
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
                                                  Text("Descripción:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                              ),
                                              DataCell(
                                                  Text(data.descripcion == null ? "-"
                                                      : data.descripcion!, style: TextStyle(fontSize: tam))
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
                                                  Text("Empresa:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: tam),)
                                              ),
                                              DataCell(
                                                  Text(data.empresa == null ? "-"
                                                      : data.empresa!, style: TextStyle(fontSize: tam))
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
                                                  Text("Placa cabezal:", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                              ),
                                              DataCell(
                                                  Text(data.placaCabezal == null ? "-"
                                                      : data.placaCabezal!, style: TextStyle(fontSize: tam))
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
                                                  Row(
                                                    children: [
                                                      Text(data.telefono == null ? "-"
                                                          : data.telefono!, style: TextStyle(fontSize: tam)),
                                                      IconButton(
                                                          onPressed: () {
                                                            _makePhoneCall(data.telefono);
                                                          },
                                                          icon: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor: Colors.blueAccent,
                                                            child: Icon(
                                                              Icons.phone_forwarded,
                                                              size: 13,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                      )
                                                    ],
                                                  )
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
                                height: 90,
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
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                      dataRowMaxHeight: 45,
                                      dataRowMinHeight: 45,
                                      headingRowHeight: 0,
                                      //dataTextStyle: TextStyle(fontSize: 20),
                                      columns: [
                                        DataColumn(
                                            label: Text("")
                                        ),
                                        DataColumn(
                                            label: Text("")
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
                                        DataRow(
                                            cells: [
                                              DataCell(
                                                  Text("Tel. Custodio", style: TextStyle(fontWeight: FontWeight.normal, fontSize: tam),)
                                              ),
                                              DataCell(
                                                  Row(
                                                    children: [
                                                      Text(data.telefonoCustodio == null ? "-"
                                                          : data.telefonoCustodio!, style: TextStyle(fontSize: tam)),
                                                      IconButton(
                                                          onPressed: () {
                                                            _makePhoneCall(data.telefonoCustodio);
                                                          },
                                                          icon: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor: Colors.green,
                                                            child: Icon(
                                                              Icons.phone_forwarded,
                                                              size: 13,
                                                              color: Colors.white,
                                                            ),
                                                          )
                                                      )
                                                    ],
                                                  )
                                              )
                                            ]
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
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