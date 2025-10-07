import 'package:apprutas/Models/command_data_model.dart';
import 'package:apprutas/Screens/CommandScreen/command_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart' as nv;
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/command_model.dart';

part 'command_controller.dart';

class CommandScreen extends StatefulWidget {
  const CommandScreen({super.key, required String this.idgps});

  final String idgps;

  @override
  State<CommandScreen> createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  @override
  void initState() {
    _getCommandsFuture = getCommands(widget.idgps);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final manager = context.watch<CommandManager>();
    //CommandModel? selected;
    print("TAMAÑO LISTA COMANDOS: ${listaComandos.length}");
    print("ID UNIDAD: ${widget.idgps}");

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
          height: 450,
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
                "Unidad: ${widget.idgps}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: FutureBuilder(
                    future: getCommands(widget.idgps),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData){
                        var res = snapshot.data!;
                        if(res.data == null) {
                          print("LENGHT LISTA COMANDOS: ES NULL");
                        } else {
                          print("LENGHT LISTA COMANDOS: ${res.data!.length}");
                        }

                        listaComandos = res.data!;
                        print("listaComandos: ${listaComandos.length}");
                        manager.changeHayComandos(res.status == "success");
                        return manager.hayComandos ? DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: 'Comandos',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            hint: listaComandos.length == 0 ? Text("No disponibles") : Text("Seleccione un comando"),
                            value: manager.selected,
                            items: listaComandos.map<DropdownMenuItem<String>>((CommandDataModel cmd){
                              return DropdownMenuItem<String>(
                                  value: cmd.descripcion,
                                  child: Text(cmd.descripcion ?? '--')
                              );
                            }).toList(),
                            onChanged: (String? newValue){
                              manager.toggleButton(newValue);
                            }
                        ) : Center(child: Text("Este dispositivo NO tiene comanods disponibles"),);
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
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent
                        ),
                        onPressed: (){
                          manager.changeShowMessage(false);
                          manager.setMessage("");

                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=> nv.NavigationScreen())
                          );
                        },
                        //color: Theme.of(context).colorScheme.onPrimary
                        child: Text("Regresar", style: TextStyle(color: Colors.white),)
                    ),
                    SizedBox(width: 10,),
                    manager.selected != null && manager.hayComandos ? OutlinedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green
                          ),
                          onPressed: () async{
                            manager.changeEstaCargando(true);
                            var cmd = listaComandos.firstWhere((cm)=>cm.descripcion == manager.selected);
                            try {
                              var res = await sendCommand(widget.idgps, cmd.id_sms_hardware!);

                              if(res.status == "success"){
                                manager.changeShowMessage(true);
                                manager.setMessage(res.message.toString());
                                manager.alert("Comando enviado con exito!");
                              } else {
                                manager.alert("Algo salio mal: ${res.message.toString()}");
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
                        child: Text("Enviar", style: TextStyle(color: Colors.white))
                    ) : Text(""),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              !manager.estaCargando ? Text(manager.infoCmd) : CircularProgressIndicator(),
              SizedBox(height: 10,),
              manager.showMessage ? Text("Respuesta del servidor:", style: TextStyle(fontWeight: FontWeight.bold),)
                  : Text(""),
              manager.showMessage ? Expanded(
                  child: ExpandableText(
                    manager.message,
                    expandText: "Mostrar más",
                    collapseText: "Mostrar menos",
                    maxLines: 1,
                    linkColor: Colors.blue,
                  )
              ) : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
