import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onTap;
  final VoidCallback onTapOutside;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onTap,
    required this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        onTapOutside: (event) => onTapOutside(),
        leading: const Icon(Icons.search),
        hintText: 'Search',
        backgroundColor: WidgetStateProperty.all(Colors.white),
        shadowColor: WidgetStateProperty.all(Colors.black),
        elevation: WidgetStateProperty.all(4.0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ),
      ),
    );
  }
}
