import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData theme() {
    return ThemeData(
      fontFamily: 'Poppins',
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: Colors.white),
      colorScheme: const ColorScheme(
        background: Colors.transparent,
        brightness: Brightness.dark,
        error: Colors.red,
        onBackground: Colors.white,
        onError: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        primary: Color.fromRGBO(255, 147, 30, 1.0),
        secondary: Color.fromRGBO(20, 42, 77, 1.0),
        surface: Colors.transparent,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: const Color.fromRGBO(82, 84, 87, 0.98),
        dialBackgroundColor: const Color.fromRGBO(82, 84, 87, 0.98),
        
      ),
      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        constraints: const BoxConstraints(maxHeight: 48, minHeight: 48),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.transparent,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: const TextStyle(
          fontFamily: 'Poppins',
          decoration: TextDecoration.none,
          fontSize: 17.0,
          fontWeight: FontWeight.normal,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll<TextStyle>(
            TextStyle(
              color: Color.fromARGB(255, 255, 147, 30),
              fontFamily: 'Poppins',
              fontSize: 15,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(
            Color.fromARGB(255, 255, 147, 30),
          ),
          foregroundColor: const MaterialStatePropertyAll(Colors.white),
          textStyle: const MaterialStatePropertyAll(
            TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
          //fixedSize: const MaterialStatePropertyAll(Size(325, 46)),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
          ),
          side: const MaterialStatePropertyAll(BorderSide.none),
        ),
      ),
    );
  }
}
