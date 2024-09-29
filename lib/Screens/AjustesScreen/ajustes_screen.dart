import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/RecuperarScreen/recuperar_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:session_manager/session_manager.dart';

part 'ajustes_controller.dart';
class AjustesScreen extends StatefulWidget {
  const AjustesScreen({super.key});

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  late SingleValueDropDownController _cnt;
  late Future<void> _initialization;

  @override
  void initState() {
    GlobalContext.appBar.value = "Ajustes";
    //GlobalContext.appBar = "Ajustes";
    _cnt = SingleValueDropDownController();
    _initialization = _initializeDropDownValue();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _initializeDropDownValue() async {
    int? intervalo = await getIntevalo();
    _cnt.setDropDown(DropDownValueModel(name: intervalo == 60 ? "1 minuto" : "${intervalo} segundos",
        value: intervalo.toString()));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            //color: Colors.redAccent,
            child: Column(
              children: [
                // ListTile(
                //   title: Text("Intervalo de actualización de unidad:"),
                //   leading: Icon(Icons.access_alarm),
                // ),
                ExpansionTile(
                  title: Text("Intervalo de actualización de unidad:"),
                  leading: Icon(Icons.access_alarm),
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  children: [
                    DropDownTextField(
                      //padding: EdgeInsets.all(30),
                      //dropdownColor: Colors.blue,
                      listTextStyle: TextStyle(color: Colors.black),
                      //initialValue: DropDownValueModel(name: '5 segundos', value: "5"),
                      controller: _cnt,
                      dropDownItemCount: 5,
                      //initialValue: _cnt.setDropDown(),
                      dropDownList: const [
                        DropDownValueModel(name: '5 segundos', value: "5"),
                        DropDownValueModel(name: '10 segundos', value: "10"),
                        DropDownValueModel(name: '15 segundos', value: "15"),
                        DropDownValueModel(name: '30 segundos', value: "30"),
                        DropDownValueModel(name: '1 minuto', value: "60"),
                      ],
                      onChanged: (sel) {
                        print("VAL SELECTED ${sel.value}");
                        SessionManager().setInt("intervalo", int.parse(sel.value));
                      },
                    ),
                  ],
                ),
                //Text("Intervalo de actualización de unidad:", style: Theme.of(context).textTheme.titleMedium,),
                //SizedBox(height: 20,),

                SizedBox(height: 20,),
                //Text("Cambio de contraseña:", style: Theme.of(context).textTheme.titleMedium,),
                //SizedBox(height: 20,),
                ExpansionTile(
                  title: Text("Cambio de contraseña"),
                  leading: Icon(Icons.password,),
                  onExpansionChanged: (value) {
                    if(!value){
                      setState(() {
                        msg = "";
                      });
                    }
                  },
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  children: [
                    SizedBox(height: 20,),
                    TextField(
                      controller: passController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      obscureText: true,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "Contraseña actual",
                          fillColor: Theme.of(context).colorScheme.surface,
                          filled: true,
                          labelStyle: TextStyle(fontSize: 13),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
                          //floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                          //floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: newPassController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      obscureText: true,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Contraseña nueva",
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelStyle: TextStyle(fontSize: 13),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
                        //floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        //floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextField(
                      controller: confirmPassController,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      obscureText: true,
                      style: TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        labelText: "Confirmar contraseña nueva",
                        fillColor: Theme.of(context).colorScheme.surface,
                        filled: true,
                        labelStyle: TextStyle(fontSize: 13),
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary)),
                        //floatingLabelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        //floatingLabelBehavior: FloatingLabelBehavior.never
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 40.0, vertical: 14.0)),
                            shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))
                        ),
                        onPressed: () {
                          //ingresar(context);
                          checkChangePassword();
                        },
                        child: Text("Cambiar", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
                    ),
                    SizedBox(height: 20,),
                    ValueListenableBuilder<bool>(
                        valueListenable: isLoading,
                        builder: (context, value, child) {
                          if(value) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return Text(msg);
                          }
                        }
                    )
                  ],

                ),
                // SizedBox(height: 20,),
                // ListTile(
                //   title: Text("Recuperar contraseña"),
                //   leading: Icon(Icons.key_rounded),
                //   tileColor: Theme.of(context).colorScheme.onPrimaryContainer,
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const RecuperarScreen()),
                //     );
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
