// lib/features/cart/presentation/widgets/payment_summary_section.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/global_text_style.dart';

class PaymentSummarySection extends StatelessWidget {
  final int itemCount;
  final num subtotal;
  final num? shipping;
  final num? tax;
  final num total;

  const PaymentSummarySection({
    super.key,
    required this.itemCount,
    required this.subtotal,
    this.shipping,
    this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color.fromRGBO(246, 247, 255, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Summary', style: GlobalTextStyles.qs16w7Black),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$itemCount items', style: GlobalTextStyles.small3Black),
              Text('₹$subtotal', style: GlobalTextStyles.small3Black),
            ],
          ),
          if (shipping != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping', style: GlobalTextStyles.small3Black),
                Text('₹$shipping', style: GlobalTextStyles.small3Black),
              ],
            ),
          ],
          if (tax != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax', style: GlobalTextStyles.small3Black),
                Text('₹$tax', style: GlobalTextStyles.small3Black),
              ],
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: GlobalTextStyles.small7Black),
              Text('₹$total', style: GlobalTextStyles.small7Black),
            ],
          ),
        ],
      ),
    );
  }
}
