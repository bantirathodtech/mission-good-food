import 'package:flutter/material.dart';

import '../widget/search_anchor_widget.dart';

class SearchAnchorScreen extends StatelessWidget {
  const SearchAnchorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchAnchorWidget(
            barBackgroundColor: Colors.white,
            barElevation: 2.0,
            viewBackgroundColor: Colors.grey[200],
            viewElevation: 2.0,
            viewShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            suggestionsBuilder: (context, controller) {
              final String input = controller.value.text;
              final List<String> filteredSuggestions = _getSuggestions(input);
              return filteredSuggestions.map((item) {
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    controller.closeView(item);
                    debugPrint('Selected: $item');
                  },
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  // Helper method to provide suggestions
  List<String> _getSuggestions(String query) {
    final List<String> allItems = [
      'Apple',
      'Banana',
      'Cherry',
      'Date',
      'Elderberry',
    ];
    return allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
