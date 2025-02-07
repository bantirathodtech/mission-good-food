import 'package:flutter/material.dart';

class SearchBarCombine extends StatelessWidget {
  const SearchBarCombine({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the SearchController
    final SearchController searchController = SearchController();

    return Scaffold(
      appBar: AppBar(title: const Text('Custom Search Bar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              controller: searchController,
              onChanged: (query) {
                // Handle text change
                debugPrint('Text changed: $query');
              },
              onSubmitted: (query) {
                // Handle submission
                debugPrint('Submitted: $query');
              },
              onTap: () {
                // Handle tap
                debugPrint('Search bar tapped');
              },
              onTapOutside: (event) {
                // Handle tap outside
                debugPrint(
                    'Tapped outside search bar at: ${event.localPosition}');
              },
              leading: const Icon(Icons.search),
              hintText: 'Search',
              backgroundColor: WidgetStateProperty.all(Colors.blue),
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
            const SizedBox(height: 20),
            SearchAnchor.bar(
              barBackgroundColor: WidgetStateProperty.all(Colors.blue),
              barElevation: WidgetStateProperty.all(4.0),
              viewBackgroundColor: Colors.grey,
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
          ],
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
      'Elderberry'
    ];
    return allItems
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
