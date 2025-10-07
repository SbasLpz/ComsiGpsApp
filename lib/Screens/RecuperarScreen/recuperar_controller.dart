// part of 'recuperar_screen.dart';
//
// TextEditingController correoController = new TextEditingController();
// final ValueNotifier<bool> isLoading = ValueNotifier(false);
// var msg = "";
//
// recoverPassword() async {
//   isLoading.value = true;
//
//   var result = await recuperarPassword(correoController.text.trim());
//
//   if(result.success! == true) {
//     msg = "Correo de recuperación enviado con exito !";
//     print("--- Correo de recuperación enviado!: ${result.msg.toString()}");
//     correoController.clear();
//   } else {
//     //No se pudo enviar el correo
//     msg = "El servidor responde: ${result.msg}. No se pudo enviar el correo de recuperación.";
//     print("--- Error del servidor en cambio de constraseña: ${result.msg.toString()}");
//   }
//
//   isLoading.value = false;
// }