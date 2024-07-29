part of 'map_history_screen.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
LatLng puntoInicio = LatLng(0, 0);
LatLng puntoFinal = LatLng(0, 0);
List<Marker> marcadores = [];
final MapController mpController = MapController();

Map<Marker, HistorialModel> markersDataMap = {};

List<LatLng> pointsToPoly(List<HistorialModel> lista) {
  List<LatLng> puntos = [];

  lista.forEach((HistorialModel punto) {
    var point = LatLng(double.parse(punto.latitud!), double.parse(punto.longitud!));

    toMarkerDet(point, Icon(Icons.location_on, color: Colors.blue[800], size: 30,), punto);
    puntos.add(point);
  });

  print("Lista de PUNTOS para el POLYLINE: ${puntos}");
  puntos.reversed;

  puntoInicio = puntos.first;
  puntoFinal = puntos.last;

  toMarker(puntoInicio, Icon(Icons.flag_circle_rounded, color: Colors.green, size: 40,));
  toMarker(puntoFinal, Icon(Icons.flag_circle_rounded, color: Colors.redAccent, size: 40));

  print("Punto INICIO: ${puntoInicio}, Punto FINAL: ${puntoFinal}");

  return puntos;
}

toMarker(LatLng punto, Icon icono) {
  var marker = Marker(
      point: punto,
      width: 30.0,
      height: 30.0,
      child: icono
  );

  marcadores.add(marker);
}

toMarkerDet (LatLng punto, Icon icono, HistorialModel data) {
  //var miKey = data.latitud.toStri ng()+data.fecha1.toString()+data.fecha_pc.toString();
  var marker = Marker(
      point: punto,
      width: 30.0,
      height: 30.0,
      child: icono,
      key: ObjectKey(data)
      // child: GestureDetector(
      //   onTap: () {
      //     print("MARCADOR ${data.fecha_pc}");
      //     showMiDialog2(data);
      //   },
      //   child: icono,
      // )
  );

  markersDataMap[marker] = data;
  marcadores.add(marker);
}

showMiDialog(HistorialModel data) {
  showDialog(
      context: GlobalContext.navKey.currentContext!,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
            height: 200.0,
            child: infoDialogHistory(data, context)
        ),
      )
  );
}

showMiDialog2(HistorialModel data) {
  var point = LatLng(double.parse(data.latitud!), double.parse(data.longitud!));
   showDialog(
       barrierColor: Colors.transparent,
       context: GlobalContext.navKey.currentContext!,
       builder: (BuildContext context) => Dialog(
         child: SizedBox(
           height: 180,
           child: infoDialogHistory(data, context),
         )
       )
   );

}