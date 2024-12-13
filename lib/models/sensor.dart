import 'package:flutter/foundation.dart';

class Sensor {
  final String sensorId;
  final String restaurantId;
  final String sensorType;
  final bool available;

  Sensor({
    required this.sensorId,
    required this.restaurantId,
    required this.sensorType,
    this.available = true,
  });

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(
      sensorId: json['sensorId'],
      restaurantId: json['restaurantId'],
      sensorType: json['sensorType'],
      available: json['available'] ?? true,
    );
  }
}