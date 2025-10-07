part of 'ajustes_screen.dart';

TextEditingController passController = new TextEditingController();
TextEditingController newPassController = new TextEditingController();
TextEditingController confirmPassController = new TextEditingController();
final ValueNotifier<bool> isLoading = ValueNotifier(false);
var msg = "";

checkChangePassword() async {
  isLoading.value = true;
  var cc = await SessionManager().getString("cc");

  if(passController.text.trim() == cc) {

    if(newPassController.text.trim() == confirmPassController.text.trim()){

      var result = await changePassword(cc, newPassController.text.trim(), confirmPassController.text.trim());
      if(result.status == "success") {
        msg = "Contraseña cambiada !";
        print("--- Contraseña cambiada !: ${result.message.toString()}");
        SessionManager().setString("cc", newPassController.text.trim());
        passController.clear();
        newPassController.clear();
        confirmPassController.clear();
      } else {
        //No se pudo cambiar la contraseña
        msg = "Error del servidor: "+result.message.toString();
        print("--- Error del servidor: ${result.message.toString()}");
      }
    } else {
      //La contraseña nueva no coincide
      msg = "La contraseña nueva y la de confirmación no son iguales.";
      print("--- La contraseña nueva y la de confirmación no son iguales.");
    }
  } else {
    //Contraseña incorrecta
    msg = "Contraseña actual incorrecta.";
    print("--- Contraseña actual incorrecta.");
  }

  isLoading.value = false;
}
