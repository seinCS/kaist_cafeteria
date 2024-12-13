import 'package:flutter/foundation.dart';

class Restaurant {
  final String restaurantId;
  final String name;
  final bool available;
  final int waitingTime;
  final int queueLength;
  final int emptySeats;
  final double congestionLevel;

  Restaurant({
    required this.restaurantId,
    required this.name,
    this.available = true,
    this.waitingTime = 0,
    this.queueLength = 0,
    this.emptySeats = 0,
    this.congestionLevel = 0.0,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      restaurantId: json['restaurantId'] ?? '',
      name: json['restaurantName'] ?? 'Unknown',
      available: json['available'] ?? true,
      waitingTime: json['waitingTime'] ?? 0,
      queueLength: json['queueLength'] ?? 0,
      emptySeats: json['emptySeats'] ?? 0,
      congestionLevel: (json['congestionLevel'] ?? 0.0).toDouble(),
    );
  }
}