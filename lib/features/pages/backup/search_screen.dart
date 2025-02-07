// import 'package:flutter/material.dart';
//
// import '../../../../core/wotw/searchbar/search_anchor/widget/search_anchor_widget.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final SearchController _searchAnchorController = SearchController();
//
//   List<Map<String, dynamic>> recentSearches = [
//     {'label': 'Seafood', 'isActive': true},
//     {'label': 'Meat, fish', 'isActive': false},
//     {'label': 'Vegetable', 'isActive': false},
//     {'label': 'Fruit imported', 'isActive': false},
//     {'label': 'Pizza', 'isActive': false},
//     {'label': 'Burgers', 'isActive': false},
//     {'label': 'Bread', 'isActive': false},
//     {'label': 'Vegetable', 'isActive': false},
//     {'label': 'Drinks', 'isActive': false},
//     {'label': 'Diet Food', 'isActive': false},
//   ];
//
//   @override
//   void dispose() {
//     _searchAnchorController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF4FA56F).withOpacity(0.1),
//                 offset: const Offset(0, 2),
//                 blurRadius: 4,
//               ),
//             ],
//           ),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.location_on_rounded,
//                       color: Color(0xFF4FA56F),
//                       size: 16,
//                     ),
//                     const SizedBox(width: 4),
//                     const Text(
//                       'Hyderabad,',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     const SizedBox(width: 4),
//                     const Text(
//                       'Prathab',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20.0),
//                   child: Text(
//                     "Simply Dummy Text Of The Prin...",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w400,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: Container(
//                   width: 40,
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFE8F5EC),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Icon(
//                     Icons.notifications_outlined,
//                     color: Color(0xFF4FA56F),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SearchAnchorWidget(
//         barBackgroundColor: const Color(0xFFF8FAFB),
//         barElevation: 0,
//         viewBackgroundColor: Colors.white,
//         viewElevation: 4,
//         viewShape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         suggestionsBuilder: (context, controller) {
//           return [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Recent Search',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF413D32),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Wrap(
//                     spacing: 8,
//                     runSpacing: 12,
//                     children: recentSearches.map((search) {
//                       return InkWell(
//                         onTap: () {
//                           controller.closeView(search['label']);
//                           // Handle search selection
//                           setState(() {
//                             // Update active state
//                             for (var item in recentSearches) {
//                               item['isActive'] =
//                                   item['label'] == search['label'];
//                             }
//                           });
//                         },
//                         child: _buildSearchChip(
//                           search['label'],
//                           search['isActive'],
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//         },
//       ),
//     );
//   }
//
//   Widget _buildSearchChip(String label, bool isActive) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isActive ? const Color(0xFF4FA56F) : Colors.white,
//         border: Border.all(
//           color: isActive ? Colors.transparent : const Color(0xFF8A8D9F),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 14,
//           color: isActive ? Colors.white : const Color(0xFF413D32),
//         ),
//       ),
//     );
//   }
// }

// SearchScreen implementation:
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../../../../core/decoration/single_side_shadow_decoration.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocus = FocusNode();
//
//   List<Map<String, dynamic>> recentSearches = [
//     {'label': 'Seafood', 'isActive': true},
//     {'label': 'Meat, fish', 'isActive': false},
//     {'label': 'Vegetable', 'isActive': false},
//     {'label': 'Fruit imported', 'isActive': false},
//     {'label': 'Pizza', 'isActive': false},
//     {'label': 'Burgers', 'isActive': false},
//     {'label': 'Bread', 'isActive': false},
//     {'label': 'Vegetable', 'isActive': false},
//     {'label': 'Drinks', 'isActive': false},
//     {'label': 'Diet Food', 'isActive': false},
//   ];
//
//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocus.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: Container(
//           decoration: greenShadowDecoration,
//           child: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.location_on_rounded,
//                         color: Color(0xFF4FA56F), size: 16),
//                     const SizedBox(width: 4),
//                     const Text('Hyderabad,',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700)),
//                     const SizedBox(width: 4),
//                     const Text('Prathab',
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400)),
//                   ],
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.only(left: 20.0),
//                   child: Text(
//                     "Simply Dummy Text Of The Prin...",
//                     style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: SvgPicture.asset(
//                   'assets/icons/notification.svg',
//                   width: 24,
//                   height: 24,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           _buildSearchBar(),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 24),
//                     const Text(
//                       'Recent Search',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: Color(0xFF413D32),
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 12,
//                       children: recentSearches
//                           .map((search) => _buildSearchChip(
//                               search['label'], search['isActive']))
//                           .toList(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             offset: const Offset(0, 2),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               height: 48,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF8FAFB),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: TextField(
//                 controller: _searchController,
//                 focusNode: _searchFocus,
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   hintStyle: const TextStyle(
//                     color: Color(0xFF8A8D9F),
//                     fontSize: 16,
//                   ),
//                   prefixIcon: Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: SvgPicture.asset(
//                       'assets/icons/ic_search.svg',
//                       width: 20,
//                       height: 20,
//                     ),
//                   ),
//                   suffixIcon: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       if (_searchController.text.isNotEmpty)
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               _searchController.clear();
//                             });
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: const BoxDecoration(
//                               color: Color(0xFFFFE8E8),
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.close,
//                               color: Color(0xFFFF0000),
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                       const SizedBox(width: 8),
//                     ],
//                   ),
//                   border: InputBorder.none,
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                 ),
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSearchChip(String label, bool isActive) {
//     return Container(
//       decoration: BoxDecoration(
//         color: isActive ? const Color(0xFF4FA56F) : Colors.white,
//         border: Border.all(
//           color: const Color(0xFF8A8D9F),
//           width: 1,
//         ),
//         borderRadius: BorderRadius.circular(24),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: isActive ? Colors.white : const Color(0xFF413D32),
//           ),
//         ),
//       ),
//     );
//   }
// }
