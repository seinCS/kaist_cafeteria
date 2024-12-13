import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static const String fontFamily = 'Roboto';

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    height: 1.5,  // 48pt line height / 32pt font size
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 1.33,  // 32pt line height / 24pt font size
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 1.5,  // 30pt line height / 20pt font size
    fontWeight: FontWeight.w700,
    color: AppColors.textTitle,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    height: 1.56,  // 28pt line height / 18pt font size
    fontWeight: FontWeight.w600,
    color: AppColors.textTitle,
  );

  // Body styles
  static const TextStyle bodyBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43,  // 20pt line height / 14pt font size
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  static const TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.43,  // 20pt line height / 14pt font size
    fontWeight: FontWeight.w400,
    color: AppColors.textBody,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.33,  // 16pt line height / 12pt font size
    fontWeight: FontWeight.w400,
    color: AppColors.textCaption,
  );
} 