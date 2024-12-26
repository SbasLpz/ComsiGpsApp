part of 'map_screen.dart';

List<LocationModel> lista = LocationModel.locationsList();
//List<UnidadModel> lista2 = [];
ListviewManager unitsManager = ListviewManager();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
MapManager mpMan = MapManager();
MapController mpController = MapController();

List<Marker> markerList = [];
bool isControllerEnable = false;

List<Marker> listToMarkerList(List<UnidadModel> lista) {
  //List<Marker> markerList = [];
  markerList.clear();
  print("•• • //Borre los datos • ••");
  //mpMan.markersList.clear();
  lista.forEach((UnidadModel loca){
    var point = LatLng(double.parse(loca.lat!), double.parse(loca.long!));

      var marker = Marker(
        key: Key(loca.id_gps!),
        point: point,
        width: 30,
        height: 30,
        child: GestureDetector(
          onTap: () {
            print("Buenas tardes -");
            showMiDialog(loca);
          },
          child: Image.asset('assets/images/truck500.png'),
        ),
    );

    markerList.add(marker);
    mpMan.markersList.add(marker);
    //print("***** KEY ${loca.id_gps}");
  });

  print("---------->>>> Marker List lenght: ${markerList.length}");
  return markerList;
}

showMiDialog(UnidadModel unidad) {
  showDialog(
      context: GlobalContext.navKey.currentContext!,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
          child: infoDialog2(unidad, context),
        ),
      )
  );
}


List<UnidadModel> listaFiltrada(Set<int> unidades, List<UnidadModel> lista) {
  List<UnidadModel> filterList = [];

  lista.forEach((UnidadModel unit) {
    if(unidades.contains(int.parse(unit.id_gps!))) {
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
  DateFormat originalFormat = DateFormat('MM-dd-yy hh:mm a');
  DateFormat desiredFormat = DateFormat('dd-MM-yy hh:mm a');

  // Parsear la fecha original y formatearla en el nuevo formato
  DateTime dateTime = originalFormat.parse(date);
  return desiredFormat.format(dateTime);
}

Future<int?> getIntevalo() async {
  int? intervalo = await SessionManager().getInt("intervalo");
  return intervalo;
}




