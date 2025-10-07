// import 'dart:async';
// import 'dart:ffi';
//
// import 'package:apprutas/Models/unidad_model.dart';
// import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
// import 'package:apprutas/Screens/MapScreen/map_manager.dart';
// import 'package:apprutas/Services/road_api.dart';
// import 'package:apprutas/Utils/global_context.dart';
// import 'package:apprutas/Widgets/info2_dialog.dart';
// import 'package:apprutas/Widgets/info_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:session_manager/session_manager.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../Models/location_model.dart';
//
// part 'map_controller.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({super.key});
//
//   @override
//   State<MapScreen> createState() => _MapScreen();
//
// }
//
// class _MapScreen extends State<MapScreen>  {
//
//   var puedesMover = false;
//   @override
//   void initState() {
//     //SessionManager().setInt("intervalo", 10);
//     //GlobalContext.appBar.value = "Mapa";
//     getIntevalo().then((onValue) {
//       mpMan.intervalo = onValue ?? 10;
//       mpMan.stopTimer = false;
//       mpMan.intervalUpdate();
//     });
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       GlobalContext.appBar.value = "Mapa";
//     });
//
//   }
//
//   @override
//   void dispose() {
//     mpMan.stopTimer = true;
//     mpMan.trackUnit = false;
//     //mpController.dispose();
//     //mpMan.dispose();
//     super.dispose();
//   }
//
//   final ubicaciones = LocationModel.locationsList();
//   Set<int> unidades = Set<int>.from(unitsManager.selectedIds);
//
//   @override
//   Widget build(BuildContext context) {
//
//     //final ValueNotifier<bool> isControllerEnabled = ValueNotifier<bool>(false);
//     final ValueNotifier<double> theZoom = ValueNotifier(6.0);
//     final ValueNotifier<LatLng> theInit = ValueNotifier(LatLng(9.9996, -84.1572));
//
//     final unitsManager = context.watch<ListviewManager>();
//     unidades = Set<int>.from(unitsManager.selectedIds);
//     //unidades.remove(1);
//     print("Cantidad de elementos de la Lista(Set) de copia: ${unidades.length}, original: ${unitsManager.selectedIds.length}");
//     unidades.forEach((unit){
//       print("Unidad con ID: ${unit}");
//     });
//
//     final mapManager = context.watch<MapManager>();
//     return Scaffold(
//       body: FutureBuilder(
//         future: unidadesFuture,
//         builder: (context, snapshot) {
//           if(snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             List<UnidadModel> defData = mapManager.count == 0 ? snapshot.data! : mapManager.listUnits;
//             List<UnidadModel> listaUnits = unidades.length == 0 ? defData : listaFiltrada(unidades, defData);
//             //var zoom = 6.0;
//             // var initLocation =
//             // listaUnits.length == 0 ? LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!))
//             //     : LatLng(9.9996, -84.1572);
//
//             mpMan.initLocation = listaUnits.length == 0 ? LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!))
//                 : LatLng(9.9996, -84.1572);
//
//            // mpMan.mapZoom = 6.0;
//             //theZoom.value = 6.0;
//
//
//             // WidgetsBinding.instance.addPostFrameCallback((_) {
//             //
//             // });
//             if(mpMan.trackUnit == true && puedesMover) {
//               final listaM = markerList;
//               //isControllerEnabled.value = true;
//               print("    =☼☼ ");
//               var unidadId = mpMan.trackUnitId;
//               if(unidadId == null || unidadId == "") {
//                 Fluttertoast.showToast(
//                   msg: "ID de la unida es 0 o invalido.",
//                   toastLength: Toast.LENGTH_LONG,
//                   gravity: ToastGravity.BOTTOM,
//                 );
//               } else {
//                 // var extractedValue = RegExp(r'\d+').firstMatch(markerList.first.key.toString())?.group(0);
//                 // print("--------- trackUnitId = ${mpMan.trackUnitId}, Marlker ID = ${markerList.first.key} -----------");
//                 //var marcador = markerList.firstWhere((marker) => RegExp(r'\d+').firstMatch(markerList.first.key.toString())?.group(0) == mpMan.trackUnitId);
//                 print("♦ ♦ WEnas ${markerList.length}, ${markerList.first.key.toString()}");
//                 //var marcador = markerList.firstWhere((marker) => RegExp(r'\d+').firstMatch(marker.key.toString())?.group(0) == mpMan.trackUnitId);
//                 //mark
//                 try {
//                   Marker? marcador = markerList.firstWhere((marker) {
//                     final match = RegExp(r'\d+').firstMatch(marker.key.toString());
//                     //final match2 = (markerList.first.key as ValueKey).value.toString();
//                     final match2 = (marker.key as ValueKey).value.toString();
//                     print("♠♠•♠•♠•♠♠♠ MAtch=${match}, element=${markerList.first.key} & ${(markerList.first.key as ValueKey).value.toString()} , UnitID = ${mpMan.trackUnitId}");
//                     return match2 != null && match2 == mpMan.trackUnitId;
//                   });
//                   mpMan.mapZoom = 13.0;
//                   if(marcador != null) {
//
//                     mpMan.initLocation = marcador.point;
//                     mpController.move(marcador.point, 13.0);
//                   } else {
//                     print("*************** ********* MARCADOOOOOOOOOOR EN NULLL");
//                   }
//                   print(">>>>>>>>>>> Siguiendo unidad ${marcador.key}");
//                   markerList.clear();
//                 } catch (e) {
//                   print("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//                 }
//                 //print("//////////////// Valor del IsEnabled para el Controller = $isEnabled, ${isControllerEnabled.value}");
//               }
//             } else {
//               //mpController.move(LatLng(9.9996, -84.1572), 6.0);
//               //mpController.move(initLocation, zoom);
//               //isControllerEnabled.value = false;
//               print(">>>--->>>> Seguimiento • DETENIDO ");
//             }
//
//             print("••• COORDS init = ${mpMan.initLocation} & zoom = ${mpMan.mapZoom}");
//
//             return FlutterMap(
//               //mapController: isControllerEnabled.value ? mpController : null,
//               mapController: mpController,
//               options: MapOptions(
//                   initialCenter: mpMan.initLocation,
//                   initialZoom: mpMan.mapZoom,
//                   onMapReady: () {
//                     //isMapReady.value = true;
//                     puedesMover = true;
//                     if(listaUnits.length == 1) {
//                       mpMan.mapZoom = 13.0;
//                       mpMan.initLocation = LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!));
//                       mpController.move(mpMan.initLocation, 13.0);
//                       //theZoom.value = 13.0;
//                       //theInit.value = LatLng(double.parse(listaUnits.first.lat!), double.parse(listaUnits.first.long!));
//                     } else {
//                       mpMan.mapZoom = 6.0;
//                       mpController.move(mpMan.initLocation, 6.0);
//                       //theZoom.value = 6.0;
//                     }
//                     print("### ### Me ejecute (onMapReady) ### ####");
//                   }
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'com.example.app',
//                 ),
//                 RichAttributionWidget(
//                   attributions: [
//                     TextSourceAttribution(
//                       'OpenStreetMap contributors',
//                       onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
//                     ),
//                   ],
//                 ),
//                 MarkerLayer(
//                     markers: listToMarkerList(listaUnits)
//                 ),
//               ],
//             );
//
//           } else {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Ocurrio un problema: ${snapshot.data}"),
//                 Image.asset(
//                   'assets/images/noData.png',
//                   width: 200,
//                   height: 200,
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
//
//
