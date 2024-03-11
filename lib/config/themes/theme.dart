import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTheme {
  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
      ),
      textTheme: GoogleFonts.workSansTextTheme(),
    );
  }

  ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        color: Colors.black,
        elevation: 0,
      ),
      textTheme: GoogleFonts.workSansTextTheme().apply(
        bodyColor: Colors.white,
      ),
    );
  }
}
