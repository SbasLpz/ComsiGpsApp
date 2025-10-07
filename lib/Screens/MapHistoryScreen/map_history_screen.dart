
import 'dart:ui' as ui;

import 'package:apprutas/Models/historial_data_model.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/historial_model.dart';
import '../../Widgets/info_dialog_history2.dart';
import '../MapScreen/map_screen.dart';

part 'map_history_controller.dart';

class MapHistoryScreen extends StatefulWidget {
  const MapHistoryScreen({super.key, required this.idgps, required this.fechaIni, required this.horaIni, required this.fechaFin, required this.horaFin});

  final String idgps;
  final String fechaIni;
  final String horaIni;
  final String fechaFin;
  final String horaFin;

  @override
  State<MapHistoryScreen> createState() => _MapHistoryScreenState();
}

class _MapHistoryScreenState extends State<MapHistoryScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadCustomIcon();
  }

  @override
  void dispose() {
    marcadores.clear();
    super.dispose();
  }


  Future<void> _loadCustomIcon() async {
    final Uint8List locIconBytes = await getBytesFromAsset('assets/images/blue_location.png', 68);
    final Uint8List startIconBytes = await getBytesFromAsset('assets/images/start_loc.png', 88);
    final Uint8List lastIconBytes = await getBytesFromAsset('assets/images/last_loc.png', 88);

    locIcon = BitmapDescriptor.fromBytes(locIconBytes);
    startIcon = BitmapDescriptor.fromBytes(startIconBytes);
    lastIcon = BitmapDescriptor.fromBytes(lastIconBytes);
    setState(() {}); // fuerza a rebuild cuando ya está listo
  }

  final PopupController myPopupController = PopupController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationScreen()),
            );
          },
        backgroundColor: COLOR_PRIMARY,
        child: Icon(Icons.map, color: Colors.white,),
      ),
      body: FutureBuilder(
        future: postHistory(widget.idgps, widget.fechaIni, widget.horaIni, widget.fechaFin, widget.horaFin),
        builder: (context, snapshot) {
          //|| startIcon == null || lastIcon == null
          if(snapshot.connectionState == ConnectionState.waiting || locIcon == null || startIcon == null || lastIcon == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            if (snapshot.data!.status == "success") {
              if (snapshot.data!.data!.isEmpty) {
                return Center(
                  child: Text("No hubo ruta en esos intervalos"),
                );
              } else {
                List<HistorialDataModel> listaPuntos = snapshot.data!.data!;

                var firstPoint = LatLng(double.parse(listaPuntos!.first.latitud!),
                    double.parse(listaPuntos!.first.longitud!));

                return GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: firstPoint,
                      zoom: 13,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      //mapController = controller;
                      if(listaPuntos.length > 0) {
                        print("LISTA DE MARCADORES HIST: ${marcadores.length}");
                      } else {

                      }
                    },
                    polylines: Set<Polyline>.of(pointsToPoly(listaPuntos)),
                    markers: Set<Marker>.of(marcadores),
                );
                // return FlutterMap(
                //   options: MapOptions(
                //     initialCenter: firstPoint,
                //     initialZoom: 13,
                //   ),
                //   children: [
                    // TileLayer(
                    //   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    //   userAgentPackageName: 'com.example.app',
                    // ),
                    // RichAttributionWidget(
                    //   attributions: [
                    //     TextSourceAttribution(
                    //       'OpenStreetMap contributors',
                    //       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    //     ),
                    //   ],
                    // ),
                    // PolylineLayer(
                    //     polylines: [
                    //       Polyline(
                    //           points: pointsToPoly(listaPuntos!),
                    //           color: Colors.lightBlue,
                    //           borderStrokeWidth: 2.0,
                    //           borderColor: Colors.lightBlue
                    //       )
                    //     ]
                    // ),
                    // PopupMarkerLayer(
                    //     options: PopupMarkerLayerOptions(
                    //         markers: marcadores,
                    //         popupController: myPopupController,
                    //         popupDisplayOptions: PopupDisplayOptions(
                    //
                    //             builder: (BuildContext context, Marker marker) {
                    //               var data = markersDataMap[marker];
                    //               if (data == null) {
                    //                 print("DATA KEY NULL.");
                    //               } else {
                    //                 print("DATA KEY FOUND. ${data.fecha_gps}");
                    //               }
                    //               //return Text(data == null ? "Hola Wenas" : "Hola Wenas ${data.fecha_pc}");
                    //               return data == null ? Text("")
                    //                   : InfoDialogHistory2(data: data, popupController: myPopupController,); //infoDialogHistory(data, context);
                    //             }
                    //         )
                    //     )
                    // ),
                    // MarkerLayer(
                    //     markers: marcadores,
                    // ),
                  //],
                //);
              }
            } else {
              return Center(
                child: Text("El servidor respondio: ${snapshot.data!.message}"),
              );
            }

          } else {
            return Center(
              child: Text("No hubo ruta en esos intervalos"),
            );
          }
        },
      ),
    );
  }
}
