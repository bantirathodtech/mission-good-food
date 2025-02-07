// import 'package:flutter/material.dart';
//
// class ScrollableTableWithBothAxes extends StatelessWidget {
//   // Properties for column headers, row data, padding, border color, and table height
//   final List<String> columnHeaders;
//   final List<List<String>> rowData;
//   final double rowPadding;
//   final Color borderColor;
//   final double tableHeight;
//
//   const ScrollableTableWithBothAxes({
//     super.key,
//     required this.columnHeaders, // Headers for the table columns
//     required this.rowData, // 2D list containing rows and their corresponding data
//     this.rowPadding = 8.0, // Padding for each cell
//     this.borderColor = Colors.white, // Border color for cells
//     this.tableHeight = 300.0, // Fixed height for the table
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // Calculate the total width required for all columns including padding
//     double totalColumnWidth =
//         columnHeaders.length * 100 + (columnHeaders.length - 1) * rowPadding;
//
//     // If total column width exceeds screen width, make the table horizontally scrollable
//     return SizedBox(
//       height: tableHeight, // Constrain the overall height of the table
//       child: SingleChildScrollView(
//         scrollDirection:
//             Axis.horizontal, // Enable horizontal scrolling if needed
//         child: _buildTable(screenWidth, totalColumnWidth),
//       ),
//     );
//   }
//
//   // Build the table with either stretched or scrollable columns
//   Widget _buildTable(double screenWidth, double totalColumnWidth) {
//     double columnWidth = totalColumnWidth > screenWidth
//         ? 100.0 // Fixed width per column when scrolling is enabled
//         : screenWidth / columnHeaders.length; // Dynamic width when it fits
//
//     return Column(
//       children: [
//         // Header row: fixed at the top
//         Row(
//           children: columnHeaders.map((header) {
//             return Container(
//               width: columnWidth, // Dynamic width for each column
//               padding: EdgeInsets.all(
//                   rowPadding), // Add padding inside the header cell
//               alignment: Alignment.center, // Center-align the text
//               decoration: BoxDecoration(
//                 color: Colors.grey[200], // Light grey background for headers
//                 border: Border.all(
//                     color: borderColor), // Add border to header cells
//               ),
//               child: Text(
//                 header, // Display the column header text
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold), // Bold style for headers
//               ),
//             );
//           }).toList(), // Map the headers to widgets
//         ),
//         // Container for table rows (vertical and horizontal scrolling)
//         Expanded(
//           // Ensure the rows are wrapped inside an expandable space
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical, // Allow vertical scrolling for rows
//             child: Column(
//               children: rowData.map((row) {
//                 return Row(
//                   children: row.map((cell) {
//                     return Container(
//                       width: columnWidth, // Dynamic width for each column
//                       padding: EdgeInsets.all(
//                           rowPadding), // Add padding inside row cells
//                       alignment: Alignment.center, // Center-align the text
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: borderColor), // Add border to row cells
//                       ),
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(
//                           minHeight: 16, // Set a minimum height for rows
//                         ),
//                         child: Text(
//                           cell, // Display the row cell data
//                           softWrap: true, // Allow text to wrap to the next line
//                           overflow: TextOverflow
//                               .visible, // Ensure text overflow wraps properly
//                         ),
//                       ),
//                     );
//                   }).toList(), // Map row data to widgets
//                 );
//               }).toList(), // Map each row to a widget
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
