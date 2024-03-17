import 'package:flutter/material.dart';

import '../../core/config/constants.dart';
import '../colors/colors.dart';
import '../styles/app_text_style.dart';

extension on ThemeData {
  ThemeData setCommonThemeElements() => copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: colorScheme.copyWith(secondary: AppColors.red),
      );
}

ThemeData lightTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primaryL,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
          color: AppColors.black,
        ),
      ),
      // radio button
      unselectedWidgetColor: AppColors.gray,
      tabBarTheme: const TabBarTheme(
        unselectedLabelColor: AppColors.textAppGray,
        labelColor: AppColors.textBlack,
      ),
      // textSelectionTheme
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.primaryL,
        selectionColor: AppColors.primaryL,
        selectionHandleColor: AppColors.primaryL,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        labelLarge: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
        titleMedium: TextStyle(color: AppColors.black),
        titleSmall: TextStyle(color: AppColors.black),
        displayLarge: TextStyle(
          fontSize: 40,
          color: AppColors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 20,
          color: AppColors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 16,
          color: AppColors.white,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        errorMaxLines: 2,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Constants.padding15,
          vertical: Constants.padding10,
        ),
        hoverColor: AppColors.primaryD,
        focusColor: AppColors.primaryD,
        hintStyle: AppTextStyle.textStyleEditTextLabelRegularGray,
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textAppGray.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primaryL,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: AppTextStyle.textStyleEditTextLabelRegularGray,
        floatingLabelStyle: AppTextStyle.floatingLabelStyle,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.accentL,
          minimumSize: const Size(100, 45),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white, minimumSize: const Size(100, 45),
          // padding: EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
      ),
      // radioTheme: RadioThemeData(
      //   fillColor:
      //       MaterialStateColor.resolveWith((states) => AppColors.textAppGray),
      // ),
      timePickerTheme: const TimePickerThemeData(
        hourMinuteTextColor: AppColors.secondaryL,
        // hourMinuteColor: AppColors.primaryL,
        dayPeriodTextColor: AppColors.secondaryL,
        // dayPeriodColor: AppColors.primaryL,
        dialHandColor: AppColors.secondaryL,
        // dialBackgroundColor: AppColors.primaryL,
        // dialTextColor: AppColors.secondaryL,
        entryModeIconColor: AppColors.secondaryL,
        hourMinuteTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
        ),
        helpTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: AppColors.secondaryL,
        ),
        dayPeriodTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontFamily: 'Poppins',
          color: AppColors.secondaryL,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryL,
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor:
            MaterialStateColor.resolveWith((states) => AppColors.textAppGray),
      ).copyWith(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentL;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentL;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentL;
          }
          return null;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.accentL;
          }
          return null;
        }),
      ),
      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     primary: AppColors.accentL,
      //   ),
      // ),
      // textTheme: TextTheme(
      //   subtitle1: TextStyle(
      //     fontWeight: FontWeight.bold,
      //     color: AppColors.textGray,
      //   ),
      // ),
    ).setCommonThemeElements();

ThemeData darkTheme() => ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryD,
      scaffoldBackgroundColor: AppColors.white,
      cardColor: AppColors.primaryDisabledD,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.black,
          backgroundColor: AppColors.accentD,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.secondaryL,
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    ).setCommonThemeElements();
