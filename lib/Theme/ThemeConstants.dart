import 'package:flutter/material.dart';

ThemeData LightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: Colors.green,
    onPrimary: Colors.black,
    secondary: Colors.white, 
    onSecondary: Colors.white, 
    tertiary: Colors.blue,
    onTertiary: Colors.white,
    primaryContainer: Colors.white
  )
);

ThemeData DarkMode = ThemeData(
  
  colorScheme: const ColorScheme.dark(
    primary: Colors.grey,
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 35, 139, 148),
    onSecondary: Colors.black,
    tertiary: Colors.black,
    onTertiary: Colors.grey,
    primaryContainer: Color.fromARGB(255, 56, 56, 56)
  ),
  
);


