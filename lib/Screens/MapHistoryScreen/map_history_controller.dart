part of 'map_history_screen.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
LatLng puntoInicio = LatLng(0, 0);
LatLng puntoFinal = LatLng(0, 0);
List<Marker> marcadores = [];

Map<Marker, HistorialDataModel> markersDataMap = {};
BitmapDescriptor? locIcon;
BitmapDescriptor? startIcon;
BitmapDescriptor? lastIcon;


// List<LatLng> pointsToPoly(List<HistorialDataModel> lista) {
//   List<LatLng> puntos = [];
//
//   lista.forEach((HistorialDataModel punto) {
//     var point = LatLng(double.parse(punto.latitud!), double.parse(punto.longitud!));
//
//     toMarkerDet(point, Icon(Icons.location_on, color: Colors.blue[800], size: 30,), punto);
//     puntos.add(point);
//   });
//
//   //print("Lista de PUNTOS para el POLYLINE: ${puntos}");
//   puntos.reversed;
//
//   puntoInicio = puntos.first;
//   puntoFinal = puntos.last;
//
//   toMarker(puntoFinal, Icon(Icons.circle, color: Colors.green, size: 24,));
//   toMarker(puntoInicio, Icon(Icons.circle, color: Colors.redAccent, size: 24));
//
//   print("Punto INICIO: ${puntoInicio}, Punto FINAL: ${puntoFinal}");
//
//   return puntos;
// }
Set<Polyline> pointsToPoly(List<HistorialDataModel> lista) {
  List<LatLng> puntos = [];

  for (int p = 0; p < lista.length; p++) {
    var punto = lista[p];
    var point = LatLng(
      double.parse(punto.latitud!),
      double.parse(punto.longitud!),
    );

    // Coloca un marcador para cada punto
    toMarkerDet(
      point,
      p,
      punto,
    );

    puntos.add(point);
  }

  if (puntos.isEmpty) return {}; // si no hay puntos, retornamos vacío

  puntoInicio = puntos.first;
  puntoFinal = puntos.last;

  // Marcadores para inicio y fin
  toMarker(puntoFinal, "first");
  toMarker(puntoInicio, "last");

  print("Punto INICIO: $puntoInicio, Punto FINAL: $puntoFinal");

  // Ahora devolvemos un Set con la Polyline
  return {
    Polyline(
      polylineId: const PolylineId("ruta"),
      color: Colors.blue,
      width: 5,
      points: puntos,
    ),
  };
}

toMarker(LatLng punto, String key) {
  var marker = Marker(
      position: punto,
      icon: key == "first" ? startIcon! : lastIcon!,
      markerId: MarkerId(key)
  );

  marcadores.add(marker);
}

toMarkerDet (LatLng punto, int index, HistorialDataModel data) {
  //var miKey = data.latitud.toStri ng()+data.fecha1.toString()+data.fecha_pc.toString();
  var marker = Marker(
      position: punto,
      icon: locIcon!,
      markerId: MarkerId(index.toString()),
      infoWindow: InfoWindow(
        title: "Punto cercano: ${data.punto_cercano}",
        snippet: "Fecha: ${data.fecha}; Fecha GPS: ${data.fecha_gps} "
      )
  );

  markersDataMap[marker] = data;
  marcadores.add(marker);
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

