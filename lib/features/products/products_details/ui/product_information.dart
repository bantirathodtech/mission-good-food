// lib/features/products/products_details/ui/product_information.dart

import 'package:flutter/material.dart';
import '../../model/document.dart';

class ProductInfoContent extends StatelessWidget {
  final Document product;
  const ProductInfoContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Text(
      product.description ?? '',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(43, 41, 33, 1),
      ),
    );
  }
}

class NutritionalFactsContent extends StatelessWidget {
  final Document product;
  const NutritionalFactsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final nutritionalFacts = product.metaData
            ?.where((data) => data['type'] == 'nutritional_facts')
            .map((fact) => fact['value'].toString())
            .toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: nutritionalFacts
          .map((fact) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• $fact'),
              ))
          .toList(),
    );
  }
}

class HealthBenefitsContent extends StatelessWidget {
  final Document product;
  const HealthBenefitsContent({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final healthBenefits = product.metaData
            ?.where((data) => data['type'] == 'health_benefits')
            .map((benefit) => benefit['value'].toString())
            .toList() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: healthBenefits
          .map((benefit) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text('• $benefit'),
              ))
          .toList(),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../../model/document.dart';
//
// class ProductInfoContent extends StatelessWidget {
//   final Document product;
//   const ProductInfoContent({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       product.description ?? '',
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.w400,
//         color: Color.fromRGBO(43, 41, 33, 1),
//       ),
//     );
//   }
// }
//
// class NutritionalFactsContent extends StatelessWidget {
//   final Document product;
//   const NutritionalFactsContent({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get nutritional facts from product metadata or attributes
//     final nutritionalFacts = product.metaData
//             ?.where((data) => data['type'] == 'nutritional_facts')
//             .map((fact) => fact['value'].toString())
//             .toList() ??
//         [];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: nutritionalFacts
//           .map((fact) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text('• $fact'),
//               ))
//           .toList(),
//     );
//   }
// }
//
// class HealthBenefitsContent extends StatelessWidget {
//   final Document product;
//   const HealthBenefitsContent({super.key, required this.product});
//
//   @override
//   Widget build(BuildContext context) {
//     // Get health benefits from product metadata or attributes
//     final healthBenefits = product.metaData
//             ?.where((data) => data['type'] == 'health_benefits')
//             .map((benefit) => benefit['value'].toString())
//             .toList() ??
//         [];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: healthBenefits
//           .map((benefit) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Text('• $benefit'),
//               ))
//           .toList(),
//     );
//   }
// }
