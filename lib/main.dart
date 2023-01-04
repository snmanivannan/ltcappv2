import 'package:lotus_trading_company_sivakasi/app/app.router.dart';
import 'package:lotus_trading_company_sivakasi/app/locator.dart';
import 'package:lotus_trading_company_sivakasi/constants/asset_constants.dart';
import 'package:lotus_trading_company_sivakasi/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage(AssetConstants.splashScreenBackground), context);
    return MaterialApp(
      title: 'Lotus Trading Company',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: HomeView(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
