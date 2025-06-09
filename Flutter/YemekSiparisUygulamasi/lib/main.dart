import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/ErrorModel.dart';
import 'package:shop_app/models/state/AccountState.dart';
import 'package:shop_app/models/state/CartState.dart';
import 'package:shop_app/models/state/FavoriteState.dart';
import 'package:shop_app/models/state/OrderDetailsState.dart';
import 'package:shop_app/models/state/OrderState.dart';
import 'package:shop_app/models/state/ProdactState.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';

import 'routes.dart';
import 'theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductState(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartState(),
        ),
        ChangeNotifierProvider(
          create: (context) => Errors(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderState(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderDetailState(),
        ),
        ChangeNotifierProvider(
          create: (context) => FavoriteState(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Flutter Way - Template',
        theme: AppTheme.lightTheme(context),
        initialRoute: SignInScreen.routeName,
        routes: routes,
      ),
    );
  }
}
