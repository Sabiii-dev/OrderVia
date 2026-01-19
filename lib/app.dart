import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordervia/features/home/home_page.dart';

class OrderviaApp extends StatelessWidget {
  const OrderviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    const brandNavy = Color(0xFF0B1220);

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: brandNavy,
        brightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'OrderVia',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: brandNavy,
          foregroundColor: Colors.white,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
      ),
      home: const HomePage(),
    );
  }
}
