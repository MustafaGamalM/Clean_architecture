import 'package:flutter/material.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/resources/styles_manager.dart';
import 'package:shop_app/presentation/resources/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),
    appBarTheme: AppBarTheme(
      color: ColorManager.primary,
      centerTitle: true,
      elevation: AppSize.s4,
      titleTextStyle:
          getRegularText(color: ColorManager.white, fontSize: AppSize.s16),
      shadowColor: ColorManager.lightPrimary,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorManager.primary,
      shape: const StadiumBorder(),
      splashColor: ColorManager.lightPrimary,
      disabledColor: ColorManager.grey1,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            primary: ColorManager.primary,
            textStyle: getRegularText(
                color: ColorManager.white, fontSize: AppSize.s17),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12)))),
    textTheme: TextTheme(
      displayLarge:
          getSemiBoldText(color: ColorManager.darkGrey, fontSize: AppSize.s16),
      headlineLarge:
          getSemiBoldText(color: ColorManager.darkGrey, fontSize: AppSize.s16),
      headlineMedium:
          getRegularText(color: ColorManager.darkGrey, fontSize: AppSize.s16),
      titleMedium:
          getMediumText(color: ColorManager.primary, fontSize: AppSize.s14),
      titleSmall:
          getRegularText(color: ColorManager.white, fontSize: AppSize.s16),
      labelSmall:
          getRegularText(color: ColorManager.primary, fontSize: AppSize.s12),
      bodyMedium: getRegularText(color: ColorManager.grey2, fontSize: AppSize.s12),
      bodyLarge: getRegularText(color: ColorManager.grey1),
      bodySmall: getRegularText(color: ColorManager.grey),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle:
          getRegularText(color: ColorManager.grey, fontSize: AppSize.s14),
      labelStyle:
          getMediumText(color: ColorManager.grey, fontSize: AppSize.s14),
      errorStyle: getRegularText(color: ColorManager.error),
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide: BorderSide(width: AppSize.s1, color: ColorManager.grey)),
      focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(width: AppSize.s1, color: ColorManager.primary)),
      errorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide: BorderSide(width: AppSize.s1, color: ColorManager.error)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
          borderSide:
              BorderSide(width: AppSize.s1, color: ColorManager.primary)),
    ),
  );
}
