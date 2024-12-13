import 'package:flutter/material.dart';
import 'package:kaist_cafeteria/theme/colors.dart';
import 'package:kaist_cafeteria/theme/typography.dart';

class CafeteriaCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int waitTime;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final bool isSelected;

  const CafeteriaCard({
    super.key,
    required this.name,
    required this.imagePath,
    required this.waitTime,
    required this.isFavorite,
    required this.onFavoritePressed,
    this.isSelected = false,
  });

  Color _getWaitTimeColor(int minutes) {
    if (minutes <= 5) return AppColors.success;
    if (minutes <= 15) return AppColors.warning;
    return AppColors.danger;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isSelected
            ? Border.all(color: AppColors.primary, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이미지
          AspectRatio(
            aspectRatio: 16/9,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.restaurant, color: Colors.grey),
                  );
                },
              ),
            ),
          ),
          // 정보 영역
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: AppTypography.bodyBold.copyWith(
                          color: AppColors.textTitle,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: _getWaitTimeColor(waitTime),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$waitTime min',
                            style: TextStyle(
                              color: _getWaitTimeColor(waitTime),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? AppColors.tertiary : Colors.grey,
                    size: 18,
                  ),
                  onPressed: onFavoritePressed,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}