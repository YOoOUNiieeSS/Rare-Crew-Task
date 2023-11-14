import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rare_crew_test/shared_resources/styles_manager.dart';

import 'color_manager.dart';

ThemeData getAppTheme() => ThemeData(
  useMaterial3: true,
      //main colors
      primaryColor: ColorManager.primary,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      primaryColorLight: ColorManager.lightPrimary,
      primaryColorDark: ColorManager.darkPrimary,
      disabledColor: ColorManager.disableColor,
      splashColor: Colors.transparent,
      //card view theme
      cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.defaultA200,
        elevation: 4,
      ),

      //app bar theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: ColorManager.appBarDark,
        elevation: 0,
        shadowColor: ColorManager.lightPrimary,
        titleTextStyle:
            getRegularStyle(color: ColorManager.primaryTextDark, fontSize: 16),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: ColorManager.appBarDark,
          statusBarIconBrightness: Brightness.light,
        )
      ),

      // button theme
      buttonTheme: ButtonThemeData(
        shape: const StadiumBorder(),
        disabledColor: ColorManager.defaultA100,
        buttonColor: ColorManager.primary,
        splashColor: ColorManager.lightPrimary,
      ),

      //elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle:
            getRegularStyle(color: ColorManager.primaryTextDark, fontSize: 17),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
      )),

      //text theme
      textTheme: TextTheme(
        displayLarge:
            getLightStyle(color: ColorManager.primaryTextDark, fontSize: 16),
        headlineLarge: getBoldStyle(
            color: ColorManager.primaryTextDark, fontSize: 16),
        headlineMedium: getRegularStyle(
            color: ColorManager.primaryTextDark, fontSize: 14),
        titleMedium: getMediumStyle(
            color: ColorManager.primaryTextDark, fontSize: 16),
        bodyLarge: getRegularStyle(color: ColorManager.primaryTextDark),
        bodySmall: getRegularStyle(color: ColorManager.primaryTextDark),
      ),
      // input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(8),
        hintStyle:
            getRegularStyle(color: ColorManager.secondaryTextDark, fontSize: 14),
        labelStyle:
            getMediumStyle(color: ColorManager.secondaryTextDark, fontSize: 14),
        errorStyle: getRegularStyle(color: ColorManager.error),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.secondaryTextDark, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        fillColor: ColorManager.color18,
          filled: true,
      ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        TextStyle(
          fontSize: 10, // Customize font size
          color: ColorManager.primaryTextDark, // Customize text color
        ),
      ),
    ),
  ),
    );
