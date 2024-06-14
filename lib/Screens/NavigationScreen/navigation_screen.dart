
import 'dart:core';

import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Styles/theme_manager.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Rutas"),
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
      bottomNavigationBar: currentPageIndexNavBar != -1 ? NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndexNavBar = index;
          });
        },
        indicatorColor: Colors.deepPurple[300],
        selectedIndex: currentPageIndexNavBar,
        destinations: const <Widget>[
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
              leading: Icon(Icons.map_outlined),
              title: const Text("Monitoreo"),
              onTap: () {
                onTapDrawer(-1);
                Navigator.pop(context);
              },
            ),
            SwitchListTile(
              title: Text("Modo oscuro"),
                value: thmManager.myThMode == ThemeMode.dark,
                onChanged: (newValue) {
                  thmManager.toggleMode(newValue);
                }
            )
          ],
        ),
      ),
      body: Container(
        child: currentPageIndexDrawer >= 0
            ? widgetOptionsDawer[currentPageIndexDrawer] : widgetOptionsNavBar[currentPageIndexNavBar],
      ),
    );
  }
}

