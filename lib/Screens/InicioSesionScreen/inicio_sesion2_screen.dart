import 'package:apprutas/Models/validation_model.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/strings.dart' as globalStr;
import 'package:session_manager/session_manager.dart';

part 'inicio_sesion2_controller.dart';

class InicioSesion2Screen extends StatefulWidget {
  const InicioSesion2Screen({super.key});

  @override
  State<InicioSesion2Screen> createState() => _InicioSesionScreenState();
}

class _InicioSesionScreenState extends State<InicioSesion2Screen> {

  @override
  void dispose() {
    cuentaController.dispose();
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
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background_red.jpg'),
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
                      Image.asset('assets/images/logo_off2.png'),
                      SizedBox(height: 40,),
                      Text(
                        "CONTAINER",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 3)
                      ),
                      Text(
                        "TRACKING APP",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.normal, color: COLOR_TER),
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 60,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
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
                                    TextField(
                                      controller: cuentaController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Cuenta",
                                      ),
                                    ),
                                    TextField(
                                      controller: userController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Usuario",
                                      ),
                                    ),
                                    TextField(
                                      controller: passController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: "Contraseña",
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "¿Olvido su contraseña?",
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: COLOR_PRIMARY),
                                  ),
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      ingresar(context);
                                    },
                                    child: Text("Ingresar", style: TextStyle(color: Colors.white),)
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      )
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
