part of 'map_recent_screen.dart';

TextTheme txtTheme = Theme
    .of(GlobalContext.navKey.currentContext!)
    .textTheme;
LatLng puntoInicio = LatLng(0, 0);
LatLng puntoFinal = LatLng(0, 0);
Set<Marker> marcadores = {};
List<Marker> marcadoresOff = [];

CustomInfoWindowController _customInfoWindowC = CustomInfoWindowController();

Set<Marker> sinMarcadores = Set<Marker>.of({});

List<LatLng> puntos = [];

Map<Marker, RecentDataModel> markersDataMap = {};
BitmapDescriptor? locIcon;
BitmapDescriptor? startIcon;
BitmapDescriptor? lastIcon;

late GoogleMapController mapControllerG;

Set<Polyline> pointsToPolyRecent() {
  //print("ENTRO EN POINTS TO POLY recent LENGHT: ${puntos.length}");
  // Ahora devolvemos un Set con la Polyline
  return {
    Polyline(
      polylineId: const PolylineId("rutaRecent"),
      color: Colors.blue,
      width: 5,
      points: puntos,
    ),
  };
}

void createMarkers(List<RecentDataModel> lista) {
  for (int p = 0; p < lista.length; p++) {
    var punto = lista[p];
    var point = LatLng(
      double.parse(punto.latitud!),
      double.parse(punto.longitud!),
    );

    // Crea un marcador para cada punto
    toMarkerDet(
      point,
      p,
      punto,
    );

    puntos.add(point);
  }

  puntoInicio = puntos.first;
  puntoFinal = puntos.last;

  // Marcadores para inicio y fin
  toMarker(puntoFinal, "first");
  toMarker(puntoInicio, "last");

  for (var marker in marcadores) {
    if (marker != marcadores.first && marker != marcadores.last) {
      marcadoresOff.add(marker.copyWith(visibleParam: false));
    } else {
      marcadoresOff.add(marker);
    }
  }
}

toMarker(LatLng punto, String key) {
  var marker = Marker(
      position: punto,
      icon: key == "first" ? startIcon! : lastIcon!,
      markerId: MarkerId(key)
  );

  marcadores.add(marker);
  sinMarcadores.add(marker);
}

toMarkerDet(LatLng punto, int index, RecentDataModel data) {
  //var miKey = data.latitud.toStri ng()+data.fecha1.toString()+data.fecha_pc.toString();
  var marker = Marker(
      position: punto,
      icon: locIcon!,
      markerId: MarkerId(index.toString()),
      onTap: () {
        _customInfoWindowC.addInfoWindow!(
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  color: Theme.of(GlobalContext.navKey.currentContext!).colorScheme.primary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Punto cercano:", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(data.punto_cercano ?? "-", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white)),
                        SizedBox(height: 5,),
                        Text("Fecha: ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(data.fecha ?? "-", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white)),
                        SizedBox(height: 5,),
                        Text("Fecha GPS: ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(data.fecha_gps ?? "-", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white)),
                        SizedBox(height: 5,),
                        Text("Velocidad: ", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text(data.velocidad ?? "-", style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal, color: Colors.white))

                      ],
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 3.1416, // radianes = 180 grados
                  child: ShapeMaker(
                    shapeType: ShapeType.triangle,
                    bgColor: Theme.of(GlobalContext.navKey.currentContext!).colorScheme.primary,
                    //bgColor: Colors.orange,
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
          ), punto
        );
      },
      // infoWindow: InfoWindow(
      //     title: "Punto cercano: ${data.punto_cercano}",
      //     snippet: "Fecha: ${data.fecha}; Fecha GPS: ${data.fecha_gps} "
      // )
  );

  markersDataMap[marker] = data;
  marcadores.add(marker);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
      .asUint8List();
}

