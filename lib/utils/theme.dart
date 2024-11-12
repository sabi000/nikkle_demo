import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nikkle/utils/colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: TColors.primary),
      textTheme: GoogleFonts.poppinsTextTheme().copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 36,
          fontWeight: FontWeight.w900,
          height: 36 / 32,
          letterSpacing: 6,
        ),
      ),
    );
  }
}
