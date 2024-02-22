import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsTheme {
  ThemeData theme() {
    return ThemeData(
      textTheme: GoogleFonts.workSansTextTheme(),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      useMaterial3: true,
    );
  }

  AppBarTheme appBarTheme() {
    return const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }
}
