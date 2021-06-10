import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData defaultThemeData = ThemeData(
  backgroundColor: Color(0xfffafafa),
  primaryColor: Color(0xffe8f1f5),
  accentColor: Color(0xff005691),
  shadowColor: Colors.black12.withOpacity(0.25),
  hoverColor: Color(0xff004a7c),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
  ),
  textTheme: GoogleFonts.rubikTextTheme(),
);

Size getSize(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Size(size.width / 100, size.width / 100);
}
