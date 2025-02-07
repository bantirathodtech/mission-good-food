// lib/features/products/products_details/ui/product_details_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/features/cart/presentation/viewmodel/handlers/cart_handler_mixin.dart';
import 'package:good_food_app/features/categories/widget/category_first_level_widgets.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../../core/widgets/button/elevatedButton44_8.dart';
import '../../../../core/widgets/button/outline_button448.dart';
import '../../../../core/widgets/dropdown/dropdown_section_widget.dart';
import '../../../di/service_locator.dart';
import '../../model/document.dart';
import '../../products_card/card/product_card.dart';
import '../../products_card/provider/products_provider.dart';
import '../provider/product_details_provider.dart';
import '../state/product_details_state.dart';
import '../viewmodel/product_details_viewmodel.dart';
import 'product_information.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Document product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with CartHandlerMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              getIt<ProductDetailsViewModel>(param1: widget.product),
        ),
        ChangeNotifierProxyProvider<ProductDetailsViewModel,
            ProductDetailsProvider>(
          create: (context) => ProductDetailsProvider(
            getIt<ProductDetailsViewModel>(param1: widget.product),
            widget.product,
          ),
          update: (context, viewModel, previous) =>
              previous ?? ProductDetailsProvider(viewModel, widget.product),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Consumer2<ProductDetailsProvider, ProductsProvider>(
          builder: (context, detailsProvider, productsProvider, _) {
            if (detailsProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final state = detailsProvider.state;

            return RefreshIndicator(
              onRefresh: () async {
                final viewModel = context.read<ProductDetailsViewModel>();
                await viewModel.refresh();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Show only Level 1 and 2 categories at the top
                    CategoryFirstLevelWidgets(),

                    _buildProductImage(productsProvider),
                    _buildThumbnails(state.product.images ?? []),
                    _buildProductInfo(state),
                    _buildWeightAndQuantitySelectors(detailsProvider),
                    _buildActionButtons(context, detailsProvider),
                    _buildExpandableSections(detailsProvider),
                    if (state.similarProducts.isNotEmpty)
                      _buildSimilarProducts(
                          state.similarProducts, productsProvider),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Consumer<ProductDetailsProvider>(
          builder: (context, provider, _) => _buildBottomBar(provider),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      title: SvgPicture.asset(
        'assets/images/logo.svg',
        height: 40,
        width: 100,
      ),
      centerTitle: true,
    );
  }

  Widget _buildProductImage(ProductsProvider productsProvider) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Container(
            height: 300,
            decoration: BoxDecoration(color: Colors.grey[100]),
            child: Image.network(
              widget.product.imageUrl ?? '',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 16,
          child: GestureDetector(
            onTap: () =>
                productsProvider.toggleWishlist(widget.product.id ?? ''),
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                productsProvider.isProductWishlisted(widget.product.id ?? '')
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: const Color.fromRGBO(239, 164, 200, 1),
                size: 18,
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          top: 48,
          child: GestureDetector(
            onTap: () =>
                productsProvider.toggleWishlist(widget.product.id ?? ''),
            child: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  "assets/icons/ic_share.svg",
                  // color: const Color.fromRGBO(239, 164, 200, 1),
                  width: 18,
                  height: 18,
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo(ProductDetailsState state) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.product.name ?? '',
            style: GlobalTextStyles.qs20w7black,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '₹${state.product.salePrice}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (state.product.listPrice != null)
                Text(
                  '(${state.product.listPrice} kg)',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(state.product.description ?? 'Description is not available'),
        ],
      ),
    );
  }

  Widget _buildWeightAndQuantitySelectors(ProductDetailsProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildWeightSelector(provider),
          const SizedBox(width: 16),
          _buildQuantitySelector(provider),
        ],
      ),
    );
  }

  Widget _buildWeightSelector(ProductDetailsProvider provider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Net Weight',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color.fromRGBO(65, 61, 50, 1),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(138, 141, 159, 1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: provider.state.selectedWeight,
                  items: provider.state.availableWeights.map((String weight) {
                    return DropdownMenuItem<String>(
                      value: weight,
                      child: Text(weight),
                    );
                  }).toList(),
                  onChanged: provider.updateSelectedWeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(ProductDetailsProvider provider) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quantity',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color.fromRGBO(65, 61, 50, 1),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 30,
            width: 120,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromRGBO(138, 141, 159, 1)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, size: 18),
                  onPressed: () => provider.updateQuantity(false),
                ),
                Text('${provider.state.quantity}'),
                IconButton(
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: () => provider.updateQuantity(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, ProductDetailsProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ElevatedButton448(
            text: 'Subscribe',
            onPressed: () => provider.subscribe(),
          ),
          OutlineButton448(
            text: 'Buy Once',
            onPressed: () => provider.addToCart(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableSections(ProductDetailsProvider provider) {
    final state = provider.state;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownSectionWidgets(
            title: 'Product Information',
            isExpanded: state.isProductInfoExpanded,
            onTap: () => provider.toggleSection('info'),
            expandedBuilder: () => ProductInfoContent(product: state.product),
          ),
          DropdownSectionWidgets(
            title: 'Nutritional Facts',
            isExpanded: state.isNutritionalFactsExpanded,
            onTap: () => provider.toggleSection('nutrition'),
            expandedBuilder: () =>
                NutritionalFactsContent(product: state.product),
          ),
          DropdownSectionWidgets(
            title: 'Health Benefits',
            isExpanded: state.isHealthBenefitsExpanded,
            onTap: () => provider.toggleSection('benefits'),
            expandedBuilder: () =>
                HealthBenefitsContent(product: state.product),
          ),
        ],
      ),
    );
  }

  Widget _buildSimilarProducts(
      List<Document> similarProducts, ProductsProvider productsProvider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('You might also like'),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 16,
              childAspectRatio: 0.82,
            ),
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              final similarProduct = similarProducts[index];
              return ProductCard(
                product: similarProduct,
                isWishlisted: productsProvider
                    .isProductWishlisted(similarProduct.id ?? ''),
                onWishlistedPressed: () =>
                    productsProvider.toggleWishlist(similarProduct.id ?? ''),
                // onAddToCart: () {},
                onAddToCart: (product) =>
                    handleAddToCart(context, product), // Using the mixin

                onProductTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailsScreen(product: similarProduct),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ProductDetailsProvider provider) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '₹${provider.state.totalPrice}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4FA56F),
                  ),
                ),
                Text(
                  '${provider.state.quantity} Items',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => provider.addToCart(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FA56F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Add to cart'),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildThumbnails(List<dynamic> images) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: SizedBox(
      height: 66,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: images
            .take(4)
            .map((image) => Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: _buildThumbnailItem(
                    image['image_url'],
                    isSelected: images.indexOf(image) == 0,
                  ),
                ))
            .toList(),
      ),
    ),
  );
}

Widget _buildThumbnailItem(String imageUrl, {bool isSelected = false}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: isSelected
            ? const Color.fromRGBO(78, 91, 166, 1)
            : const Color.fromRGBO(223, 222, 220, 1),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Container(
      width: 66,
      height: 66,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color:
            isSelected ? const Color.fromRGBO(241, 242, 235, 1) : Colors.white,
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      ),
    ),
  );
}
