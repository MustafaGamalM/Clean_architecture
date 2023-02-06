import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/forget_password/view/forget_password_view.dart';
import 'package:shop_app/presentation/login/view/login_view.dart';
import 'package:shop_app/presentation/main/main_veiw.dart';
import 'package:shop_app/presentation/onboarding/view/onboarding_view.dart';
import 'package:shop_app/presentation/register/view/register_view.dart';
import 'package:shop_app/presentation/resources/strings_manager.dart';
import 'package:shop_app/presentation/splash/splash_view.dart';
import 'package:shop_app/presentation/store_details/view/store_details_view.dart';

import '../../app/di.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.forgetPasswordRoute:
        initForgetPasswordModule();
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());

      case Routes.mainRoute:
        initHomeModule();
        return MaterialPageRoute(builder: (_) => const MainView());

      case Routes.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title:  Text(AppStrings.noRouteFound.tr()),
              ),
              body:  Center(
                child: Text(AppStrings.noRouteFound.tr()),
              ),
            ));
  }
}
