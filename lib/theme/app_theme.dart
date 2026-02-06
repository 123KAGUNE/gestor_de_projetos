import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_dimen.dart';
import '../core/constants/app_text_styles.dart';

ThemeData buildAppTheme({bool isDarkMode = false}) {
  if (isDarkMode) {
    return _buildDarkTheme();
  }
  return _buildLightTheme();
}

ThemeData _buildLightTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // Esquema de cores
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.danger,
    ),

    // Scaffold
    scaffoldBackgroundColor: AppColors.background,

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.grey900,
      elevation: 0,
      centerTitle: false,
      titleTextStyle:
          AppTextStyles.headingLarge.copyWith(color: AppColors.grey900),
      surfaceTintColor: Colors.transparent,
    ),

    // Cards
    cardTheme: CardThemeData(
      color: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusLg),
      ),
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.grey50,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimen.lg,
        vertical: AppDimen.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: AppColors.grey200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: AppColors.grey200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey600),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.grey400),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.xl,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium.copyWith(color: AppColors.white),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.lg,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.xl,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium,
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusXl),
      ),
    ),

    // Text Themes
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headingLarge,
      headlineMedium: AppTextStyles.headingMedium,
      headlineSmall: AppTextStyles.headingSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.grey200,
      thickness: 1,
      space: AppDimen.lg,
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.grey100,
      disabledColor: AppColors.grey200,
      selectedColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.md),
      labelStyle: AppTextStyles.bodySmall,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(
      color: AppColors.grey700,
      size: AppDimen.iconMd,
    ),
  );
}

//dark mode, divisao codigo

ThemeData _buildDarkTheme() {
  const darkBg = Color(0xFF0F0F0F); // Preto
  const midnightBlue = Color(0xFF1a237e); // Azul meia-noite
  const lightGrey = Color(0xFFE8E8E8); // Cinza claro
  const darkGrey = Color(0xFF424242); // Cinza para defaults

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Esquema de cores para dark mode
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.danger,
    ),

    // Scaffold - Fundo preto
    scaffoldBackgroundColor: darkBg,

    // AppBar - Preto
    appBarTheme: AppBarTheme(
      backgroundColor: darkBg,
      foregroundColor: lightGrey,
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: AppTextStyles.headingLarge.copyWith(color: lightGrey),
    ),

    // Cards - Azul meia-noite
    cardTheme: CardThemeData(
      color: midnightBlue,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusLg),
      ),
      surfaceTintColor: Colors.transparent,
      margin: EdgeInsets.zero,
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1A1A1A),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppDimen.lg,
        vertical: AppDimen.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: darkGrey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: darkGrey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      labelStyle: AppTextStyles.bodyMedium.copyWith(color: lightGrey),
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: darkGrey),
    ),

    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: lightGrey,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.xl,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium.copyWith(color: lightGrey),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.lg,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium.copyWith(color: lightGrey),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary, width: 1.5),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimen.xl,
          vertical: AppDimen.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.radiusMd),
        ),
        textStyle: AppTextStyles.headingMedium.copyWith(color: lightGrey),
      ),
    ),

    // FloatingActionButton
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: lightGrey,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusXl),
      ),
    ),

    // Text Themes - Cinza claro para destaque
    textTheme: TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(color: lightGrey),
      displayMedium: AppTextStyles.displayMedium.copyWith(color: lightGrey),
      displaySmall: AppTextStyles.displaySmall.copyWith(color: lightGrey),
      headlineLarge: AppTextStyles.headingLarge.copyWith(color: lightGrey),
      headlineMedium: AppTextStyles.headingMedium.copyWith(color: lightGrey),
      headlineSmall: AppTextStyles.headingSmall.copyWith(color: lightGrey),
      bodyLarge: AppTextStyles.bodyLarge.copyWith(color: lightGrey),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(color: lightGrey),
      bodySmall: AppTextStyles.bodySmall.copyWith(color: lightGrey),
      labelLarge: AppTextStyles.labelLarge.copyWith(color: lightGrey),
      labelMedium: AppTextStyles.labelMedium.copyWith(color: lightGrey),
      labelSmall: AppTextStyles.labelSmall.copyWith(color: lightGrey),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: darkGrey,
      thickness: 1,
      space: AppDimen.lg,
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: darkGrey,
      disabledColor: const Color(0xFF303030),
      selectedColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.md),
      labelStyle: AppTextStyles.bodySmall.copyWith(color: lightGrey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimen.radiusMd),
      ),
    ),

    // Icon Theme
    iconTheme: const IconThemeData(color: lightGrey, size: AppDimen.iconMd),

    // TabBar Theme - Azul meia-noite
    tabBarTheme: TabBarThemeData(
      indicatorColor: AppColors.primary,
      labelColor: lightGrey,
      unselectedLabelColor: darkGrey,
      labelStyle: AppTextStyles.labelMedium.copyWith(color: lightGrey),
      unselectedLabelStyle: AppTextStyles.labelMedium.copyWith(color: darkGrey),
    ),
  );
}
