import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/core/animations/shimmer_effect.dart';
import 'package:good_food_app/core/log/loggers.dart';
import 'package:good_food_app/core/widgets/search_overlay/1/search_icon.dart';
import 'package:good_food_app/features/categories/provider/categories_provider.dart';
import 'package:good_food_app/features/categories/widget/category_first_level_widgets.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/decoration/single_side_shadow_decoration.dart';
import '../../core/theme/text_styles/global_text_style.dart';
import '../bestseller/best_selling_widgets.dart';
import '../products/products_card/provider/products_provider.dart';
import '../screens/profile/location_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = true;
  bool _isRefreshing = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    AppLogger.logInfo('[HomeScreen] Initializing');

    // Use WidgetsBinding to ensure the widget is build before loading data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  // _setupInfiniteScrlling();
  // }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    AppLogger.logInfo('[HomeScreen] Disposing');
  }

  void _setupInfiniteScrlling() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        _loadMoreData();
      }
    });
  }

  Future<void> _initializeData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final provider = context.read<ProductsProvider>();
      final categoryProvider = context.read<CategoriesProvider>();

      // First, load categories
      await categoryProvider.loadCategories('GROC');
      AppLogger.logInfo('[HomeScreen] Categories Loaded');

      // Detailed logging for products loading
      AppLogger.logInfo('[HomeScreen] Attempting to load products');

      // Add more comprehensive parameters
      await provider.loadProducts(
        reset: true,
        sortOrder: 'asc',
        // themeName: 'GROC', // Explicitly specify theme
        // limit: 240, // Specify a limit if needed
      );

      // Log detailed information about loaded products
      AppLogger.logInfo('[HomeScreen] Products loaded');
      AppLogger.logInfo(
          '[HomeScreen] Best sellers count: ${provider.currentState.bestSellerProducts.length}');
      AppLogger.logInfo(
          '[HomeScreen] Total products count: ${provider.currentState.products.length}');

      // Check for any errors
      if (provider.error != null) {
        AppLogger.logError(
            '[HomeScreen] Products loading error: ${provider.error}');
      }

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      AppLogger.logError('[HomeScreen] Comprehensive error loading data: $e');

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        // Show a more informative error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load data: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _refreshData() async {
    if (_isRefreshing) return;
    AppLogger.logInfo('[HomeScreen] Refreshing data');
    setState(() {
      _isRefreshing = true;
    });
    try {
      final provider = context.read<ProductsProvider>();
      final categoryProvider = context.read<CategoriesProvider>();
      await Future.wait([
        categoryProvider.loadCategories('GROC'),
        provider.refresh(),
      ]);
    } catch (e) {
      AppLogger.logError('[HomeScreen] Error refreshing data: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isRefreshing = false;
        });
      }
    }
  }

  Future<void> _loadMoreData() async {
    final provider = context.read<ProductsProvider>();
    if (!provider.currentState.hasMoreProducts || provider.isLoadingMore) {
      return;
    }
    try {
      await provider.loadMoreProducts();
    } catch (e) {
      AppLogger.logError('[HomeScreen] Error loading more data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Must call super.build to ensure the mixin works correctly
    super.build(context);

    return Consumer2<ProductsProvider, CategoriesProvider>(
      builder: (context, productsProvider, categoriesProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: ShimmerEffect(
              isLoading: _isLoading,
              child: _buildHomeContent(productsProvider, categoriesProvider),
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: greenShadowDecoration,
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          title: _buildLocationTitle(context),
          actions: _buildAppBarActions(),
        ),
      ),
    );
  }

  Widget _buildLocationTitle(BuildContext context) {
    return Consumer<AddressProvider>(
      builder: (context, addressProvider, child) {
        final selectedAddress = addressProvider.selectedAddress;
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationScreen(),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_rounded,
                      color: Colors.green, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    selectedAddress?.title ?? 'Select Address',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  selectedAddress?.address ?? 'Tap to select address',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      const SearchIcon(),
      const SizedBox(width: 8),
      Padding(
        padding: const EdgeInsets.only(right: 24),
        child: SvgPicture.asset('assets/icons/shopping-bag.svg'),
      ),
    ];
  }

  Widget _buildHomeContent(ProductsProvider productsProvider,
      CategoriesProvider categoriesProvider) {
    return ListView(
      controller: _scrollController,
      children: [
        _buildOfferBanner(), //1st Offer
        CategoryFirstLevelWidgets(), //2nd Category
        _buildAddBanners(), //3rd Ads banner
        BestSellingWidget(), //4th Selling widget
        _buildAddOffers(), //5th Ads Offers
        Image.asset('assets/images/group.png'),
        _buildCustomMix(),
        _buildChoiceVariants(),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            width: double.infinity,
            height: 279,
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 160,
                      // width: size.width * 0.7,
                      child: Image.asset('assets/images/Frame 5.png'),
                    ),
                  ],
                ),
                Positioned(
                  right: -10,
                  left: -10,
                  top: 180,
                  child: SizedBox(
                    // width: size.width * 1,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: 1500,
                          height: 400,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(21, 182, 141, 1),
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Image.asset('assets/images/MC3 1.png'),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 30,
                  top: 70,
                  child: SizedBox(
                      height: 280,
                      width: 280,
                      child: Image.asset('assets/images/MC3 1.png')),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 382,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/bottom_1.png',
                  // height: 100, // Set your desired height
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/image_24.png',
                  // height: 100, // Set your desired height
                ),
                const SizedBox(width: 8),
                Image.asset(
                  'assets/images/image_25.png',
                  // height: 100, // Set your desired height
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOfferBanner() {
    return Container(
      width: double.infinity,
      height: 36,
      color: const Color.fromRGBO(226, 241, 232, 1),
      child: const Center(
        child: Text(
          "get up to 30% off on first order",
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(21, 182, 141, 1),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomMix() {
    return Container(
      color: Color.fromRGBO(21, 182, 141, 1),
      // color: hexColor(),
      child: Stack(
        children: [
          // Background image with solid green color applied using ColorFilter
          // ColorFiltered(
          // colorFilter: ColorFilter.mode(
          //   // Colors.green, // Solid green color
          //   // Color.fromRGBO(166, 216, 186, 1), // Solid green color
          //   // BlendMode.modulate, // This blends the color with the image
          // ),
          // child:
          Image.asset(
            'assets/images/mix_background.png',
            fit: BoxFit.cover,
          ),
          // ),
          // Background image
          // Image.asset(
          //   'assets/images/mix_background.png',
          //   fit: BoxFit.cover,
          // ),
          // // Solid green background overlay
          // Positioned.fill(
          //   child: Container(
          //     color: Color.fromRGBO(166, 216, 186, 1), // Solid green color
          //   ),
          // ),
          // Foreground green image with margin
          Positioned(
            // left: 16, // 16 margin from the left
            top: 16, // 16 margin from the top (optional, adjust as needed)
            child: SizedBox(
              height: 340,
              width: 370,
              child: Image.asset('assets/images/mix_green.png'),
            ),
          ),
          // Foreground weat image positioned at left center
          Positioned(
            left: -32,
            top: 80,
            child: SizedBox(
              height: 200, // Adjust the height as necessary
              width: 220, // Adjust the width as necessary
              child: Image.asset('assets/images/mix_weat.png'),
            ),
          ),
          Container(
            height: 67,
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Circular clickable area
              color: Color.fromRGBO(239, 164, 200, 1),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "CUSTOMIZE YOUR MIX",
                  style: GlobalTextStyles.qs22w7black,
                  // style: TextStyle(
                  //   fontSize: 9,
                  //   fontWeight: FontWeight.w500,
                  //   color: Color.fromRGBO(21, 182, 141, 1),
                  // ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 74,
            top: 90,
            child: SizedBox(
              height: 252, // Adjust the height as necessary
              width: 218, // Adjust the width as necessary
              child: Image.asset('assets/images/mix_jar.png'),
            ),
          ),

          Positioned(
              left: 0,
              top: 400,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 200, // Height of the container
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 19,
                          width: 19,
                          child: Image.asset('assets/icons/arrow_left.png')),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 101,
                              width: 88,
                              child: Image.asset('assets/images/mix_jar.png')),
                          const SizedBox(width: 8),
                          Text(
                            'Wheat',
                            style: GlobalTextStyles.small6Black,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(239, 164, 200, 1),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(78, 28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Qty',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        width: 19,
                        child: Text(
                          '+',
                          style: GlobalTextStyles.qs32w6Black,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 101,
                              width: 88,
                              child: Image.asset('assets/images/mix_jar.png')),
                          const SizedBox(width: 8),
                          Text(
                            'Wheat',
                            style: GlobalTextStyles.small6Black,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(239, 164, 200, 1),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(78, 28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Qty',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 40,
                        width: 19,
                        child: Text(
                          '+',
                          style: GlobalTextStyles.qs32w6Black,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 101,
                              width: 88,
                              child: Image.asset('assets/images/mix_jar.png')),
                          const SizedBox(width: 8),
                          Text(
                            'Wheat',
                            style: GlobalTextStyles.small6Black,
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(239, 164, 200, 1),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(78, 28),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Qty',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                // color: Color.fromRGBO(239, 164, 200, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                          height: 40,
                          width: 19,
                          child: Image.asset('assets/icons/arrow_right.png')),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildChoiceVariants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 32),
        Text(
          'Explore the various choices',
          style: GlobalTextStyles.qs22w7black,
        ),
        const SizedBox(height: 8),
        Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 4, // horizontal spacing
            // runSpacing: 2, // vertical spacing between lines
            children: [
              _buildChoiceButton('Spinach', isActive: true),
              _buildChoiceButton('Beetroot'),
              _buildChoiceButton('Carrot'),
              _buildChoiceButton('Potato'),
              _buildChoiceButton('Spinach'),
              _buildChoiceButton('Spinach'),
              _buildChoiceButton('Beetroot'),
              _buildChoiceButton('Carrot'),
              _buildChoiceButton('Potato'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChoiceButton(String text, {bool isActive = false}) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isActive ? const Color(0xFF4FA56F) : const Color(0xFFE2F1E8),
        foregroundColor: isActive ? Colors.white : const Color(0xFF4FA56F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        minimumSize: const Size(0, 27),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildCategoryItem('assets/images/catg_png.png', 'Flours'),
              SizedBox(width: 4), // Space between items
              _buildCategoryItem('assets/images/cat_png.png', 'Pickles'),
              SizedBox(width: 4),
              _buildCategoryItem('assets/images/catg_png.png', 'Chapati'),
              SizedBox(width: 4),
              _buildCategoryItem('assets/images/cat_png.png', 'Flours'),
              SizedBox(width: 4),
              _buildCategoryItem('assets/images/catg_png.png', 'Snacks'),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper method to build category items
  Widget _buildCategoryItem(String? imagePath, String categoryName) {
    return Column(
      children: [
        SizedBox(
          height: 80,
          width: 70,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Green circular background
              Positioned(
                bottom: 0,
                left: 5,
                child: Container(
                  width: 40,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
              // Product image with fixed dimensions
              Positioned(
                top: 0,
                left: 0,
                right: 10,
                bottom: 12,
                child: SizedBox(
                  height: 30,
                  // width: 40,
                  child: imagePath != null && imagePath.isNotEmpty
                      ? Image.asset(
                          imagePath,
                          fit: BoxFit.contain,
                          width: 60, // Fixed width for all images
                          height: 80, // Fixed height for all images
                          // Add error builder to handle loading issues
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.image_not_supported,
                              color: Colors.grey[400],
                              size: 24,
                            );
                          },
                        )
                      : Icon(
                          Icons.image_not_supported,
                          color: Colors.grey[400],
                          size: 24,
                        ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(height: 8),
        Text(
          categoryName,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAddBanners() {
    final PageController pageController = PageController();
    final List<Map<String, Map<String, String>>> bannerData = [
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
    ];

    return SizedBox(
      height: 197,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -64,
            right: -32,
            child: Image.asset(
              'assets/images/grains 1.png',
              height: 138,
              width: 146,
            ),
          ),
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: bannerData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Stack(
                  children: [
                    Container(
                      height: 197,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(
                              bannerData[index]['content']!['image']!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 24,
                      child: SizedBox(
                        width: 160,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main title
                            Text(
                              bannerData[index]['content']!['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                height: 1.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: GlobalTextStyles.quicksandFont,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Subtitle
                            Text(
                              bannerData[index]['content']!['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                height: 1.2,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     bannerData.length,
          //     (index) => Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 4),
          //       height: 8,
          //       width: 8,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: pageController.hasClients &&
          //                 pageController.page?.round() == index
          //             ? Colors.black
          //             : Colors.black.withOpacity(0.5),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: bannerData.length,
                effect: const ScrollingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Color.fromRGBO(255, 255, 255, 1),
                    dotColor: Color.fromRGBO(248, 250, 252, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddOffers() {
    final PageController pageController = PageController();
    final List<Map<String, Map<String, String>>> offerData = [
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
      {
        'content': {
          'title': 'Lorem ipsum dolor\nsit amet',
          'subtitle': 'Lorem ipsum dolor\nsit amet',
          'image': 'assets/images/add_banner.png',
        }
      },
    ];

    return SizedBox(
      height: 133,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemCount: offerData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Stack(
                  children: [
                    Container(
                      height: 133,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        image: DecorationImage(
                          image: AssetImage(
                              offerData[index]['content']!['image']!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 24,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Main title
                            Text(
                              offerData[index]['content']!['title']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                height: 1.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: GlobalTextStyles.quicksandFont,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Subtitle
                            Text(
                              offerData[index]['content']!['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Subtitle
                            Text(
                              offerData[index]['content']!['subtitle']!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                height: 1,
                                fontWeight: FontWeight.w400,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset(2, 2),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: List.generate(
          //     bannerData.length,
          //     (index) => Container(
          //       margin: const EdgeInsets.symmetric(horizontal: 4),
          //       height: 8,
          //       width: 8,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: pageController.hasClients &&
          //                 pageController.page?.round() == index
          //             ? Colors.black
          //             : Colors.black.withOpacity(0.5),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: offerData.length,
                effect: const ScrollingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: Color.fromRGBO(255, 255, 255, 1),
                    dotColor: Color.fromRGBO(248, 250, 252, 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
