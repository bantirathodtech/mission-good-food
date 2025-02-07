import 'package:flutter/material.dart';
import 'package:good_food_app/core/wotw/searchbar/combine/search_bar_combine.dart';
import 'package:good_food_app/core/wotw/searchbar/search_anchor/screen/search_anchor_screen.dart';
import 'package:good_food_app/core/wotw/searchbar/search_bar/screen/search_bar_screen.dart';

// Define WidgetOfTheWeek with name, image (asset or icon), and screen reference
class WidgetOfTheWeek {
  final String name;
  final String imageUrl; // URL for an image or asset path
  final Widget screen; // The screen or widget to navigate to

  WidgetOfTheWeek(
      {required this.name, required this.imageUrl, required this.screen});
}

class WidgetOfTheWeekGrid extends StatelessWidget {
  WidgetOfTheWeekGrid({super.key});

  // Sample data for the widgets of the week
  final List<WidgetOfTheWeek> widgets = [
    WidgetOfTheWeek(
      name: 'Combine Search Bar',
      imageUrl: 'assets/icons/searchbar.png', // Local asset image path
      screen: SearchBarCombine(), // Corresponding screen for Search Bar widget
    ),
    WidgetOfTheWeek(
      name: 'Search Anchor',
      imageUrl: 'assets/icons/searchbar.png', // Another local asset image
      screen: SearchAnchorScreen(), // Example screen
    ),
    WidgetOfTheWeek(
      name: 'Search Bar',
      imageUrl: 'assets/icons/searchbar.png', // Local asset image
      screen: SearchBarScreen(), // Example screen
    ),
    // Add more widgets as necessary
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget of the Week')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 items per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: widgets.length,
          itemBuilder: (context, index) {
            final widget = widgets[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the screen of the tapped widget
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => widget.screen),
                );
              },
              child: GridTile(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the image or icon
                    widget.imageUrl.endsWith('.png') ||
                            widget.imageUrl.endsWith('.jpg')
                        ? Image.asset(widget.imageUrl,
                            height: 30, width: 30) // Asset image
                        : Icon(Icons.star,
                            size: 100), // Fallback to icon if image not found
                    const SizedBox(height: 8),
                    Text(
                      widget.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
