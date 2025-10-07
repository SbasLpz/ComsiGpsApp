import 'package:apprutas/Models/validation_model.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Utils/session_manager_custom.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/strings.dart' as globalStr;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:session_manager/session_manager.dart';

import '../RecuperarScreen/recuperar_screen.dart';

part 'inicio_sesion2_controller.dart';

class InicioSesion2Screen extends StatefulWidget {
  const InicioSesion2Screen({super.key});

  @override
  State<InicioSesion2Screen> createState() => _InicioSesionScreenState();
}

class _InicioSesionScreenState extends State<InicioSesion2Screen> {

  @override
  void initState() {
    // getVersion().then((res){
    //   version = res;
    // });
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            //color: COLOR_PRIMARY,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bc_login.jpeg'),
                    fit: BoxFit.cover
                )
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  //color: Colors.redAccent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset('assets/images/logo_comsi.png', width: 180, height: 180,),
                      // SizedBox(height: 15,),
                      // Text(
                      //   "COMSI",
                      //   style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 3, color: DARK_TER)
                      // ),
                      // Text(
                      //   "MONITOREO DE RUTA",
                      //   style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: DARK_TER, fontSize: 23),
                      // ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            //color: COLOR_PRIMARY,
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Wrap(
                                  runSpacing: 20.0,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "COMSI - GPS",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: DARK_TER, fontSize: 23),
                                      ),
                                    ),
                                    TextField(
                                      controller: userController,
                                      cursorColor: COLOR_SENCONDARY,
                                      style: TextStyle(fontSize: 13, color: COLOR_SENCONDARY),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                                        labelText: "Usuario",
                                          fillColor: Theme.of(context).colorScheme.onPrimary,
                                          filled: true,
                                        labelStyle: TextStyle(fontSize: 13, color: COLOR_SENCONDARY),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50),borderSide: BorderSide(color: COLOR_SENCONDARY)),
                                        floatingLabelStyle: TextStyle(color: Colors.red),
                                          floatingLabelBehavior: FloatingLabelBehavior.never
                                      ),
                                    ),
                                    TextField(
                                      controller: passController,
                                      cursorColor: COLOR_SENCONDARY,
                                      obscureText: true,
                                      style: TextStyle(fontSize: 13, color: COLOR_SENCONDARY),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                                        labelText: "Contraseña",
                                          fillColor: Theme.of(context).colorScheme.onPrimary,
                                          filled: true,
                                           labelStyle: TextStyle(fontSize: 13, color: COLOR_SENCONDARY),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(50),borderSide: BorderSide(color: COLOR_SENCONDARY)),
                                        floatingLabelStyle: TextStyle(color: COLOR_SENCONDARY),
                                        floatingLabelBehavior: FloatingLabelBehavior.never
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(
                                //   width: double.maxFinite,
                                //   height: 10,
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(builder: (context) => const RecuperarScreen()),
                                //     );
                                //   },
                                //   child: Align(
                                //     alignment: Alignment.centerRight,
                                //     child: Text(
                                //       "¿Olvido su contraseña?",
                                //       style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 20,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          padding: WidgetStateProperty.all(
                                          EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0)),
                                          backgroundColor: WidgetStateProperty.all(COLOR_BLUE),
                                          shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))
                                      ),
                                      onPressed: () {
                                        ingresar(context);
                                        //FirebaseCrashlytics.instance.crash();
                                      },
                                      child: Text("Acceder", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(GlobalContext.version, style: TextStyle(color: Colors.white),),
                      Text("Hecho por COMSI", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
