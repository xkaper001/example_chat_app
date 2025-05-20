import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Main colors based on the provided image
  static const Color OutLineColor = Color(0xFFA6E9DB);
  static const Color otherChatBubbleFill = Color(0xFFFDD991);
  static const Color userChatBubbleFill = Color(0xFFFCC85F);
  static const Color userChatAvatarOutline = Color(0xFF439F99);

  static const Color backgroundColor = Color(0xFFFEF3DC);

  static const Color darkAmber = Color(0xFFFBB428);
  static const Color mintGreen = Color(0xFF2A9D8F);
  static const Color peachOrange = Color(0xFFF9B384);
  static const Color darkGrey = Color(0xFF303030);
  static const Color lightGrey = Color(0xFFEAEAEA);

  // Message bubble styles
  static BoxDecoration messageBubbleDecoration(
      {required bool isCurrentUser, required BuildContext context}) {
    return BoxDecoration(
      color: isCurrentUser ? mintGreen : peachOrange.withOpacity(0.2),
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20.0),
        topRight: const Radius.circular(20.0),
        bottomLeft: isCurrentUser
            ? const Radius.circular(20.0)
            : const Radius.circular(4.0),
        bottomRight: isCurrentUser
            ? const Radius.circular(4.0)
            : const Radius.circular(20.0),
      ),
    );
  }

  // Message text style
  static TextStyle messageTextStyle({required bool isCurrentUser}) {
    return TextStyle(
      color: darkGrey,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
    );
  }

  // App bar style
  static AppBarTheme appBarTheme() {
    return AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: darkGrey),
      titleTextStyle: GoogleFonts.playfairDisplay(
        color: darkGrey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Overall theme
  static ThemeData themeData() {
    // Get the Playfair font from Google Fonts
    final TextTheme playfairTextTheme = GoogleFonts.playfairDisplayTextTheme(
      const TextTheme(
        displayLarge: TextStyle(color: darkGrey),
        displayMedium: TextStyle(color: darkGrey),
        displaySmall: TextStyle(color: darkGrey),
        headlineLarge: TextStyle(color: darkGrey),
        headlineMedium: TextStyle(color: darkGrey),
        headlineSmall: TextStyle(color: darkGrey),
        titleLarge: TextStyle(color: darkGrey),
        titleMedium: TextStyle(color: darkGrey),
        titleSmall: TextStyle(color: darkGrey),
        bodyLarge: TextStyle(color: darkGrey),
        bodyMedium: TextStyle(color: darkGrey),
        bodySmall: TextStyle(color: Colors.grey),
        labelLarge: TextStyle(color: darkGrey),
        labelMedium: TextStyle(color: darkGrey),
        labelSmall: TextStyle(color: darkGrey),
      ),
    );

    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: mintGreen,
        secondary: peachOrange,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: appBarTheme(),
      useMaterial3: true,
      fontFamily: GoogleFonts.playfairDisplay().fontFamily,
      textTheme: playfairTextTheme,
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
      ),
    );
  }
}
