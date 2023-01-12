import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final customTheme = AppTheme.light();

// InputDecoration customInputDecoration(label, errorText) => InputDecoration(
//       filled: true,
//       label: Text(label),
//       errorText: errorText,
//       fillColor: const Color.fromARGB(255, 239, 237, 243),
//       enabledBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide.none),
//       focusedBorder: const OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           borderSide: BorderSide(color: CustomColors.blue, width: 2)),
//     );

class AppTheme {

  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    
    headline2: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headline3: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 16,
    ),
    bodyText2: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 14,
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
    headline2: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headline3: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyText1: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 16,
    ),
    bodyText2: GoogleFonts.bitter(
      color: Colors.black,
      fontSize: 14,
    ),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.white,
      ),
      textTheme: lightTextTheme,
    );
  }

// 4
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
