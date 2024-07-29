import 'package:apprutas/Models/validation_model.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/strings.dart' as globalStr;
import 'package:session_manager/session_manager.dart';

part 'inicio_sesion_controller.dart';

class InicioSesionScreen extends StatefulWidget {
  const InicioSesionScreen({super.key});

  @override
  State<InicioSesionScreen> createState() => _InicioSesionScreenState();
}

class _InicioSesionScreenState extends State<InicioSesionScreen> {

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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          //color: Colors.redAccent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bienvenido",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Ingrese sus credenciales",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 60,
              ),
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
                height: 60,
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
    );
  }
}
