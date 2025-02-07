import 'package:flutter/material.dart';

import '../../../../core/decoration/all_side_shadow_decoration.dart';
import '../../model/document.dart';

class ProductCard extends StatelessWidget {
  final Document product;
  final bool isWishlisted;
  final VoidCallback? onWishlistedPressed;
  // final VoidCallback? onAddToCart;
  final Function(Document product)? onAddToCart;
  final VoidCallback? onProductTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.isWishlisted,
    this.onWishlistedPressed,
    this.onAddToCart,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    // Safely convert product.salePrice to num
    final salePrice = (product.salePrice is num)
        ? product.salePrice as num
        : num.tryParse('${product.salePrice ?? 0}') ?? 0;

    return Container(
      decoration: allSideShadowDecoration.copyWith(
          borderRadius: BorderRadius.circular(12)),
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onProductTap, // Navigate to product Details
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ProductImage(
                  imageUrl: product.imageUrl ?? '',
                  isWishlisted: isWishlisted,
                  onWishlistedPressed: onWishlistedPressed,
                ),
                const SizedBox(height: 8),
                _ProductName(name: product.name ?? ''),
                const SizedBox(height: 4),
                // _ProductPrice(
                //   price: product.salePrice ?? '0',
                //   quantity: product.listPrice,
                // ),
                _ProductPrice(
                  price: salePrice, // Now passing a guaranteed num
                  quantity: product.listPrice, // This should already be num?
                ),
                const SizedBox(height: 4),
                // _AddButton(onPressed: onAddToCart), // Add product into Cart
                // _AddButton(onPressed:onAddToCart?.call(product)), // Add product into Cart
                _AddButton(
                    onPressed: () =>
                        onAddToCart?.call(product)), // Add product into Cart
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;
  final bool isWishlisted;
  final VoidCallback? onWishlistedPressed;

  const _ProductImage({
    required this.imageUrl,
    required this.isWishlisted,
    this.onWishlistedPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 139,
              height: 111,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 139,
                  height: 111,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported),
                );
              },
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: GestureDetector(
            onTap: onWishlistedPressed,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                isWishlisted ? Icons.favorite : Icons.favorite_border,
                color: const Color.fromRGBO(239, 164, 200, 1),
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductName extends StatelessWidget {
  final String name;

  const _ProductName({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color.fromRGBO(10, 161, 125, 1),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _ProductPrice extends StatelessWidget {
  final num price;
  final String? quantity;

  const _ProductPrice({
    required this.price,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '₹${price.toStringAsFixed(2)}', // format price with 2 decimal places
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 4),
        if (quantity != null)
          Text(
            '($quantity Kg)',
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
      ],
    );
  }
}

class _AddButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _AddButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 24,
        width: 80,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(239, 164, 200, 1),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'Add',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
