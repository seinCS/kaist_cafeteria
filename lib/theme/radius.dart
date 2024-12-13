import 'package:flutter/material.dart';

class AppRadius {
  // Corner radius values
  static const double small = 2.0;    // Small radius
  static const double medium = 4.0;   // Medium radius
  static const double large = 8.0;    // Large radius
  static const double extraLarge = 16.0;  // Extra-Large radius
  static const double round = 999.0;  // Round (pill shape)

  // BorderRadius objects for easy use
  static final BorderRadius smallAll = BorderRadius.circular(small);
  static final BorderRadius mediumAll = BorderRadius.circular(medium);
  static final BorderRadius largeAll = BorderRadius.circular(large);
  static final BorderRadius extraLargeAll = BorderRadius.circular(extraLarge);
  static final BorderRadius roundAll = BorderRadius.circular(round);

  // Top only radius
  static final BorderRadius smallTop = BorderRadius.only(
    topLeft: Radius.circular(small),
    topRight: Radius.circular(small),
  );
  static final BorderRadius mediumTop = BorderRadius.only(
    topLeft: Radius.circular(medium),
    topRight: Radius.circular(medium),
  );
  static final BorderRadius largeTop = BorderRadius.only(
    topLeft: Radius.circular(large),
    topRight: Radius.circular(large),
  );
  static final BorderRadius extraLargeTop = BorderRadius.only(
    topLeft: Radius.circular(extraLarge),
    topRight: Radius.circular(extraLarge),
  );
} 