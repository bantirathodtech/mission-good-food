import 'package:flutter/material.dart';

import '../widget/search_bar_widget.dart';

class SearchBarScreen extends StatelessWidget {
  const SearchBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Bar Example'),
      ),
      body: Center(
        child: SearchBarWidget(
          controller: searchController,
          onChanged: (String value) {
            debugPrint('Search text changed: $value');
          },
          onSubmitted: (String value) {
            debugPrint('Search submitted: $value');
          },
          onTap: () {
            debugPrint('Search bar tapped');
          },
          onTapOutside: () {
            debugPrint('Tapped outside the search bar');
          },
        ),
      ),
    );
  }
}
