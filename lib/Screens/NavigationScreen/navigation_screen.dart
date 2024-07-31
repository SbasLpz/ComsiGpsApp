
import 'dart:core';
import 'dart:ffi';

import 'package:apprutas/Screens/AlertsScreen/alerts_screen.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_manager.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Styles/theme_manager.dart';
import 'package:apprutas/Styles/theme_manager2.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    final navManager = context.watch<NavigationManager>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "App Rutas",
          style: TextStyle(fontSize: 24),
        ),
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
      bottomNavigationBar: navManager.currentPageIndexNavBar0 != -1 ? NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            navManager.setIndex(index);
          });
        },
        indicatorColor: COLOR_SENCONDARY,
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
      ) : null,
      drawer: Drawer(
        child: ListView (
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent
              ),
              child: Text("Opciones App Rutas", style: TextStyle(color: Colors.white),),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              selected: currentPageIndexDrawer == 0,
              title: const Text("Ajustes"),
              onTap: () {
                onTapDrawer(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.login_outlined),
              selected: currentPageIndexDrawer == 1,
              title: const Text("Cerrar sesión"),
              onTap: () {
                onTapDrawer(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.map_outlined,),
              title: const Text("Monitoreo"),
              onTap: () {
                onTapDrawer(-1);
                Navigator.pop(context);
              },
            ),
            SwitchListTile(
              title: Text("Modo oscuro"),
                value: darkMode2,
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

