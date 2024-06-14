part of 'navigation_screen.dart';

int currentPageIndexDrawer = -1;
int currentPageIndexNavBar = 0;

ThemeManager thmManager = ThemeManager();


List<Widget> widgetOptionsDawer = [
  Center(
    child: Text("Ajustes"),
  ),
  Center(
    child: Text("Cerrar sesión"),
  ),
  NavigationScreen()
];

List<Widget> widgetOptionsNavBar = [
  ListviewScreen(),
  MapScreen(),
  Center(
    child: Text("Alertas screen"),
  )
];



