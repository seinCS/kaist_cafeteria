import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/restaurant.dart';
import '../models/sensor.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String baseUrl = 'http://3.36.145.239:3000';

  Future<List<Restaurant>> getRestaurants() async {
    try {
      print('Fetching restaurants from: $baseUrl/user/restaurants');
      final response = await http.get(
        Uri.parse('$baseUrl/user/restaurants'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Restaurant.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load restaurants: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
      throw Exception('Failed to connect to server: $e');
    }
  }

  Future<Restaurant> getRestaurantStatus(String restaurantId, String restaurantName) async {
    try {
      print('Fetching status for restaurant: $restaurantId');
      final response = await http.get(
        Uri.parse('$baseUrl/user/restaurant-status?restaurant_id=$restaurantId'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      
      print('Status response: ${response.statusCode}');
      print('Status body: ${response.body}');
      
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json == null) {
          throw Exception('Empty response from server');
        }
        
        return Restaurant(
          restaurantId: restaurantId,
          name: restaurantName,
          waitingTime: json['waitingTime'] ?? 0,
          emptySeats: json['emptyCount'] ?? 0,
          queueLength: (json['waitingTime'] as int? ?? 0) ~/ 2,
          congestionLevel: _getCongestionLevel(json['congestion'] as String? ?? 'Low'),
        );
      } else {
        print('Server error: ${response.statusCode}');
        throw Exception('Failed to load restaurant status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getRestaurantStatus: $e');
      throw Exception('Failed to load restaurant status');
    }
  }

  // congestion 문자열을 숫자로 변환하는 헬퍼 메서드
  double _getCongestionLevel(String congestion) {
    switch (congestion.toLowerCase()) {
      case 'low':
        return 0.3;
      case 'medium':
        return 0.6;
      case 'high':
        return 0.9;
      default:
        return 0.0;
    }
  }
}