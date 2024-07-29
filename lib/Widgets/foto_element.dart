
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

  Widget buildFotos(List<UnidadModel> unidades, BuildContext context) {
    final unitsManager = context.watch<ListviewManager>();

    //print("Cantidad Units: ${searchManager.units.length}, AllUnits ${searchManager.allUnits.length}");
    return ListView.builder(
      itemCount: unidades.length,
      //itemCount: searchManager.units.isEmpty ? searchManager.allUnits.length : searchManager.units.length,
      itemBuilder: (context, index) {
        final unidad = unidades[index];
        var loc = unidad.lat.toString()+", "+unidad.long.toString();
        //final unidad = searchManager.units.isEmpty ? searchManager.allUnits[index] : searchManager.units[index];
        return InkWell(
          onTap: () {
            unitsManager.selectedItems(int.parse(unidad.id_gps!));
            //listviewManager.selectedItems(unidad.id!);
            mostrarSnackbar(context, int.parse(unidad.id_gps!));
          },
          child: Card(
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
                              unidad.desc.toString(),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary)
                            ),
                            flex: 3,
                          ),
                          Flexible(
                              flex: 1,
                              child: unitsManager.selectedIds.contains(int.parse(unidad.id_gps!)) || unitsManager.isChecked ? IconButton(
                                  onPressed: () {

                                  },
                                  icon: Icon(Icons.check_circle, size: 30,)
                              ): IconButton(
                                  onPressed: (){

                                  },
                                  alignment: Alignment.topRight,
                                  icon: Icon(Icons.circle_outlined, size: 30,)
                              ),
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
                              child: Container(
                                //color: Colors.purpleAccent,
                                child: ListTile(
                                  minTileHeight: double.minPositive,
                                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  leading: Icon(
                                    Icons.location_on_sharp,
                                    color: Theme.of(context).colorScheme.primary,
                                    size: 20,
                                  ),
                                  title: Text(
                                    unidad.lugar!.isNotEmpty ? "${unidad.lugar}" : unidad.lat.toString()+","+unidad.long.toString(),
                                    //unidad.lat.toString()+",fsdfdsfsdf "+unidad.long.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
                                  ),
                                ),
                              )
                          ),
                          Flexible(
                              flex: 1,
                              child: ListTile(
                                minTileHeight: double.minPositive,
                                leading: Icon(
                                  Icons.circle,
                                  color: determineUnitStatus(unidad.last!).color,
                                  size: 20,
                                ),
                                title: Text(
                                    determineUnitStatus(unidad.last!).tiempo,
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
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
                              child: ListTile(
                                minTileHeight: double.minPositive,
                                //contentPadding: EdgeInsets.all(0.0),
                                leading: Icon(
                                    Icons.car_crash,
                                    color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                title: Text(
                                    unidad.placa.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
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
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 20,
                                ),
                                title: Text(
                                    unidad.id_gps.toString(),
                                    style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.primary)
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