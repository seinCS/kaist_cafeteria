import 'package:flutter/material.dart';
import 'colors.dart';
import 'radius.dart';
import 'shadows.dart';
import 'strokes.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background1,
      fontFamily: AppTypography.fontFamily,
      
      // Text Theme
      textTheme: const TextTheme(
        // Headings
        displayLarge: AppTypography.h1,
        displayMedium: AppTypography.h2,
        displaySmall: AppTypography.h3,
        headlineMedium: AppTypography.h4,
        
        // Body
        bodyLarge: AppTypography.bodyBold,
        bodyMedium: AppTypography.bodyRegular,
        
        // Caption
        labelSmall: AppTypography.caption,
      ),
      
      // Divider Theme
      dividerTheme: DividerThemeData(
        color: AppColors.stroke1,
        thickness: AppStrokes.thin,
        space: 1,
      ),
      
      // Card Theme with Shadow
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.mediumAll,
        ),
        elevation: 0, // We'll handle shadows manually
      ),
      
      // Elevated Button Theme with Shadow
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.mediumAll,
          ),
          elevation: 0, // We'll handle shadows manually
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: AppRadius.smallAll,
          borderSide: BorderSide(
            color: AppColors.stroke2,
            width: AppStrokes.regular,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.smallAll,
          borderSide: BorderSide(
            color: AppColors.stroke1,
            width: AppStrokes.thin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.smallAll,
          borderSide: BorderSide(
            color: AppColors.primary,
            width: AppStrokes.regular,
          ),
        ),
      ),
    );
  }
} 