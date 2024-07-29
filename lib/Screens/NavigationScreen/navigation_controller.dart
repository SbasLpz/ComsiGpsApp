part of 'navigation_screen.dart';

int currentPageIndexDrawer = -1;
int currentPageIndexNavBar = 0;

ThemeManager thmManager = ThemeManager();
ThemeManager2 thmManager2 = ThemeManager2();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
bool isDark = Theme.of(GlobalContext.navKey.currentContext!).brightness == Brightness.dark;

List<Widget> widgetOptionsDawer = [
  Center(
    child: Text("Ajustes"),
  ),
  Center(
    child: Text("Cerrar sesión"),
  ),
  NavigationScreen(),
];

List<Widget> widgetOptionsNavBar = [
  ListviewScreen(),
  MapScreen(),
  AlertsScreen()
];



