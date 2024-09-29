import 'dart:async';

import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/MapScreen/map_manager.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Widgets/info2_dialog.dart';
import 'package:apprutas/Widgets/info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:session_manager/session_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/location_model.dart';

part 'map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreen();

}

class _MapScreen extends State<MapScreen>  {

  @override
  void initState() {
    //SessionManager().setInt("intervalo", 10);
    GlobalContext.appBar.value = "Mapa";
    getIntevalo().then((onValue) {
      mpMan.intervalo = onValue ?? 10;
      mpMan.stopTimer = false;
      mpMan.intervalUpdate();
    });
    super.initState();
  }

  @override
  void dispose() {
    mpMan.stopTimer = true;
    //mpMan.dispose();
    super.dispose();
  }

  final ubicaciones = LocationModel.locationsList();
  Set<int> unidades = Set<int>.from(unitsManager.selectedIds);

  @override
  Widget build(BuildContext context) {
    final unitsManager = context.watch<ListviewManager>();
    unidades = Set<int>.from(unitsManager.selectedIds);
    //unidades.remove(1);
    print("Cantidad de elementos de la Lista(Set) de copia: ${unidades.length}, original: ${unitsManager.selectedIds.length}");
    unidades.forEach((unit){
      print("Unidad con ID: ${unit}");
    });
    final mapManager = context.watch<MapManager>();

    return Scaffold(
      body: FutureBuilder(
        future: unidadesFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<UnidadModel> defData = mapManager.count == 0 ? snapshot.data! : mapManager.listUnits;
            List<UnidadModel> listaUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);

            var zoom = 6.0;
            var initLocation =
            listaUnits.length == 0 ? LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!))
                : LatLng(9.9996, -84.1572);

            if(listaUnits.length == 1) {
              zoom = 13.0;
              initLocation = LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!));
            } else {
              zoom = 6.0;
            }

            return FlutterMap(
              options: MapOptions(
                //initialCenter: LatLng(9.9996, -84.1572),
                initialCenter: initLocation,
                initialZoom: zoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
                    ),
                  ],
                ),
                MarkerLayer(
                    markers: listToMarkerList(listaUnits)
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Sin unidades disponibles"),
            );
          }
        },
      ),
    );
  }
}



