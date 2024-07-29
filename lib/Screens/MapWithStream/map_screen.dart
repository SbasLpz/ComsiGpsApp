import 'dart:async';

import 'package:apprutas/Models/location_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_screen.g.dart';
part 'map_controller.dart';

final unitsListProvider = StateProvider<Future<List<UnidadModel>>>((ref) {
  return unidadesFuture;
});

@riverpod
Future<List<UnidadModel>> myUnitsList(MyUnitsListRef ref) {
  Timer(const Duration(seconds: 5), () {
    ref.invalidateSelf();
  });
  return unidadesFuture;
}

class MapScreen extends ConsumerWidget {
  MapScreen({super.key});

  final ubicaciones = LocationModel.locationsList();
  Set<int> unidades = Set<int>.from(unitsManager.selectedIds.indexed);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitsManager = context.watch<ListviewManager>();
    unidades = Set<int>.from(unitsManager.selectedIds);
    //unidades.remove(1);
    print("Wenas desde MapWithStream");
    print("Cantidad de elementos de la Lista(Set) de copia: ${unidades.length}, original: ${unitsManager.selectedIds.length}");
    unidades.forEach((unit){
      print("Unidad con ID: ${unit}");
    });
    var myUnits = ref.watch(myUnitsListProvider);
    return Scaffold(
      body: myUnits.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          List<UnidadModel> listaUnits = unidades.length == 0 ? data : listaFiltrada(unidades, data);
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(9.9996, -84.1572),
              initialZoom: 16,
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
        },
        error: (e, s) {
          return Center(
            child: Text("Sin unidades disponibles"),
          );
        },
        loading: () => Center(child: CircularProgressIndicator(),)
        // stream: Stream.periodic(
        //     Duration(seconds: 5)
        // ).asyncMap((i) => unidadesFuture),
      ),
    );
  }
}

Widget infoChart(UnidadModel unidad) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        //  color: Colors.redAccent,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    unidad.desc.toString(),
                    textAlign: TextAlign.left,
                    style: txtTheme.titleLarge?.copyWith(fontSize: 22),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(GlobalContext.navKey.currentContext!).pop();
                  },
                  icon: Icon(Icons.close),
                  iconSize: 30,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                //textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: "ID del Gps: ",
                          style: txtTheme.displayMedium,
                      ),
                      TextSpan(
                        text: unidad.id_gps,
                        style: txtTheme.bodySmall
                      )
                    ]
                  )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Conductor: ",
                            style: txtTheme.displayMedium
                        ),
                        TextSpan(
                            text: unidad.namePiloto,
                            style: txtTheme.bodySmall
                        )
                      ]
                  )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "ID del vehiculo: ",
                            style: txtTheme.displayMedium
                        ),
                        TextSpan(
                            text: unidad.id,
                            style: txtTheme.bodySmall
                        )
                      ]
                  )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Tipo de vehiculo: ",
                            style: txtTheme.displayMedium
                        ),
                        TextSpan(
                            text: unidad.tipo,
                            style: txtTheme.bodySmall
                        )
                      ]
                  )
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Placa del vehiculo: ",
                            style: txtTheme.displayMedium
                        ),
                        TextSpan(
                            text: unidad.placa,
                            style: txtTheme.bodySmall
                        )
                      ]
                  )
              ),
            ),
            //Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet suscipit ipsum.")
          ],
        ),
      ),
    ),
  );
}

