part of 'inicio_sesion2_screen.dart';

TextEditingController cuentaController = new TextEditingController();
TextEditingController userController = new TextEditingController();
TextEditingController passController = new TextEditingController();

var version = "";

Future<String> getVersion() async {
  var r = await SessionManager.sessionManager.getString("version");
  return r;
}

ingresar (BuildContext context) {
  if(cuentaController.text.trim() != "" && userController.text.trim() != "" && passController.text.trim() != "") {
    var res = postLogin(cuentaController.text, userController.text, passController.text);
    res.then((data) {
      if(data.success!) {
        SessionManager().setString("tokenUser", data.token.toString());
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationScreen()),
        );
        print("Consulta EXITOSA: ${data.success}, ${data.msg}");
        SessionManager().setString("cc", passController.text.trim());
      }else {
        showInfoDialog(
            "Credenciales incorrectas",
            "El Usuario, Cuenta o Contraseña son incorrectos.",
            'Entendido',
            context);

        print("Consulta FALLIDA: ${data.success}, ${data.msg}, ${data.msg_vencido}");
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