part of 'inicio_sesion2_screen.dart';

TextEditingController userController = new TextEditingController();
TextEditingController passController = new TextEditingController();

var version = "";

Future<String> getVersion() async {
  var r = await SessionManager.sessionManager.getString("version");
  return r;
}

ingresar (BuildContext context) {
  if(userController.text.trim() != "" && passController.text.trim() != "") {
    var res = postLogin(userController.text, passController.text);
    res.then((data) {
      if(data.status == "success" && data.data != null) {
        SessionManager().setString("tokenUser", data.data!.token.toString());
        SessionManager().setString("idGrupo", data.data!.idGrupo.toString());
        SessionManager().setString("siccap", data.data!.siccap.toString());
        print("USERNAME IS ${data.data!.usuario}");
        SessionManager().setString("username", data.data!.usuario.toString());
        SessionManagerCustom.saveLoginData(data);

        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
        print("Consulta EXITOSA: ${data.status}, ${data.message}");
        SessionManager().setString("cc", passController.text.trim());
      }else {
        showInfoDialog(
            "Credenciales incorrectas",
            "El Usuario, Cuenta o Contraseña son incorrectos.",
            'Entendido',
            context);

        print("Consulta FALLIDA: ${data.status}, ${data.message} ");
      }
    });
  } else {
    showInfoDialog(
        "Ingrese sus credenciales completas",
        "No pueden ir los campos vacios",
        'Entendido',
        context);
  }
}

showInfoDialog (String mTitle, String content, String mButton, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(mTitle),
        content: Text(content),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, mButton),
              child: Text(mButton)
          ),
        ],
      )
  );
}