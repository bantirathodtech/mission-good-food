// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class SearchPopup extends StatefulWidget {
//   const SearchPopup({super.key});
//
//   @override
//   State<SearchPopup> createState() => _SearchPopupState();
// }
//
// class _SearchPopupState extends State<SearchPopup> {
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
//     return Dialog(
//       insetPadding: EdgeInsets.zero,
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: double.infinity,
//         margin: const EdgeInsets.only(top: kToolbarHeight + 20),
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(16),
//             topRight: Radius.circular(16),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _buildSearchBar(),
//             AnimatedCrossFade(
//               firstChild: _buildRecentSearches(),
//               secondChild: _buildSearchResults(),
//               crossFadeState: _searchController.text.isEmpty
//                   ? CrossFadeState.showFirst
//                   : CrossFadeState.showSecond,
//               duration: const Duration(milliseconds: 300),
//             ),
//           ],
//         ),
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
//                 autofocus: true,
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
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           padding: const EdgeInsets.all(8),
//                           child: const Icon(
//                             Icons.close,
//                             color: Colors.black54,
//                             size: 24,
//                           ),
//                         ),
//                       ),
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
//   Widget _buildRecentSearches() {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.6,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Recent Search',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF413D32),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Wrap(
//                 spacing: 8,
//                 runSpacing: 12,
//                 children: recentSearches.map((search) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         for (var item in recentSearches) {
//                           item['isActive'] = item['label'] == search['label'];
//                         }
//                         _searchController.text = search['label'];
//                       });
//                     },
//                     child: _buildSearchChip(
//                       search['label'],
//                       search['isActive'],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSearchResults() {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.6,
//       ),
//       child: ListView.builder(
//         shrinkWrap: true,
//         padding: const EdgeInsets.symmetric(vertical: 8),
//         itemCount: 5, // Replace with actual search results
//         itemBuilder: (context, index) {
//           return ListTile(
//             leading: const Icon(Icons.search, color: Colors.grey),
//             title: Text(
//               '${_searchController.text} result ${index + 1}',
//               style: const TextStyle(fontSize: 16),
//             ),
//             onTap: () {
//               // Handle search result selection
//               Navigator.pop(context);
//             },
//           );
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
//
// // Usage:
// void showSearchPopup(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierColor: Colors.black54,
//     builder: (BuildContext context) {
//       return const SearchPopup();
//     },
//   );
// }
//
// // Update your GestureDetector to use this:
