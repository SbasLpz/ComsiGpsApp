
import 'dart:ui' as ui;

import 'package:apprutas/Models/historial_data_model.dart';
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Screens/MapHistoryScreen/map_history_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shape_maker/shape_maker.dart';
import 'package:shape_maker/shape_maker_painter.dart';
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

  late Future<HistorialModel> _futurePostHistory;
  late List<HistorialDataModel> listaPuntos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadCustomIcon();

    _futurePostHistory = postHistory(widget.idgps, widget.fechaIni, widget.horaIni, widget.fechaFin, widget.horaFin);

    _futurePostHistory.then((lista) {
      listaPuntos = lista.data!;
      createMarkers(listaPuntos);
    });


  }

  @override
  void dispose() {
    marcadores.clear();
    sinMarcadores.clear();
    puntos.clear();
    _customInfoWindowC.dispose();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MapHistoryManager>(context, listen: false).changeMapsView();
        },
        backgroundColor: COLOR_PRIMARY,
        child: Icon(Icons.satellite_alt_rounded, color: Colors.white,),
      ),
      body: FutureBuilder(
        future: _futurePostHistory,
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
                //List<HistorialDataModel> listaPuntos = snapshot.data!.data!;
                //Set<Polyline> polyline = Set<Polyline>.of(pointsToPoly());

                var firstPoint = LatLng(double.parse(listaPuntos!.first.latitud!),
                    double.parse(listaPuntos!.first.longitud!));

                return Consumer<MapHistoryManager>(
                  builder: (context, mapManager, child) {
                    Set<Marker> currentMarkers = mapManager.showMarkers ? marcadores : sinMarcadores;
                    return Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition: CameraPosition(
                            target: firstPoint,
                            zoom: 10,
                          ),
                          mapType: mapManager.tipoMapaActual,
                          onTap: (position) {
                            _customInfoWindowC.hideInfoWindow!();
                          },
                          onCameraMove: (position) {
                            _customInfoWindowC.onCameraMove!();
                          },
                          onMapCreated: (GoogleMapController controller) {
                            //mapController = controller;
                            mapControllerG = controller;
                            _customInfoWindowC.googleMapController = controller;
                            if(listaPuntos.length > 0) {
                              print("LISTA DE MARCADORES HIST: ${marcadores.length}");
                            } else {

                            }
                          },
                          onCameraIdle: () {
                            mapControllerG.getZoomLevel().then((zoom) {
                              if (zoom < 13.0) {
                                mapManager.changeMarkersState(false);
                                //_updateMarkers(false);
                                print("Current Zoom is: $zoom so Markers should be gone!!!");
                              } else {
                                //_updateMarkers(true);
                                mapManager.changeMarkersState(true);
                                print("THE Zoom is: $zoom so Markers should NOT be gone!!!");
                              }
                            });
                          },
                          polylines: Set<Polyline>.of(pointsToPoly()),
                          markers: currentMarkers,
                        ),
                        CustomInfoWindow(
                          controller: _customInfoWindowC,
                          width: 250,
                          height: 200,
                          offset: 20,
                        ),
                      ],
                    );
                  }
                );
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
