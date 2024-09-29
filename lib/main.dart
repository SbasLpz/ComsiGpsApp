import 'dart:ui';

import 'package:apprutas/Models/unidad_model.dart';
import 'package:apprutas/Screens/AlertsScreen/alerts_manager.dart';
import 'package:apprutas/Screens/CommandScreen/command_manager.dart';
import 'package:apprutas/Screens/CommandScreen/command_screen.dart';
import 'package:apprutas/Screens/HistorialScreen/validator_manager.dart';
import 'package:apprutas/Screens/InicioSesionScreen/inicio_sesion2_screen.dart';
import 'package:apprutas/Screens/InicioSesionScreen/inicio_sesion_screen.dart';
import 'package:apprutas/Screens/ListViewScreen/last_report_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_manager2.dart';
import 'package:apprutas/Screens/ListViewScreen/listview_screen.dart';
import 'package:apprutas/Screens/LogInScreen/login_screen.dart';
import 'package:apprutas/Screens/LogInScreen/login_screen_widget.dart';
import 'package:apprutas/Screens/MapScreen/map_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_manager.dart';
import 'package:apprutas/Screens/NavigationScreen/navigation_screen.dart';
import 'package:apprutas/Screens/MapScreen/map_screen.dart';
import 'package:apprutas/Screens/home_screen.dart';
import 'package:apprutas/Services/road_api.dart';
import 'package:apprutas/Styles/theme.dart';
import 'package:apprutas/Styles/theme_manager2.dart';
import 'package:apprutas/Utils/global_context.dart';
import 'package:apprutas/Widgets/foto_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart' as provider;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:session_manager/session_manager.dart';
import 'package:upgrader/upgrader.dart';

import 'Styles/theme_manager.dart';

/** VARIABLES DE SESION **/
/**
 * tokenUser (String)
 * **/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await thmManager2.loadThemeMode();
  //WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // FlutterError.onError = (errorDetails) {
  //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  // };
  // PlatformDispatcher.instance.onError = (error, stack){
  //   FirebaseCrashlytics.instance.recordError(error, stack);
  //   return true;
  // };

  runApp(
    riverpod.ProviderScope(
        child: MyApp()
    )
  );
}

ThemeManager thmManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  themeListener() {
    if(mounted){
      print("I'm Mouted, whatever it means");
      setState(() {

      });
    }
  }
  @override
  void dispose() {
    print("Listener removed");
    thmManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    thmManager.addListener(themeListener);
    print("Listener added");
    initialization();
    super.initState();
  }

  void initialization() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    // ignore_for_file: avoid_print
    //comandos = await getCommands();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    SessionManager.sessionManager.setString("version", packageInfo.version);
    GlobalContext.version = "v-"+packageInfo.version;
    print("VERSION : ${packageInfo.version}");
    print('ready in 3...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 2...');
    await Future.delayed(const Duration(seconds: 1));
    print('ready in 1...');
    await Future.delayed(const Duration(seconds: 1));
    print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
            create: (context) => ListviewManager2(),
        ),
        provider.ChangeNotifierProvider(
            create: (context) => ListviewManager()
        ),
        provider.ChangeNotifierProvider(
            create: (context) => AlertsManager()
        ),
        provider.ChangeNotifierProvider(
          create: (context) => MapManager(),
        ),
        provider.ChangeNotifierProvider(
          create: (context) => ValidatorManager(),
        ),
        provider.ChangeNotifierProvider(
          create: (context) => ThemeManager2(),
        ),
        provider.ChangeNotifierProvider(
          create: (context) => LastReportManager(),
        ),
        provider.ChangeNotifierProvider(
          create: (context) => CommandManager(),
        ),
        provider.ChangeNotifierProvider(
          create: (context) => NavigationManager(),
        )
      ],
      // child: MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   navigatorKey: GlobalContext.navKey,
      //   theme: lightMyAppTheme,
      //   darkTheme: darkMyAppTheme,
      //   themeMode: thmManager.thMode,
      //   home: InicioSesionScreen(),
      // ),


      child: provider.Consumer<ThemeManager2>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: GlobalContext.navKey,
            //themeMode: ThemeMode.light,
            themeMode: thmManager2.isDarkMode ? ThemeMode.dark : ThemeMode.light,

            theme: themeProvider.attrs.mycolors,
            darkTheme: DarkThemeAttrs().mycolors,
            home: UpgradeAlert(
              child: InicioSesion2Screen(),
            ),
          );
        },
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
