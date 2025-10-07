import 'package:apprutas/Models/alert_data_model.dart';
import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_manager.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Widgets/alert_element.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/book_model.dart';
import '../../Styles/theme_manager2.dart';
import '../../Utils/global_context.dart';

part 'alerts_controller.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  @override
  void initState() {
    GlobalContext.appBar.value = "Alertas";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final alertsManager = context.watch<AlertsManager>();
    return Scaffold(
        body: Consumer<ThemeManager2>(
            builder: (context, themeManeger, child) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                //setState(() {});
              });
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SearchBar(
                            controller: searchController,
                            hintText: "Buscar con base en la descripcion",
                            backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                            onChanged: (value) {
                              print("New Value Detected: ${value}");
                              context.read<AlertsManager>().search(value);
                            },
                            leading: IconButton(
                                onPressed: () {
                                  //print("Controllerop: ${searchController.text}");
                                },
                                icon: Icon(Icons.search)
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            searchController.text = "";
                            alertsManager.resetSearchText();

                            alertasFuture;
                            setState(() {

                            });
                          },
                          icon: Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Expanded(
                        child: FutureBuilder(
                            future: getAlerts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                //final lista = snapshot.data;
                                alertsManager;

                                if (snapshot.data == null) {
                                  return Center(
                                    child: Text("Error desconocido ${snapshot.data}"),
                                  );
                                } else {
                                  if (snapshot.data!.success == false || snapshot.data!.success == null) {
                                    return Center(
                                      child: Text("El server respondio: ${snapshot.data!.message}"),
                                    );
                                  } else {
                                    alertas = snapshot.data!.data!;

                                    if (alertas.length <= 0) {
                                      return Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Tu bandeja de alertas esta al día.", style: TextStyle(fontSize: 15),),
                                            Image.asset(
                                              'assets/images/no_imbox.png',
                                              width: 200,
                                              height: 200,
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      var alerts = alertas;

                                      if(!alertsManager.alertFiltradas.isEmpty){
                                        var dataUpdated = alerts.where((item) => alertsManager.alertFiltradas.any((unit) => unit.Descripcion == item.Descripcion)).toList();
                                        alerts = dataUpdated;
                                      }

                                      alertsManager.alertAll = snapshot.data!.data!;

                                      return buildAlert(alerts, context);
                                    }
                                  }
                                }

                              } else {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Error desconocido: ${snapshot.data}"),
                                    Image.asset(
                                      'assets/images/error.png',
                                      width: 200,
                                      height: 200,
                                    ),
                                  ],
                                );
                              }
                            }
                        )
                    )
                  ],
                ),
              );
            }));
  }}
