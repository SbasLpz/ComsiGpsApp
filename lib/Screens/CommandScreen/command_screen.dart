import 'package:apprutas/Screens/CommandScreen/command_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart' as nv;
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/command_model.dart';
import '../../Widgets/foto_element.dart';

part 'command_controller.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required String this.id_vehiculo});

  final String id_vehiculo;

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  void initState() {
    _commandsFuture = getCommands(widget.id_vehiculo);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final manager = context.watch<CommandManager>();
    //CommandModel? selected;
    print("TAMAÑO LISTA COMANDOS: ${comandos.length}");
    print("ID UNIDAD: ${widget.id_vehiculo}");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Regresar",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Container(
          //color: Colors.green,
          width: double.maxFinite,
          height: 410,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Theme.of(context).colorScheme.onSecondary),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(color: COLOR_PRIMARY, borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Enviar Comando",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Unidad: ${widget.id_vehiculo}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: FutureBuilder(
                    future: _commandsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData){
                        comandos = snapshot.data!;
                        return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Comandos',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            hint: comandos.length == 0 ? Text("No disponibles") : Text("Seleccione un comando"),
                            value: manager.selected,
                            items: comandos.map<DropdownMenuItem<String>>((CommandModel cmd){
                              return DropdownMenuItem<String>(
                                  value: cmd.descripcion,
                                  child: Text(cmd.descripcion ?? '--')
                              );
                            }).toList(),
                            onChanged: (String? newValue){
                              manager.toggleButton(newValue);
                            }
                        );
                      } else {
                        return Center(
                          child: Text("No se pudo conectar al servidor."),
                        );
                      }
                    },
                ),
              ),
              SizedBox(height: 60,),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                //color: Colors.blueAccent,
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> nv.NavigationScreen())
                          );
                        },
                        child: Text("Cancelar", style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
                    ),
                    SizedBox(width: 10,),
                    manager.selected != null ? OutlinedButton(
                          onPressed: () async{
                            manager.changeEstaCargando(true);
                            var cmd = comandos.firstWhere((cm)=>cm.descripcion == manager.selected);
                            try {
                              var res = await sendCommand(widget.id_vehiculo, cmd.command!);
                              if(res.success == true){
                                manager.alert("Comando enviado con exito!");
                              } else {
                                manager.alert("Algo salio mal: ${res.msg.toString()}");
                              }
                              manager.changeEstaCargando(false);
                            } catch(e){
                              manager.changeEstaCargando(false);
                              print("----- EXCEPCIÓN ----");
                              Text("Excepción: ${e}");
                            }
                            manager.selected = null;
                            setState(() {
  
                            });
                          },
                        child: Text("Enviar")
                    ) : OutlinedButton(
                      onPressed: null,
                      child: Text("Enviar")
                    )
                  ],
                ),
              ),
              SizedBox(height: 30,),
              !manager.estaCargando ? Text(manager.infoCmd) : CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
