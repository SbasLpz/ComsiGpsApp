part of 'map_screen.dart';

List<LocationModel> lista = LocationModel.locationsList();
//List<UnidadModel> lista2 = [];
ListviewManager unitsManager = ListviewManager();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
MapManager mpMan = MapManager();
//MapController mpController = MapController();

late GoogleMapController mapController;
String siccap = "";

LatLng _center = LatLng(9.9996, -84.1572);

void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}

List<Marker> markerList = [];
bool isControllerEnable = false;
BitmapDescriptor? customIcon;

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}



List<Marker> listToMarkerList(List<UnidadDataModel> lista) {
  print("La lista me llego con esta cantidad: ${lista.length}");
  //List<Marker> markerList = [];
  markerList.clear();
  print("•• • //Borre los datos • ••");
  //mpMan.markersList.clear();
  lista.forEach((UnidadDataModel loca){

    var latlong = GlobalContext.getLatLng(loca.Coordenadas!);
    print("LatLng (A ver si aca se cae): ${latlong['lat']}, ${latlong['long']}");
    var point = LatLng(double.parse(latlong['lat']!), double.parse(latlong['long']!));

      var marker = Marker(
          markerId:  MarkerId(loca.IDGPS ?? UniqueKey().toString()),
          position: point,
          icon: customIcon!,
          onTap: () {
            print("Buenas tardes -");
            showMiDialog(loca);
          }
      );
    print("YA CREE EL MARKER");
    markerList.add(marker);
    mpMan.markersList.add(marker);
    print("YA AGREGUE EL MARKER");
    //print("***** KEY ${loca.id_gps}");
  });

  print("---------->>>> Marker List lenght: ${markerList.length}");
  return markerList;
}

showMiDialog(UnidadDataModel unidad) {
  showDialog(
      context: GlobalContext.navKey.currentContext!,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
          child: infoDialog2(unidad, siccap, context),
        ),
      )
  );
}


List<UnidadDataModel> listaFiltrada(Set<String> unidades, List<UnidadDataModel> lista) {
  List<UnidadDataModel> filterList = [];

  lista.forEach((UnidadDataModel unit) {
    if(unidades.contains(unit.IDGPS!)) {
      filterList.add(unit);
    }
  });

  return filterList;
}

Stream<List<UnidadModel>> untisAvailable() async* {
  Future.delayed(Duration(seconds: 7));
  print("Stream: ACTUALICE UBICACIÓN");
  await unidadesFuture;
}

String convertDateFormat(String date) {
  // Define el formato de la fecha original y el formato deseado
  //DateFormat originalFormat = DateFormat('MM-dd-yy hh:mm a');
  DateFormat originalFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
  DateFormat desiredFormat = DateFormat('dd-MM-yyyy hh:mm:ss');

  // Parsear la fecha original y formatearla en el nuevo formato

  DateTime dateTime = originalFormat.parse(date);
  return desiredFormat.format(dateTime);
}

Future<int?> getIntevalo() async {
  int? intervalo = await SessionManager().getInt("intervalo");
  return intervalo;
}







