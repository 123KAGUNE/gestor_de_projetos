import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary colors
  static const Color primary = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color primaryLight = Color(0xFFDBEAFE);

  // Secondary colors
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFFD1FAE5);

  // Neutral colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color grey50 = Color(0xFFF9FAFB);
  static const Color grey100 = Color(0xFFF3F4F6);
  static const Color grey200 = Color(0xFFE5E7EB);
  static const Color grey300 = Color(0xFFD1D5DB);
  static const Color grey400 = Color(0xFF9CA3AF);
  static const Color grey500 = Color(0xFF6B7280);
  static const Color grey600 = Color(0xFF4B5563);
  static const Color grey700 = Color(0xFF374151);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF111827);

  // Semantic colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4646);
  static const Color info = Color(0xFF06B6D4);

  // Background colors
  static const Color background = Color(0xFFF6F8FB);
  static const Color surfaceVariant = Color(0xFFEFF3FA);

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient gradientBackground = LinearGradient(
    colors: [Color(0xFFF6F8FB), Color(0xFFEFF3FA)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

