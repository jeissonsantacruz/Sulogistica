//Flutter dependencies
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sulogistica/aplicacion/provider/providerUsuario_prrovider.dart';
import 'package:sulogistica/preferenciasdeusario.dart';


import 'aplicacion/paginas/loginUsuario_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  @override
  void initState() {
    //Config of push notification provider
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (context) => InformacionUsuario()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        navigatorKey: navigatorKey,
        routes: {
          'login': (context) => LoginPagina(),
        },
      )
    );
  }

  /*
    This function return the route to navigate
    after phone starts 
  */
  // _route<String>() {
  //   final userPreferences = new PreferenciasUsuario();
  //   // Routes Switch
  //   if (userPreferences.token != '') {
  //     var route = 'services';
  //     //Check in the server if has an order in progress
  //     userService.checkUserOrder()
  //       .then((response) {
  //         if (response['content'] == 1) {
  //           route = 'services';
  //           userPreferences.order = 0.toString();
  //         } else {
  //           route = 'orderProccess';
  //         }
  //       });
  //     return route;
  //   } else {
  //     return 'login';
  //   }
  // }

  /*
    This function checks if the current enviroment is development or production
    development : return true
    production : return false
  */
 
}