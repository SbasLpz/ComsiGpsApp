import 'dart:async';
import 'package:apprutas/Styles/theme.dart';
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
enum iconosName {
  amarillo,
  verde,
  rojo,
  morado,
  patverde,
  normal,
  patnormal,
  pickNormal,
  pickVerde,
  moto,
  motoVerde
}
class _MapScreen extends State<MapScreen>  {

  var puedesMover = false;
  var _isLoadingIcons = true;

  bool _isMapCreated = false;

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

    _loadCustomIcons();

    getSiccap();
  }

  // Future<void> _loadCustomIcon() async {
  //   final Uint8List markerIconBytes = await getBytesFromAsset('assets/boat_icon.png', 30); // Adjust width as needed
  //   setState(() {
  //     customIcon = BitmapDescriptor.fromBytes(markerIconBytes);
  //   });
  // }

  Future<void> _loadCustomIcons() async {
    var iconSize = 75;
    var assets = {iconosName.amarillo: "assets/images/NormalAmarillo.png", iconosName.verde: "assets/images/NormalVerde.png",
    iconosName.rojo: "assets/images/NormalRojo.png", iconosName.morado: "assets/images/NormalMorado.png", iconosName.patverde: "assets/images/Patverde.png",
      iconosName.normal: "assets/images/Normal.png", iconosName.patnormal: "assets/images/PatNormal.png", iconosName.pickNormal: "assets/images/PickNormal.png",
    iconosName.pickVerde: "assets/images/Pickverde.png", iconosName.moto: "assets/images/moto.png", iconosName.motoVerde: "assets/images/motoVerde.png"};

    for (final x in assets.entries) {
      if({iconosName.normal, iconosName.amarillo, iconosName.morado, iconosName.rojo, iconosName.verde}.contains(x.key)) {
        iconSize = 75;
      } else {
        iconSize = 90;
      }
      Uint8List bytes = await getBytesFromAsset(x.value, iconSize);
      BitmapDescriptor icono = BitmapDescriptor.fromBytes(bytes);

      iconosMap[icono] = x.key;
    }
    setState(() {
      _isLoadingIcons = false;
    });
  }


  Future<void> getSiccap() async {
    siccap = await SessionManager().getString("siccap");
  }

  @override
  void dispose() {
    mpMan.stopTimer = true;
    mpMan.trackUnit = false;
    //mpMan.listUnits.clear();
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

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MapManager>(context, listen: false).changeMapsView();
        },
        backgroundColor: COLOR_PRIMARY,
        child: Icon(Icons.satellite_alt_rounded, color: Colors.white,),
      ),

      body: FutureBuilder(

        future: unidadesFuture,
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting || _isLoadingIcons) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            //final mapManager = context.watch<MapManager>();
            final mapManager = context.watch<MapManager>();

            List<UnidadDataModel> defData = mapManager.count == 0 ? snapshot.data!.data! : mapManager.listUnits;
            List<UnidadDataModel> listaUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);
            print("LISTAUNIDADES CANT: ${listaUnits.length}");
            //var zoom = 6.0;
            // var initLocation =
            // listaUnits.length == 0 ? LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!))
            //     : LatLng(9.9996, -84.1572);
            var coords = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
            var latlngCoords = LatLng(double.parse(coords['lat']!), double.parse(coords['long']!));

            var latlngCoordsDef = LatLng(double.parse("9.9996"), double.parse("-84.1572"));

            mapManager.initLocation = listaUnits.length == 0 ? latlngCoordsDef
                : latlngCoords;

            print("PASE DEL CHANGE _INIT");
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
                    mapControllerCompleter.future.then((controller) {
                      controller.moveCamera(CameraUpdate.newLatLngZoom(marcador.position, 13.0));
                    });

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

            print("••• COORDS init = ${mapManager.initLocation} & zoom = ${mapManager.mapZoom}");

            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   // calcula nuevaPos antes
            //   var coords = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
            //   var latlngCoords = LatLng(double.parse(coords['lat']!), double.parse(coords['long']!));
            //
            //   // esto esperará hasta que el controller esté listo
            //   mapControllerCompleter.future.then((controller) {
            //     // protección adicional por si el widget fue desmontado
            //     if (!mounted) return;
            //     print("Estoy en el MapControllerCompleter !!!!!!!!!!!!");
            //     if(listaUnits.length == 1) {
            //       print("OA OAOA OAOA");
            //       controller.animateCamera(CameraUpdate.newLatLngZoom(latlngCoords, 13.0));
            //       mapManager.chagneZoom(13.0);
            //     } else if (listaUnits.length != 1){
            //       print("AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE AE EA AEE AE AE AE");
            //       controller.animateCamera(
            //           CameraUpdate.newLatLngZoom(LatLng(9.9996, -84.1572), 6.0)
            //       );
            //     }
            //
            //   }).catchError((e) {
            //     // por si algo falla (p.ej. el completer fue completado con error)
            //     print('No se pudo mover la cámara: $e');
            //   });
            // });

            if (_isMapCreated) {
              print("_isMapCreated ES ${_isMapCreated}");
              print("La cantidad de unidadesd ES ${listaUnits.length} -*-");
              WidgetsBinding.instance.addPostFrameCallback((_) {
                mapControllerCompleter.future.then((controller) {

                  if(listaUnits.length == 1) {
                    var coords = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
                    var latlngCoords = LatLng(double.parse(coords['lat']!), double.parse(coords['long']!));
                    controller.moveCamera(CameraUpdate.newLatLngZoom(latlngCoords, 15.0));
                  } else {
                    print("De momento no hago nada");
                  }
                });
              });

            }

            return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: mapManager.initLocation,
                  //zoom: mapManager.mapZoom,
                  zoom: mapManager.mapZoom
                ),
                mapType: mapManager.tipoMapaActual,
                onMapCreated: (GoogleMapController controller) {

                  if (mapControllerCompleter.isCompleted) {
                    mapControllerCompleter = Completer<GoogleMapController>();
                  }

                  mapControllerCompleter.complete(controller);

                  print("Al parece me RECONSTRUI :=)");

                  setState(() {
                    _isMapCreated = true;
                  });
                  // mapControllerCompleter.future.then((controller) {
                  //   if(listaUnits.length == 1) {
                  //     print("ESTOY EN TEORIA MOVIENDO LA CAMARA A LA NBUEBA POSICION DEL MARCADOR");
                  //     var latloong = GlobalContext.getLatLng(listaUnits.first.Coordenadas!);
                  //     mapManager.chagneZoom(13.0);
                  //
                  //     mapManager.initLocation = LatLng(double.parse(latloong['lat']!), double.parse(latloong['long']!));
                  //     //mapManager.changeInitLocation(LatLng(double.parse(latloong['lat']!), double.parse(latloong['long']!)));
                  //     controller.moveCamera(CameraUpdate.newLatLngZoom(mapManager.initLocation, 13.0));
                  //   } else {
                  //     mapManager.chagneZoom(6.0);
                  //
                  //     //_center = LatLng(9.9996, -84.1572);
                  //     controller.moveCamera(CameraUpdate.newLatLngZoom(mapManager.initLocation, 6.0));
                  //   }
                  // });


                },
                markers: Set<Marker>.of(listToMarkerList(listaUnits))
                // markers: {
                //   ...listToMarkerList(listaUnits)
                // },


                //markers: mpMan.count > 0 ? Set<Marker>.of(listToMarkerList(listaFiltrada(unidades, mpMan.listUnits))) :Set<Marker>.of(listToMarkerList(listaUnits))
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



