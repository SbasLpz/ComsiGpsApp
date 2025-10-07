// import 'package:apprutas/Services/road_api.dart';
// import 'package:flutter/material.dart';
//
// part 'recuperar_controller.dart';
//
// class RecuperarScreen extends StatefulWidget {
//   const RecuperarScreen({super.key});
//
//   @override
//   State<RecuperarScreen> createState() => _RecuperarScreenState();
// }
//
// class _RecuperarScreenState extends State<RecuperarScreen> {
//   @override
//   void dispose() {
//     correoController.clear();
//     msg = "";
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Regresar",
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("Recupere su contraseña",
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 28),
//             ),
//             SizedBox(height: 20,),
//             Text("Ingrese el correo electronico con el que se registro en RoadControl.",
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal, fontSize: 16,),
//             ),
//             SizedBox(height: 30,),
//             TextField(
//               controller: correoController,
//               cursorColor: Theme.of(context).colorScheme.secondary,
//               style: TextStyle(fontSize: 13),
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 labelText: "Correo registrado",
//                 fillColor: Theme.of(context).colorScheme.surface,
//                 filled: true,
//                 labelStyle: TextStyle(fontSize: 13),
//                 focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
//                 //floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
//                 //floatingLabelBehavior: FloatingLabelBehavior.never
//               ),
//             ),
//             SizedBox(height: 30,),
//             ElevatedButton(
//                 style: ButtonStyle(
//                     padding: WidgetStateProperty.all(
//                         EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0)),
//                     shape: WidgetStateProperty.all(
//                         RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))
//                 ),
//                 onPressed: () {
//                   recoverPassword();
//                 },
//                 child: Text("Recuperar", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
//             ),
//             SizedBox(height: 30,),
//             ValueListenableBuilder<bool>(
//                 valueListenable: isLoading,
//                 builder: (context, value, child) {
//                   if(value) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     return Text(msg);
//                   }
//                 }
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
