import 'package:flutter/material.dart';
import 'colors.dart';

class AppStrokes {
  // Stroke widths
  static const double thin = 1.0;    // Thin stroke
  static const double regular = 2.0;  // Regular stroke
  static const double thick = 3.0;    // Thick stroke

  // Border styles for easy use
  static final Border thinBorder = Border.all(
    color: AppColors.stroke1,
    width: thin,
  );

  static final Border regularBorder = Border.all(
    color: AppColors.stroke2,
    width: regular,
  );

  static final Border thickBorder = Border.all(
    color: AppColors.stroke3,
    width: thick,
  );

  // Directional borders
  static final Border thinBottom = Border(
    bottom: BorderSide(
      color: AppColors.stroke1,
      width: thin,
    ),
  );

  static final Border regularBottom = Border(
    bottom: BorderSide(
      color: AppColors.stroke2,
      width: regular,
    ),
  );

  static final Border thickBottom = Border(
    bottom: BorderSide(
      color: AppColors.stroke3,
      width: thick,
    ),
  );
} 