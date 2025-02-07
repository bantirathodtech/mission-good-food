import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import '../../../core/theme/text_styles/global_text_style.dart';
import '../../../location/service/location_service.dart';
import '../../../location/widget/trackmap/map_display_widget.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map taking full screen
          // MapDisplayWidget(
          //   initialLatitude: double.parse(LocationService.currentLatitude),
          //   initialLongitude: double.parse(LocationService.currentLongitude),
          // ),
          MapDisplayWidget(
            storeLocation: LatLng(double.parse(LocationService.currentLatitude),
                double.parse(LocationService.currentLongitude)),
            deliveryLocation: const LatLng(12.9716, 77.5946),
            currentDeliveryLocation: LatLng(
                double.parse(LocationService.currentLatitude),
                double.parse(LocationService.currentLongitude)),
          ),

          // Back button with safe area consideration
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // Bottom sheet with drag capability
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.15,
            maxChildSize: 0.45,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(36),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Drag indicator
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        // Status and time
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'On the way',
                              style: GlobalTextStyles.qs20w7black,
                            ),
                            _buildTimeButton(),
                          ],
                        ),

                        const SizedBox(height: 8),
                        _buildProgressIndicators(),
                        const SizedBox(height: 16),
                        _buildDeliveryHeroCard(),
                        const SizedBox(height: 16),
                        _buildLocationDetails(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton() {
    return SizedBox(
      height: 34,
      // width: 74,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Color.fromRGBO(241, 241, 245, 1),
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/ic_timer.svg',
              height: 15,
              width: 15,
            ),
            const SizedBox(width: 4),
            Text(
              '6 Min',
              style: GlobalTextStyles.dms10w5Black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicators() {
    return Row(
      children: [
        _buildProgressStep('Order placed', true),
        _buildProgressStep('On the way', false),
        _buildProgressStep('Delivered', false),
      ],
    );
  }

  Widget _buildProgressStep(String title, bool isCompleted) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: isCompleted
                ? GlobalTextStyles.dms11w5Green
                : GlobalTextStyles.qs11w5Grey,
          ),
          const SizedBox(height: 8),
          Container(
            width: 100,
            height: 3,
            color: isCompleted ? Colors.green : Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryHeroCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/delivery_hero.png'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your delivery hero',
                  style: GlobalTextStyles.qs11w5Grey,
                ),
                const SizedBox(height: 4),
                Text(
                  'Joseph chizzy',
                  style: GlobalTextStyles.qs13w7Black,
                ),
              ],
            ),
          ),
          _buildActionButton(
            SvgPicture.asset('assets/icons/ic_chat.svg', height: 14, width: 14),
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            SvgPicture.asset('assets/icons/ic_phone.svg',
                height: 14, width: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationDetails() {
    return Column(
      children: [
        _buildLocationInfo(
          icon: SvgPicture.asset('assets/icons/ic_store.svg'),
          title: 'Store',
          address: 'Pastore Grocery Store',
          color: Colors.red,
        ),
        const SizedBox(height: 8),
        DottedDashedLine(
          height: 0,
          width: double.infinity,
          axis: Axis.horizontal,
          dashColor: Color.fromRGBO(241, 241, 245, 1),
          strokeWidth: 1.1,
          dashSpace: 6,
          dashWidth: 6,
        ),
        const SizedBox(height: 8),
        _buildLocationInfo(
          icon: SvgPicture.asset('assets/icons/ic_location.svg'),
          title: 'Your place',
          address: '2 Ika Omole phase 2',
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _buildActionButton(Widget icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(243, 245, 247, 1),
      ),
      child: IconButton(
        icon: icon,
        onPressed: () {},
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildLocationInfo({
    required Widget icon,
    required String title,
    required String address,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GlobalTextStyles.qs11w5Grey),
              const SizedBox(height: 4),
              Text(address, style: GlobalTextStyles.qs14w6Black),
            ],
          ),
        ],
      ),
    );
  }
}
