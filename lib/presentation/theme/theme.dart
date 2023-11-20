import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:laza/common/extensions/context_extension.dart';

import '../../common/colors.dart';



class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primary, surfaceTint: Colors.white),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
      ),
    ),
    dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
    listTileTheme: ListTileThemeData(
      titleTextStyle: bodyMedium.copyWith(fontWeight: FontWeight.normal),
    ),
    // card color is used here to for icon button bg color
    cardColor: const Color(0xffF5F6FA),
  );

  // ==========================================================================================

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: ColorConstant.primary),
    useMaterial3: true,
    scaffoldBackgroundColor: ColorConstant.scaffoldDark,
    textTheme: GoogleFonts.interTextTheme().copyWith(
      headlineLarge: headlineLarge.dark(),
      headlineMedium: headlineMedium.dark(),
      headlineSmall: headlineSmall.dark(),
      bodyLarge: bodyLarge.dark(),
      bodyMedium: bodyMedium.dark(),
      bodySmall: bodySmall.dark(),
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.transparent,
      backgroundColor: ColorConstant.scaffoldDark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: ColorConstant.scaffoldDark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xff29363D),
    ),
    dialogTheme: const DialogTheme(surfaceTintColor: Colors.white, backgroundColor: Colors.white),
    listTileTheme: ListTileThemeData(
      titleTextStyle: bodyMedium.dark().copyWith(fontWeight: FontWeight.normal),
      iconColor: Colors.white,
    ),
    // card color is used here to for icon button bg color
    cardColor: const Color(0xff222E34),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  // ========================================================================================== //

  // Headline 1
  // 34px Bold
  static const headlineLarge = TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.black);

  // Headline 2
  // 28px Semi-bold
  static const headlineMedium = TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black);
  // Headline 3
  // 22px Medium
  static const headlineSmall = TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.black);

  // Body 1
  // 17px Medium
  static const bodyLarge = TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.black);

  // Body 2
  // 15px Medium
  static const bodyMedium = TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black);

  // Body 3
  // 13px Medium
  static const bodySmall = TextStyle(fontSize: 13, fontWeight: FontWeight.normal, color: Colors.black);
}
