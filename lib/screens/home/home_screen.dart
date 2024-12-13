import 'package:flutter/material.dart';
import 'package:kaist_cafeteria/theme/colors.dart';
import 'package:kaist_cafeteria/theme/typography.dart';
import 'package:kaist_cafeteria/widgets/cafeteria_card.dart';
import 'package:kaist_cafeteria/services/api_service.dart';
import 'package:kaist_cafeteria/models/restaurant.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {  // StatelessWidget에서 StatefulWidget으로 변경
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;  // 네비게이션 바 인덱스
  int _selectedRestaurantIndex = 0;  // 선택된 식당 인덱스 추가
  List<Restaurant> _restaurants = [];
  bool _isLoading = true;
  Timer? _statusTimer;  // 추가: 상태 업데이트용 타이머

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    // 주기적으로 상태 업데이트
    _statusTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _updateRestaurantStatuses();
    });
  }

  @override
  void dispose() {
    _statusTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadRestaurants() async {
    try {
      setState(() => _isLoading = true);
      print('Loading restaurants...');
      final restaurants = await ApiService().getRestaurants();
      print('Loaded restaurants: $restaurants');
      setState(() {
        _restaurants = restaurants;
        _isLoading = false;
      });
      _updateRestaurantStatuses();
    } catch (e) {
      print('Error loading restaurants: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateRestaurantStatuses() async {
    if (_restaurants.isEmpty) return;
    
    try {
      for (var i = 0; i < _restaurants.length; i++) {
        if (_restaurants[i].restaurantId.isEmpty) {
          print('Warning: Empty restaurantId for restaurant at index $i');
          continue;
        }
        
        try {
          final status = await ApiService().getRestaurantStatus(
            _restaurants[i].restaurantId,
            _restaurants[i].name,
          );
          setState(() {
            _restaurants[i] = status;
          });
        } catch (e) {
          print('Error updating status for restaurant ${_restaurants[i].restaurantId}: $e');
        }
      }
    } catch (e) {
      print('Error in _updateRestaurantStatuses: $e');
    }
  }

  String _getLocationText() {
    if (_restaurants.isEmpty) return 'N/A';
    // 현재 선택된 식당의 위치 정보를 반환
    return _restaurants[_selectedRestaurantIndex].restaurantId;
  }

  String _getCongestionText(Restaurant? restaurant) {
    if (restaurant == null) return 'Unknown';
    if (restaurant.waitingTime <= 5) return 'Low Traffic';
    if (restaurant.waitingTime <= 15) return 'Medium Traffic';
    return 'High Traffic';
  }

  Color _getCongestionColor(Restaurant? restaurant) {
    if (restaurant == null) return AppColors.textBodySubtle;
    if (restaurant.waitingTime <= 5) {
      return AppColors.success;
    } else if (restaurant.waitingTime <= 15) {
      return AppColors.warning;
    } else {
      return AppColors.danger;
    }
  }

  // 식당 선택 처리 메서드 추가
  void _onRestaurantSelected(int index) {
    setState(() {
      _selectedRestaurantIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRestaurant = _restaurants.isNotEmpty 
        ? _restaurants[_selectedRestaurantIndex] 
        : null;

    return Scaffold(
      backgroundColor: AppColors.background1,
      body: SafeArea(
        child: Column(
          children: [
            // 1. TopBar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        'KAIST Cafeteria',
                        style: AppTypography.h2.copyWith(
                          color: AppColors.textTitle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.textCaption,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getLocationText(),  // 건물 번호 표시
                            style: TextStyle(
                              color: AppColors.textBodySubtle,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.refresh,
                      color: AppColors.textBody,
                    ),
                    onPressed: () {
                      _loadRestaurants();
                    },
                  ),
                ],
              ),
            ),

            // 2. 카페테리아 정보 및 통계
            if (currentRestaurant != null) Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        currentRestaurant.name,
                        style: AppTypography.h3.copyWith(
                          color: AppColors.textTitle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getCongestionColor(currentRestaurant).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: _getCongestionColor(currentRestaurant),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _getCongestionText(currentRestaurant),
                              style: TextStyle(
                                color: _getCongestionColor(currentRestaurant),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        currentRestaurant?.waitingTime.toString() ?? '0',
                        'min wait'
                      ),
                      _buildStatItem(
                        currentRestaurant?.emptySeats.toString() ?? '0',
                        'seats free'
                      ),
                      _buildStatItem(
                        currentRestaurant?.queueLength.toString() ?? '0',
                        'in queue'
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3. 필터 탭
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip('All', true),
                  const SizedBox(width: 8),
                  _buildFilterChip('Nearest', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Least Crowded', false),
                  const SizedBox(width: 8),
                  _buildFilterChip('Favorite', false),
                ],
              ),
            ),

            // 4. 카페테리아 그리드
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: _restaurants.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _onRestaurantSelected(index),
                        child: CafeteriaCard(
                          name: _restaurants[index].name,
                          imagePath: 'assets/images/cafeteria/${_restaurants[index].restaurantId}.jpg',
                          waitTime: _restaurants[index].waitingTime,
                          isFavorite: false,
                          onFavoritePressed: () {},
                          isSelected: index == _selectedRestaurantIndex,  // 선택 상태 전달
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu_outlined),
              activeIcon: Icon(Icons.restaurant_menu),
              label: 'Menu',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_outlined),
              activeIcon: Icon(Icons.notifications),
              label: 'Alerts',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            // TODO: 탭 전환 로직 구현
          },
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.h2.copyWith(
            color: AppColors.textTitle,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: AppColors.textBodySubtle,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}