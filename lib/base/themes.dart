import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color/colours.dart';

class Themes {
  static ThemeData appTheme = ThemeData(
      scaffoldBackgroundColor: Colours.baseBlack,
      splashColor: Colours.blueViolet,
      highlightColor: Colours.lavender,
      primaryColor: Colours.baseBlack,
      textTheme: TextTheme(
          headlineLarge: GoogleFonts.kanit(
              color: Colours.white, fontSize: 60, fontWeight: FontWeight.w900),
          headlineMedium: GoogleFonts.kanit(
              color: Colours.lavender, fontSize: 30, fontWeight: FontWeight.w900),
          displayLarge: GoogleFonts.kanit(
              color: Colours.white, fontSize: 24, fontWeight: FontWeight.bold),
          displayMedium: GoogleFonts.kanit(
              color: Colours.white, fontSize: 20, fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.kanit(
              color: Colours.white, fontSize: 16, fontWeight: FontWeight.normal),
          bodyMedium: GoogleFonts.kanit(
              color: Colours.white,
              fontSize: 12,
              fontWeight: FontWeight.normal)));
}
