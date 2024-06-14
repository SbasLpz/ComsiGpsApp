part of 'map_screen.dart';

List<LocationModel> lista = LocationModel.locationsList();

List<Marker> listToMarkerList() {
  List<Marker> markerList = [];

  lista.forEach((LocationModel loca){
    var point = LatLng(double.parse(loca.lat!), double.parse(loca.long!));

    var marker = Marker(
        point: point,
        width: 30,
        height: 30,
        child: GestureDetector(
          onTap: () {
            print("Buenas tardes -");
            showMiDialog(loca.id!);
          },
          child: Image.asset('assets/images/truck500.png'),
        ),
    );

    markerList.add(marker);
  });

  return markerList;
}

showMiDialog(int id) {
  showDialog(
      context: GlobalContext.navKey.currentContext!,
      builder: (BuildContext context) => Dialog(
        child: SizedBox(
          height: 300.0,
            child: infoChart(id)
        ),
      )
  );
}