
import 'dart:core';
import 'dart:ffi';

import 'package:apprutas/Screens/AjustesScreen/ajustes_screen.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_screen.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_manager.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Styles/theme_manager.dart';
import 'package:apprutas/Styles/theme_manager2.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'navigation_controller.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreen();
}

class _NavigationScreen extends State<NavigationScreen> {

  onTapDrawer(int index) {
    setState(() {
      if(index == -1){
        currentPageIndexDrawer = -1;
        currentPageIndexNavBar = 0;
      } else {
        currentPageIndexDrawer = index;
        currentPageIndexNavBar = -1;
      }
    });
  }
  //bool light = true;
  bool darkMode = thmManager.thMode == ThemeMode.dark;
  bool darkMode2 = thmManager2.myAttrs.mode == ThemeMode.dark;
  
  @override
  void initState() {
    // TODO: implement initState
    _loadThemeMode();
    super.initState();
  }

  void _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode2 = prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final navManager = context.watch<NavigationManager>();
    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<String>(
          valueListenable: GlobalContext.appBar,
          builder: (context, value, child){
            return Text(value, style: TextStyle(fontSize: 24),);
          },
        ),
        // title: Text(
        //
        //   style: TextStyle(fontSize: 24),
        // ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                onPressed: (){
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu)
            );
          },
        ),
      ),
      bottomNavigationBar: navManager.currentPageIndexNavBar0 != -1 ? NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: COLOR_PRIMARY,
          iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states){
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: Theme.of(context).colorScheme.onPrimary); // Color del icono seleccionado
            }
            return IconThemeData(color: Theme.of(context).colorScheme.secondary);
          }),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index){
            setState(() {
              navManager.setIndex(index);
            });
          },
          indicatorColor: COLOR_PRIMARY,
          selectedIndex: navManager.currentPageIndexNavBar0,
          destinations: <Widget>[
            NavigationDestination(
                icon: Icon(Icons.list_alt_rounded),
                label: "Unidades"
            ),
            NavigationDestination(
                icon: Icon(Icons.map_rounded),
                label: "Mapa"
            ),
            NavigationDestination(
                icon: Icon(Icons.notifications_active_rounded),
                label: "Alertas"
            )
          ],
        ),
      ) : null,
      drawer: Drawer(
        child: ListView (
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: COLOR_PRIMARY
              ),
              child: Column(
                  children: [
                    SizedBox(height: 20,),
                    SizedBox(
                      height: 60,
                      width: 116,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo_white.png'),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Text("Opciones de la app", style: TextStyle(color: Colors.white),)
                    ),
                  ]),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              selected: currentPageIndexDrawer == 0,
              title: const Text("Ajustes"),
              onTap: () {
                onTapDrawer(0);
                Navigator.pop(context);
                navManager.currentPageIndexNavBar0 = -1;
              },
            ),
            ListTile(
              leading: Icon(Icons.login_outlined),
              selected: currentPageIndexDrawer == 1,
              title: const Text("Cerrar sesión"),
              onTap: () {
                //onTapDrawer(1);
                //Navigator.pop(context);
                SystemNavigator.pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.map_outlined,),
              title: const Text("Monitoreo"),
              onTap: () {
                //onTapDrawer(0);

                //currentPageIndexDrawer = 2;

                Navigator.pop(context);
                currentPageIndexDrawer = -1;
                navManager.currentPageIndexNavBar0 = 0;
                setState(() {

                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NavigationScreen()),
                // );
              },
            ),
            SwitchListTile(
              title: Text("Modo oscuro"),
                //value: darkMode2,
                value: thmManager2.isDarkMode,
                activeTrackColor: Theme.of(context).colorScheme.onTertiary,
                //inactiveTrackColor: Theme.of(context).colorScheme.onTertiary,
                onChanged: (newValue) {
                  // thmManager.toggleMode(newValue);
                  // print("SWITCH presionado, valor: ${newValue}");
                  //
                  thmManager2.toggleTheme();
                  setState(() {
                    darkMode2 = newValue;
                  });

                }
            ),
            ListTile(
              title: Text("Versión: ${GlobalContext.version}"),
            )
            // ElevatedButton(
            //     onPressed: () {
            //       thmManager2.toggleTheme();
            //     },
            //     child: const Text("Toggle Theme")
            // )
          ],
        ),
      ),
      body: Container(
        child: currentPageIndexDrawer >= 0
            ? widgetOptionsDawer[currentPageIndexDrawer] : widgetOptionsNavBar[navManager.currentPageIndexNavBar0],
      ),
    );
  }
}

