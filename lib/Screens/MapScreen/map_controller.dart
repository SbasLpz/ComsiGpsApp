part of 'map_screen.dart';

List<LocationModel> lista = LocationModel.locationsList();
//List<UnidadModel> lista2 = [];
ListviewManager unitsManager = ListviewManager();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
MapManager mpMan = MapManager();
//MapController mpController = MapController();
Map<BitmapDescriptor, iconosName> iconosMap = {};

//late GoogleMapController mapController;
//late GoogleMapController mapController;
Completer<GoogleMapController> mapControllerCompleter = Completer<GoogleMapController>();

String siccap = "";

LatLng _center = LatLng(9.9996, -84.1572);



List<Marker> markerList = [];
bool isControllerEnable = false;

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
}

BitmapDescriptor determineIcons (String icono) {
  //var xds = iconosMap.forEach((icono, name) => name == iconosName.amarillo ? icono : null);
  //var xds2 = iconosMap.entries.firstWhere((element) => element.value == iconosName.amarillo).key;

  switch (icono){
    case "NormalAmarillo.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.amarillo).key;
    case "NormalVerde.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.verde).key;
    case "NormalRojo.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.rojo).key;
    case "NormalMorado.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.morado).key;
    case "Patverde.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.patverde).key;
    case "Normal.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.normal).key;
    case "PatNormal.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.patnormal).key;
    case "PickNormal.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.pickNormal).key;
    case "Pickverde.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.pickVerde).key;
      case "moto.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.moto).key;
      case "motoVerde.png":
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.motoVerde).key;
    default:
      return iconosMap.entries.firstWhere((element) => element.value == iconosName.amarillo).key;
  }
}

List<Marker> listToMarkerList(List<UnidadDataModel> lista) {
  print("La lista me llego con esta cantidad: ${lista.length}");
  //List<Marker> markerList = [];
  markerList.clear();
  print("•• • //Borre los datos • ••");
  //mpMan.markersList.clear();
  lista.forEach((UnidadDataModel loca){

    var latlong = GlobalContext.getLatLng(loca.Coordenadas!);
    print("LatLng COORDS: ${loca.Coordenadas}");
    print("COORDS ICON TO MAKE: ${loca.icono}");
    print("LatLng (A ver si aca se cae): ${latlong['lat']}, ${latlong['long']}");
    var point = LatLng(double.parse(latlong['lat']!), double.parse(latlong['long']!));

      var marker = Marker(
          markerId:  MarkerId(loca.IDGPS ?? UniqueKey().toString()),
          position: point,
          // Estan invertido ANARANJADO es Asignado y VERDE sin asignar
          //icon: loca.asignado == null || loca.asignado == "" || loca.asignado == "No" ? customIcon! : customIconNoAsig!,
          icon: determineIcons(loca.icono ?? "-"),
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

String getIgnicionVal(int? igni) {
  String value = "";

  switch (igni) {
    case 0:
      value = "Apagado";
      break;
    case 1:
      value = "Encendido";
      break;
    case 3:
      value = "Desconocido";
      break;
      default:
      value = "Sin conocer";
      break;
  }

  return value;
}

void makePhoneCall(String? tel) async {

  if(tel != null) {
    var url = Uri.parse("tel:" + tel.trim());
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: "No se pudo llamar al ${tel}");
    }
  } else {
    Fluttertoast.showToast(msg: "Número de tel. inválido: '${tel}'");
  }

}







