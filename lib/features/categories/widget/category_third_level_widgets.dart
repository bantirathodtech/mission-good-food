// category_third_level_widgets.dart
// Purpose: Handles the third level (subchild) categories

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/decoration/single_side_shadow_decoration.dart';
import '../provider/categories_provider.dart';

class CategoryThirdLevelWidgets extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategoryThirdLevelWidgets({
    super.key,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final thirdLevelCategories = provider.thirdLevelCategories;

        if (thirdLevelCategories.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          decoration: greenShadowDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: thirdLevelCategories.map((category) {
                final categoryName = category.categoryName ?? '';
                final isSelected = provider.isThirdLevelSelected(categoryName);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      provider.selectThirdLevel(categoryName);
                      onCategorySelected(categoryName);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildThirdLevelIcon(
                          isSelected: isSelected,
                          imageUrl: category.imageUrl ?? '',
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 10,
                            color: isSelected
                                ? const Color(0xFF4FA56F)
                                : Colors.black,
                            fontWeight:
                                isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildThirdLevelIcon({
    required bool isSelected,
    required String imageUrl,
  }) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4FA56F) : const Color(0xFFE2F1E8),
        shape: BoxShape.circle,
      ),
      child: _buildImage(imageUrl, isSelected),
    );
  }

  Widget _buildImage(String imageUrl, bool isSelected) {
    const double imageSize = 24;

    if (imageUrl.isEmpty) {
      return Icon(
        Icons.category,
        color: isSelected ? Colors.white : const Color(0xFF4FA56F),
        size: imageSize,
      );
    }

    return ClipOval(
      child: Image.network(
        imageUrl,
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.category,
          color: isSelected ? Colors.white : const Color(0xFF4FA56F),
          size: imageSize,
        ),
      ),
    );
  }
}
