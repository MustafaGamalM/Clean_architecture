import 'package:flutter/material.dart';
import 'package:shop_app/app/app_prefs.dart';
import 'package:shop_app/app/di.dart';
import 'package:shop_app/presentation/resources/routes_manager.dart';

import '../presentation/resources/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocal().then((local) => {context.setLocale(local)});
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
}
