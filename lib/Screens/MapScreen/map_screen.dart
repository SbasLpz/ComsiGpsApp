import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/MapScreen/map_manager.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Widgets/info2_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
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

  var puedesMover = false;
  @override
  void initState() {
    //SessionManager().setInt("intervalo", 10);
    //GlobalContext.appBar.value = "Mapa";
    getIntevalo().then((onValue) {
      mpMan.intervalo = onValue ?? 10;
      mpMan.stopTimer = false;
      mpMan.intervalUpdate();
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GlobalContext.appBar.value = "Mapa";
    });

    _loadCustomIcon();
    getSiccap();
  }

  // Future<void> _loadCustomIcon() async {
  //   final Uint8List markerIconBytes = await getBytesFromAsset('assets/boat_icon.png', 30); // Adjust width as needed
  //   setState(() {
  //     customIcon = BitmapDescriptor.fromBytes(markerIconBytes);
  //   });
  // }
  Future<void> _loadCustomIcon() async {
    final Uint8List markerIconBytes = await getBytesFromAsset('assets/images/boat_icon.png', 60);
    customIcon = BitmapDescriptor.fromBytes(markerIconBytes);
    setState(() {}); // fuerza a rebuild cuando ya está listo
  }

  Future<void> getSiccap() async {
    siccap = await SessionManager().getString("siccap");
  }

  @override
  void dispose() {
    mpMan.stopTimer = true;
    mpMan.trackUnit = false;
    //mpController.dispose();
    //mpMan.dispose();
    super.dispose();
  }

  final ubicaciones = LocationModel.locationsList();
  Set<String> unidades = Set<String>.from(unitsManager.selectedIds);

  @override
  Widget build(BuildContext context) {

    //final ValueNotifier<bool> isControllerEnabled = ValueNotifier<bool>(false);
    final ValueNotifier<double> theZoom = ValueNotifier(6.0);
    final ValueNotifier<LatLng> theInit = ValueNotifier(LatLng(9.9996, -84.1572));

    final unitsManager = context.watch<ListviewManager>();
    unidades = Set<String>.from(unitsManager.selectedIds);
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
          if(snapshot.connectionState == ConnectionState.waiting || customIcon == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            List<UnidadDataModel> defData = mapManager.count == 0 ? snapshot.data! : mapManager.listUnits;
            List<UnidadDataModel> listaUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);
            print("LISTAUNIDADES CANT: ${listaUnits.length}");
            //var zoom = 6.0;
            // var initLocation =
            // listaUnits.length == 0 ? LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!))
            //     : LatLng(9.9996, -84.1572);
            var coords = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
            var latlngCoords = LatLng(double.parse(coords['lat']!), double.parse(coords['long']!));
            var latlngCoordsDef = LatLng(double.parse("9.9996"), double.parse("-84.1572"));
            mpMan.initLocation = listaUnits.length == 0 ? latlngCoords
                : latlngCoordsDef;

           // mpMan.mapZoom = 6.0;
            //theZoom.value = 6.0;


            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //
            // });
            if(mpMan.trackUnit == true && puedesMover) {
              final listaM = markerList;
              //isControllerEnabled.value = true;
              print("    =☼☼ ");
              var unidadId = mpMan.trackUnitId;
              if(unidadId == null || unidadId == "") {
                Fluttertoast.showToast(
                  msg: "ID de la unida es 0 o invalido.",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                // var extractedValue = RegExp(r'\d+').firstMatch(markerList.first.key.toString())?.group(0);
                // print("--------- trackUnitId = ${mpMan.trackUnitId}, Marlker ID = ${markerList.first.key} -----------");
                //var marcador = markerList.firstWhere((marker) => RegExp(r'\d+').firstMatch(markerList.first.key.toString())?.group(0) == mpMan.trackUnitId);
                //print("♦ ♦ WEnas ${markerList.length}, ${markerList.first.markerId.toString()}");
                //var marcador = markerList.firstWhere((marker) => RegExp(r'\d+').firstMatch(marker.key.toString())?.group(0) == mpMan.trackUnitId);
                //mark
                try {
                  print("Aver si ACA se CAE 1");
                  Marker? marcador = markerList.firstWhere((marker) {
                    final match = RegExp(r'\d+').firstMatch(marker.markerId.toString());
                    //final match2 = (markerList.first.key as ValueKey).value.toString();
                    final match2 = (marker.markerId as ValueKey).value.toString();
                    print("♠♠•♠•♠•♠♠♠ MAtch=${match}, element=${markerList.first.markerId} & ${(markerList.first.markerId as ValueKey).value.toString()} , UnitID = ${mpMan.trackUnitId}");
                    return match2 != null && match2 == mpMan.trackUnitId;
                  });
                  mpMan.mapZoom = 13.0;
                  if(marcador != null) {

                    mpMan.initLocation = marcador.position;
                    mapController.moveCamera(CameraUpdate.newLatLngZoom(marcador.position, 13.0));
                  } else {
                    print("*************** ********* MARCADOOOOOOOOOOR EN NULLL");
                  }
                  print(">>>>>>>>>>> Siguiendo unidad ${marcador.markerId}");
                  markerList.clear();
                } catch (e) {
                  print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
                }
                //print("//////////////// Valor del IsEnabled para el Controller = $isEnabled, ${isControllerEnabled.value}");
              }
            } else {
              //mpController.move(LatLng(9.9996, -84.1572), 6.0);
              //mpController.move(initLocation, zoom);
              //isControllerEnabled.value = false;
              print(">>>--->>>> Seguimiento • DETENIDO ");
            }

            print("••• COORDS init = ${mpMan.initLocation} & zoom = ${mpMan.mapZoom}");

            return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: mpMan.initLocation,
                  zoom: mpMan.mapZoom,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  if(listaUnits.length == 1) {
                    var latloong = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
                    mpMan.mapZoom = 13.0;
                    mpMan.initLocation = LatLng(double.parse(latloong['lat']!), double.parse(latloong['long']!));
                    mapController.moveCamera(CameraUpdate.newLatLngZoom(mpMan.initLocation, 13.0));
                  } else {
                    mpMan.mapZoom = 6.0;
                    //_center = LatLng(9.9996, -84.1572);
                    mapController.moveCamera(CameraUpdate.newLatLngZoom(mpMan.initLocation, 6.0));
                  }
                },
                markers: Set<Marker>.of(listToMarkerList(listaUnits))
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Ocurrio un problema: ${snapshot.data}"),
                Image.asset(
                  'assets/images/noData.png',
                  width: 200,
                  height: 200,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}



