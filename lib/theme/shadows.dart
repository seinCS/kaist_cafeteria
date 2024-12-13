import 'package:flutter/material.dart';

class AppShadows {
  // Small shadow
  static final small = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.05),
    offset: const Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  // Medium shadow
  static final medium = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.15),
    offset: const Offset(0, 1),
    blurRadius: 4,
    spreadRadius: 0,
  );

  // Large shadow
  static final large = BoxShadow(
    color: const Color(0xFF000000).withOpacity(0.25),
    offset: const Offset(0, 1),
    blurRadius: 8,
    spreadRadius: 0,
  );

  // Lists for multiple shadows
  static final List<BoxShadow> smallElevation = [small];
  static final List<BoxShadow> mediumElevation = [medium];
  static final List<BoxShadow> largeElevation = [large];
} 