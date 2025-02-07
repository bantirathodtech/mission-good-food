// category_second_level_widgets.dart
// Purpose: Handles the second level (child) categories
// category_second_level_widgets.dart
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../core/decoration/single_side_shadow_decoration.dart';
import '../../grid_list/products_grid_list_screen.dart';
import '../provider/categories_provider.dart';

class CategorySecondLevelWidgets extends StatelessWidget {
  const CategorySecondLevelWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final secondLevelCategories = provider.secondLevelCategories;
        final screenWidth = MediaQuery.of(context).size.width;
        final itemWidth = 80.0;
        final crossAxisCount = (screenWidth / itemWidth).floor();

        return Container(
          width: double.infinity,
          decoration: greenShadowDecoration,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: screenWidth,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.0,
                ),
                itemCount: secondLevelCategories.length,
                itemBuilder: (context, index) {
                  final category = secondLevelCategories[index];
                  final categoryName = category.name ?? '';
                  final isSelected = provider.isSecondLevelSelected(categoryName);

                  return InkWell(
                    onTap: () {
                      provider.selectSecondLevel(categoryName);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductsGridListScreen(
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildCategoryIcon(
                          isSelected: isSelected,
                          imageUrl: category.imageUrl ?? '',
                        ),
                        const SizedBox(height: 2),
                        Text(
                          categoryName,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? const Color(0xFF4FA56F) : Colors.black,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryIcon({
    required bool isSelected,
    required String imageUrl,
  }) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: 40,
          width: 50,
          decoration: BoxDecoration(
            color: HexColor("#4FA56F"),
            shape: BoxShape.circle,
          ),
        ),
        Positioned(
          child: _buildImage(imageUrl, isSelected),
        ),
      ],
    );
  }

  Widget _buildImage(String imageUrl, bool isSelected) {
    const double imageSize = 50;
    const double borderRadius = 8;

    Widget imageWidget = imageUrl.isEmpty
        ? Icon(
            Icons.category,
            color: isSelected ? Colors.white : const Color(0xFF4FA56F),
            size: imageSize,
          )
        : Image.network(
            imageUrl,
            height: imageSize,
            width: imageSize,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.category,
              color: isSelected ? Colors.white : const Color(0xFF4FA56F),
              size: imageSize,
            ),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageWidget,
    );
  }
}