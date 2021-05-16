import 'package:flutter/material.dart';
import 'package:flutter_catalog/core/store.dart';
import 'package:flutter_catalog/pages/cart_page.dart';
import 'package:flutter_catalog/pages/home_details_page.dart';
import 'package:flutter_catalog/pages/login_page.dart';
import 'package:flutter_catalog/utils/routes.dart';
import 'package:flutter_catalog/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'pages/home_page.dart';

import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(VxState(store: MyStore(), child: MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({key: key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // home: HomePage(),
      themeMode: ThemeMode.system,
      theme: MyTheme.lightThemeData(context),
      darkTheme: MyTheme.darkThemeData(context),
      routeInformationParser: VxInformationParser(),
      routerDelegate: VxNavigator(
        routes: {
          "/": (_, __) => MaterialPage(child: LoginPage()),
          MyRoutes.homeRoute: (_, __) => MaterialPage(child: HomePage()),
          MyRoutes.homeDetailsRoute: (uri, _) {
            final catalog = (VxState.store as MyStore)
                .catalog!
                .getById(int.parse(uri.queryParameters["id"]!));
            return MaterialPage(
              child: HomeDetailsPage(
                catalog: catalog,
              ),
            );
          },
          MyRoutes.loginRoute: (_, __) => MaterialPage(child: LoginPage()),
          MyRoutes.cartRoute: (_, __) => MaterialPage(child: CartPage())
        },
      ),
      // initialRoute: MyRoutes.homeRoute,
      // routes: {
      //   "/": (context) => LoginPage(),
      //   MyRoutes.homeRoute: (context) => HomePage(),
      //   MyRoutes.loginRoute: (context) => LoginPage(),
      //   MyRoutes.cartRoute: (context) => CartPage()
      // },
    );
  }
}
