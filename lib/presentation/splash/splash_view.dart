import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/routes_manager.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../resources/constants_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences=instance<AppPreferences>();
  void _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.timerDelay), _goNext);
  }

  _goNext() {
    _appPreferences.getLoggedIn().then((isLogged) {
      if(isLogged){
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      }else{
        _appPreferences.getOnBoardingViewed().then((onBoardingViewed) {
          if(onBoardingViewed) {
            Navigator.popAndPushNamed(context, Routes.loginRoute);
          } else {
            Navigator.popAndPushNamed(context, Routes.onBoardingRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body:
          const Center(child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }
}
