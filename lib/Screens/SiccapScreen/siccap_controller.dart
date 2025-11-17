part of 'siccap_screen.dart';

const tam = 14.0;

String shortDate(String? datetime) {
  if(datetime != null){
    if (datetime.trim().length > 3) {
      var shortdate = datetime.substring(0, datetime.length - 3);
      return shortdate;
    } else {
      return datetime;
    }
  } else {
    return "-";
  }
}

void _makePhoneCall(String? tel) async {

  if(tel != null) {
    var url = Uri.parse("tel:" + tel.trim());
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: "No se pudo llamar al ${tel}");
    }
  } else {
    Fluttertoast.showToast(msg: "Número de tel. inválido: '${tel}'");
  }

}