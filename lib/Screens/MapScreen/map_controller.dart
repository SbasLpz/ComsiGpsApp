part of 'map_screen.dart';

List<LocationModel> lista = LocationModel.locationsList();
//List<UnidadModel> lista2 = [];
ListviewManager unitsManager = ListviewManager();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
MapManager mpMan = MapManager();

List<Marker> listToMarkerList(List<UnidadModel> lista) {
  List<Marker> markerList = [];

  lista.forEach((UnidadModel loca){
    var point = LatLng(double.parse(loca.lat!), double.parse(loca.long!));

      var marker = Marker(
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
  });

  print("OOPPAA --- /////");
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