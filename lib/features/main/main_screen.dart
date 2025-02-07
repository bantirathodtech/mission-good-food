import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/core/main_screen_navigation.dart';

import '../cart/presentation/view/screen/cart_screen.dart';
import '../home/home_screen.dart';
import '../screens/tabs/favorite/favorite_screen.dart';
import '../screens/tabs/profile/profile_setting.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          MainScreenNavigation.handleMainScreenBack(context, selectedIndex),
      //with confirmation dialog:
      //onWillPop: () => MainScreenNavigationWithConfirmation.handleMainScreenBack(context, _selectedIndex),
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: [
            const HomeScreen(),
            const FavoriteScreen(),
            const CartScreen(),
            const ProfileSettingsScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: CustomBottomNavigationBar(
            selectedIndex: selectedIndex,
            onItemTapped: (index) {
              setSelectedIndex(index);
            }, // onItemTapped: _onItemTapped,
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildNavItem(0, 'Home', 'assets/icons/ic_home.svg'),
        _buildNavItem(1, 'Favorite', null, icon: Icons.favorite),
        _buildNavItem(2, 'Cart', 'assets/icons/ic_cart.svg'),
        _buildNavItem(3, 'Profile', 'assets/icons/ic_profile.svg'),
      ],
    );
  }

  Widget _buildNavItem(int index, String label, String? svgPath,
      {IconData? icon}) {
    bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: const Color.fromRGBO(228, 242, 228, 0.8),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                      // borderRadius: BorderRadius.circular(8),
                    ),
                  ]
                : null,
            // decoration: greenShadowDecoration,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (svgPath != null)
                SvgPicture.asset(
                  svgPath,
                  color: isSelected ? const Color(0xFF4CAF50) : Colors.black,
                  height: 24,
                  width: 24,
                )
              else if (icon != null)
                Icon(
                  icon,
                  color: isSelected ? const Color(0xFF4CAF50) : Colors.black,
                  size: 24,
                ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? const Color(0xFF4CAF50) : Colors.black,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
