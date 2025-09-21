import 'package:flutter/material.dart';
import 'colors/colors.dart';
import 'fonts/fonts.dart';

final ThemeData appThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColor.primary,
  secondaryHeaderColor: AppColor.secondary,
  scaffoldBackgroundColor: AppColor.background,
  useMaterial3: true,
  fontFamily: AppFont.Manrope,
  colorScheme: ColorScheme.light(
    primary: AppColor.background, // Cor principal
    onPrimary: AppColor.primary, // Cor para texto e ícones no botão principal
    secondary: AppColor.secondary, // Cor secundária
    onSecondary: AppColor.secondary, // Cor para o texto no fundo
    surface: AppColor.background, // Cor para superfícies como cards
    onSurface: AppColor.dark, // Cor do texto na superfície
    error: AppColor.red, // Cor de erro
    onError: AppColor.light, // Cor do texto de erro
  ),
  dividerColor: AppColor.medium,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 72.0,
      fontFamily: AppFont.Manrope,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 36.0,
      fontFamily: AppFont.Manrope,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: AppFont.Manrope),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColor.primary),
  // -> Tema do checkbox
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return AppColor.secondary;
      } else {
        return Colors.black;
      }
    }),
  ),
);
