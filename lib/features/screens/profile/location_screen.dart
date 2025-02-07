import 'package:flutter/material.dart';
import 'package:good_food_app/core/decoration/all_side_shadow_decoration.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';
import 'package:provider/provider.dart';

import '../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../core/theme/text_styles/global_text_style.dart';

// First, create an AddressModel to manage address data
class AddressModel {
  final String title;
  final String address;
  final String phoneNumber;
  final IconData icon;

  AddressModel({
    required this.title,
    required this.address,
    required this.phoneNumber,
    required this.icon,
  });
}

// Create a provider or state management class to handle address selection
class AddressProvider extends ChangeNotifier {
  AddressModel? _selectedAddress;

  AddressModel? get selectedAddress => _selectedAddress;

  void setSelectedAddress(AddressModel address) {
    _selectedAddress = address;
    notifyListeners();
  }
}

// Update the LocationScreen to handle address selection
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final List<AddressModel> addresses = [
    AddressModel(
      title: 'Home',
      address: 'Mohan Nivas 17-01-110/d, Bhagatsingh Nagar Corner, Ameerpeth',
      phoneNumber: '7020797849',
      icon: Icons.home_outlined,
    ),
    AddressModel(
      title: 'Work',
      address: '306, Topaz Plaza, Punjagutta Officers Colony',
      phoneNumber: '7020797849',
      icon: Icons.work_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Container(
          decoration: greenShadowDecoration,
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              // onPressed: widget.onBackToHome,
              onPressed: () => AppRouteManager.goBack(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Locations',
              style: GlobalTextStyles.qsTitle,
            ),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 32),
              //   child: SvgPicture.asset('assets/icons/ic_search.svg'),
              // ),
            ],
            centerTitle: true,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              addressProvider.setSelectedAddress(addresses[index]);
              Navigator.pop(context);
            },
            child: AddressCard(address: addresses[index]),
          );
        },
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final AddressModel address;

  const AddressCard({
    super.key,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: allSideShadowDecoration,
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(address.icon, size: 24, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      address.title,
                      style: GlobalTextStyles.qs16w7Black,
                      // style: const TextStyle(
                      //   fontSize: 16,
                      //   fontWeight: FontWeight.w600,
                      // ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  address.address,
                  style: GlobalTextStyles.regular4Black,
                  // style: const TextStyle(
                  //   color: Colors.black87,
                  //   fontSize: 14,
                  // ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Phone number: ${address.phoneNumber}',
                  style: GlobalTextStyles.regular5Black,
                  // style: const TextStyle(
                  //   color: Colors.black87,
                  //   fontSize: 14,
                  // ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _ActionButton(
                      title: 'EDIT',
                      onPressed: () {
                        // Handle edit
                      },
                      textColor: Colors.red,
                    ),
                    const SizedBox(width: 24),
                    _ActionButton(
                      title: 'DELETE',
                      onPressed: () {
                        // Handle delete
                      },
                      textColor: Colors.red,
                    ),
                    const SizedBox(width: 24),
                    _ActionButton(
                      title: 'SHARE',
                      onPressed: () {
                        // Handle share
                      },
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color textColor;

  const _ActionButton({
    required this.title,
    required this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        title,
        style: GlobalTextStyles.large7Red,
        // style: TextStyle(
        //   color: textColor,
        //   fontSize: 14,
        //   fontWeight: FontWeight.w600,
        // ),
      ),
    );
  }
}
