
import 'package:apprutas/Models/unidad_data_model.dart';
import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/HistorialScreen/historial_screen.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager2.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:apprutas/Utils/Global/colors.dart' as globalClr;
import 'package:provider/provider.dart';
import '../Models/unidad_model.dart';

TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
//ListviewManager listviewManager = ListviewManager();
//ListviewManager2 serchManager = ListviewManager2();
//bool isDark = Theme.of(GlobalContext.navKey.currentContext!).brightness == Brightness.dark;

UnidadModel unit = UnidadModel();

  Widget buildFotos(List<UnidadDataModel> unidades, BuildContext context, Key key) {
    final unitsManager = context.watch<ListviewManager>();

    //print("Cantidad Units: ${searchManager.units.length}, AllUnits ${searchManager.allUnits.length}");
    return ListView.builder(
      //key: key,
      itemCount: unidades.length,
      //itemCount: searchManager.units.isEmpty ? searchManager.allUnits.length : searchManager.units.length,
      itemBuilder: (context, index) {
        final unidad = unidades[index];
        //var loc = unidad.lat.toString()+", "+unidad.long.toString();
        //final unidad = searchManager.units.isEmpty ? searchManager.allUnits[index] : searchManager.units[index];
        //calculateUnitStatus(unidad.fecha1);
        return InkWell(

          onTap: () {
            unitsManager.selectedItems(unidad.IDGPS!.toString().trim());
            //listviewManager.selectedItems(unidad.id!);
            mostrarSnackbar(context, unidad.IDGPS!.toString().trim());
          },
          child: Card(
              key: ValueKey(unidad.IDGPS ?? unidad.Descripcion),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              unidad.Descripcion!,
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary)
                            ),
                            flex: 3,
                          ),
                          Flexible(
                              flex: 1,
                              child: unitsManager.selectedIds.contains(unidad.IDGPS!.toString().trim()) || unitsManager.isChecked == true ?
                              Align(
                                alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                                    child: Icon(Icons.check_circle, size: 30,),
                                  )
                              ) :
                              Align(
                                alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 30, 0),
                                    child: Icon(Icons.circle_outlined, size: 30,),
                                  )
                              )
                              ),
                        ],
                      ),
                    ),
                    Container(
                      //color: Colors.yellow,
                      //height: 40,
                      child: Row(
                        children: [
                          Flexible(
                              flex: 1,
                              child: ListTile(
                                minTileHeight: double.minPositive,
                                //contentPadding: EdgeInsets.all(0.0),
                                leading: Icon(
                                  Icons.car_crash,
                                  color: Theme.of(context).colorScheme.secondary,
                                  size: 20,
                                ),
                                title: Text(
                                    unidad.Placa.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary)
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              child: ListTile(
                                minTileHeight: double.minPositive,
                                leading: Icon(
                                  Icons.circle,
                                  color: determineUnitStatus(unidad.tiempoReporte.toString().trim()).color,
                                  size: 20,
                                ),
                                title: Text(
                                    determineUnitStatus(unidad.tiempoReporte.toString().trim()).tiempo,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary)
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                    Container(
                      //height: 40,
                      //color: Colors.orangeAccent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Container(
                                //color: Colors.purpleAccent,
                                child: ListTile(
                                  minTileHeight: double.minPositive,
                                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  leading: Icon(
                                    Icons.person,
                                    color: Theme.of(context).colorScheme.secondary,
                                    size: 20,
                                  ),
                                  title: Text(
                                      unidad.nombrePiloto.toString(),
                                    //unidad.data!.lat.toString()+","+unidad.data!.long.toString(),
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary)
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              child: ListTile(
                                minTileHeight: double.minPositive,
                                //contentPadding: EdgeInsets.all(0.0),
                                leading: Icon(
                                  Icons.key,
                                  color: Theme.of(context).colorScheme.secondary,
                                  size: 20,
                                ),
                                title: Text(
                                    unidad.IDGPS.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.secondary)
                                ),
                              )
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
        );
      },
    );
  }

showMessage() {

}