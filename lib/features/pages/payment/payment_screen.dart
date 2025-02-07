// File: lib/screens/payment_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/core/decoration/all_side_shadow_decoration.dart';
import 'package:good_food_app/core/decoration/single_side_shadow_decoration.dart';
import 'package:good_food_app/features/pages/payment/success_screen.dart';

import '../../../core/theme/text_styles/global_text_style.dart';
import '../../../core/widgets/pattern/line/line_widget.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isCardSaved = false;
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardExpiryController = TextEditingController();
  final TextEditingController cardCVCController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: allSideShadowDecoration,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          _buildPaymentHeader(),
                          // Divider(color: Colors.grey.shade200, thickness: 1),
                          // const SizedBox(height: 16),
                          _buildCreditCardSection(),
                          const SizedBox(height: 0),
                          _buildSaveCardCheckbox(),
                          const SizedBox(height: 8),
                          Divider(color: Colors.grey.shade200, thickness: 1),
                          // const SizedBox(height: 8),
                          _buildPayPalSection(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _buildPayNowButton(context),
              ],
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: _buildFooterLineWidget(),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: greenShadowDecoration,
        child: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('Payment', style: GlobalTextStyles.qs20w7black),
          centerTitle: true,
          elevation: 0,
        ),
      ),
    );
  }

  //done
  Widget _buildPaymentHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 60,
          child: const Text(
            '₹598',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(40, 40, 40, 1),
            ),
          ),
        ),
        // Remove extra space with a precise offset
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            // minimumSize: const Size(0, 24),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'View detailed order',
            style: TextStyle(
              color: Color.fromRGBO(79, 165, 111, 1),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Divider(
          color: Colors.grey.shade200,
          thickness: 0.5,
          height: 8,
        )
      ],
    );
  }

  Widget _buildCreditCardSection() {
    return _buildPaymentMethod(
      title: 'Credit/Debit Card',
      isSelected: true,
      paymentProviders: Row(
        children: [
          SvgPicture.asset(
            'assets/images/payment_provider.svg',
            height: 20,
          ),
        ],
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: const Text(
              'Pay securely with your Bank Account using Visa or Mastercard',
              style: TextStyle(
                color: Color.fromRGBO(40, 40, 40, 1),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCardInput(
            label: 'Card Number',
            hint: 'XXXX XXXX XXXX XXXX',
            controller: cardNumberController,
          ),
          _buildCardInput(
            label: 'Name on Card',
            hint: 'Name on Card',
            controller: cardNameController,
          ),
          Row(
            children: [
              Expanded(
                child: _buildCardInput(
                  label: 'Expire Date',
                  hint: 'MM/YY',
                  controller: cardExpiryController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildCardInput(
                  label: 'CVV Code',
                  hint: 'XXX',
                  controller: cardCVCController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSaveCardCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: isCardSaved,
          onChanged: (value) {
            setState(() {
              isCardSaved = value ?? false;
            });
          },
        ),
        const Text(
          'Save card for future payment',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildPayPalSection() {
    return _buildPaymentMethod(
      title: 'PayPal',
      isSelected: false,
      paymentProviders: SvgPicture.asset(
        'assets/images/paypal.svg',
        height: 24,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, right: 8, bottom: 24, top: 16),
        child: const Text(
          'You will be redirected to PayPal website to complete your order securely.',
          style: TextStyle(
            color: Color.fromRGBO(40, 40, 40, 1),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildPayNowButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SuccessScreen(),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4FA56F),
            foregroundColor: Colors.white,
            // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: const Text(
            'Pay Now',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterLineWidget() {
    return Align(
      alignment: Alignment.center,
      child: LineWidget(
        length: 200,
        thickness: 5,
        color: const Color.fromRGBO(29, 191, 115, 1),
        borderRadius: 12.0,
      ),
    );
  }

  Widget _buildPaymentMethod({
    required String title,
    required bool isSelected,
    required Widget child,
    required Widget paymentProviders,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Radio Button
            Row(
              children: [
                Radio(
                  value: isSelected,
                  groupValue: true,
                  onChanged: (value) {},
                  activeColor: const Color(0xFF4FA56F),
                ),
                // const SizedBox(width: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                ),
              ],
            ),
            Row(
              children: [paymentProviders],
            ),
            // if (paymentProviders != null) paymentProviders,
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8),
          child: child,
        ),
      ],
    );
  }

  Widget _buildCardInput({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xFF212121),
        ),
        onChanged: (value) {
          // Rebuild the widget to update border color
          setState(() {});
        },
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 12,
            color: Color(0xFF757575),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color.fromRGBO(221, 86, 43, 1),
            fontSize: 12,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: controller.text.isEmpty
                  ? const Color.fromRGBO(221, 86, 43, 1) // Red for empty
                  : Colors.black, // Black for non-empty
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: controller.text.isEmpty
                  ? const Color.fromRGBO(221, 86, 43, 1) // Red for empty
                  : Colors.black, // Black for non-empty
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: controller.text.isEmpty
                  ? const Color.fromRGBO(221, 86, 43, 1) // Red for empty
                  : Colors.black, // Black for non-empty
            ),
          ),
        ),
      ),
    );
  }
}
