// File: lib/screens/success_screen.dart
import 'package:flutter/material.dart';
import 'package:good_food_app/features/pages/payment/tracking_screen.dart';

import '../../../core/widgets/pattern/line/line_widget.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 154,
                  height: 154,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(79, 165, 111, 1),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Order Successful!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromRGBO(79, 165, 111, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: const Text(
                    'Your payment has been successfully processed, and your order is now confirmed.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(115, 111, 104, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 80,
              left: 24,
              right: 24,
              child: Column(
                children: [
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TrackingScreen(),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Adjust the radius
                        ),
                      ),
                      child: const Text(
                        'Track Your Order',
                        style: TextStyle(
                            color: Color.fromRGBO(43, 41, 33, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(79, 165, 111, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12), // Adjust the radius
                        ),
                      ),
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Align(
                alignment: Alignment.center,
                child: LineWidget(
                  length: 200,
                  thickness: 5,
                  color: const Color.fromRGBO(29, 191, 115, 1),
                  borderRadius: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
