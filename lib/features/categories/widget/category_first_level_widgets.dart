// category_first_level_widgets.dart
// Purpose: Main category widget that orchestrates all category levels

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/categories_provider.dart';
import 'category_second_level_widgets.dart';

class CategoryFirstLevelWidgets extends StatefulWidget {
  const CategoryFirstLevelWidgets({super.key});

  @override
  State<CategoryFirstLevelWidgets> createState() =>
      _CategoryFirstLevelWidgetsState();
}

class _CategoryFirstLevelWidgetsState extends State<CategoryFirstLevelWidgets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.hasError) {
          return Center(
            child: Text(
              provider.error ?? 'Error loading categories',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 10),
            _buildFirstLevelCategories(provider),
            const SizedBox(height: 10),
            if (provider.hasFirstLevelSelection)
              const CategorySecondLevelWidgets(),
          ],
        );
      },
    );
  }

  Widget _buildFirstLevelCategories(CategoriesProvider provider) {
    return SizedBox(
      height: 27,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.firstLevelCategories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = provider.firstLevelCategories[index];
          final isSelected = provider.isFirstLevelSelected(category);

          return _buildCategoryButton(
            label: category,
            backgroundColor:
                isSelected ? const Color(0xFF4FA56F) : const Color(0xFFE2F1E8),
            foregroundColor:
                isSelected ? Colors.white : const Color(0xFF4FA56F),
            onTap: () => provider.selectFirstLevel(category),
          );
        },
      ),
    );
  }

  Widget _buildCategoryButton({
    required String label,
    required Color backgroundColor,
    required Color foregroundColor,
    required VoidCallback onTap,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
