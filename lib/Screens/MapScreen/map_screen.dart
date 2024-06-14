

import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/location_model.dart';

part 'map_controller.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final ubicaciones = LocationModel.locationsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
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
              markers: listToMarkerList()
          ),
        ],
      ),
    );
  }
}

Widget infoChart(int id) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(GlobalContext.navKey.currentContext!).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ),
              Text(
                "Título del texto informativo",
                textAlign: TextAlign.left
              )
            ],
          ),
          Text("ID: "+id.toString()),
          Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sit amet suscipit ipsum.")
        ],
      ),
    ),
  );
}

