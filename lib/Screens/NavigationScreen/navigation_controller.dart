part of 'navigation_screen.dart';

int currentPageIndexDrawer = -1;
int currentPageIndexNavBar = 0;
final ValueNotifier<String> appBar = ValueNotifier("RoadControl");

ThemeManager thmManager = ThemeManager();
ThemeManager2 thmManager2 = ThemeManager2();
TextTheme txtTheme = Theme.of(GlobalContext.navKey.currentContext!).textTheme;
bool isDark = Theme.of(GlobalContext.navKey.currentContext!).brightness == Brightness.dark;

List<Widget> widgetOptionsDawer = [
  //ListviewScreen(),
  AjustesScreen(),
  Center(
    child: Text("Cerrar sesión"),
  ),
  NavigationScreen(),
];

List<Widget> widgetOptionsNavBar = [
  ListviewScreen(),
  MapScreen(),
  //ListviewScreen(),
  //MapScreen(),
  AlertsScreen()
];


Future<void> _loadUserName() async {
  String username = await SessionManager().getString("username");
  NavigationManager().setUserName(username);
}

Future<void> saveThemeMode(bool isDarkMode) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isDarkMode', isDarkMode);
}

Future<bool> getSavedThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isDarkMode') ?? false; // false por defecto si no está guardado
}





