import 'package:apprutas/Models/alert_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_manager.dart';
import 'package:apprutas/Services/fotos_api.dart';
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
                    Text("Screeen de Alertas"),
                    Expanded(
                        child: FutureBuilder(
                            future: getAlerts(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasData) {
                                //final lista = snapshot.data;
                                alertsManager;
                                alertas = snapshot.data!;
                                return buildAlert(alertas, context);
                              } else {
                                return Center(
                                  child: Text("No hay alertas disponibles"),
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
