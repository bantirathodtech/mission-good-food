// lib/features/cart/presentation/widgets/cart_summary_section.dart
import 'package:flutter/material.dart';

import '../../../../../core/theme/text_styles/global_text_style.dart';

class CartSummarySection extends StatelessWidget {
  final int itemCount;
  final num subtotal;
  final num totalAmount;

  const CartSummarySection({
    super.key,
    required this.itemCount,
    required this.subtotal,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: GlobalTextStyles.qs16w7Black),
          const SizedBox(height: 8),
          _SummaryRow('Items', '$itemCount'),
          _SummaryRow('Subtotal', '₹$subtotal'),
          const Divider(height: 24),
          _SummaryRow('Total', '₹$totalAmount', isTotal: true),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _SummaryRow(this.label, this.value, {this.isTotal = false});

  @override
  Widget build(BuildContext context) {
    final style =
        isTotal ? GlobalTextStyles.small7Black : GlobalTextStyles.small3Black;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }
}
