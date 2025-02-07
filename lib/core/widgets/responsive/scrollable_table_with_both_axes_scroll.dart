import 'package:flutter/material.dart';

import 'responsive_utils.dart'; // Import the reusable common file

class ScrollableTableWithBothAxes extends StatelessWidget {
  final List<String> columnHeaders;
  final List<List<String>> rowData;
  final double rowPadding;
  final Color borderColor;
  final double tableHeight;

  const ScrollableTableWithBothAxes({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.rowPadding = 8.0,
    this.borderColor = Colors.white,
    this.tableHeight = 300.0,
  });

  @override
  Widget build(BuildContext context) {
    // Use ResponsiveUtils to get screen width
    double screenWidth = ResponsiveUtils.screenWidth(context);

    // Calculate total column width
    double totalColumnWidth =
        columnHeaders.length * 100 + (columnHeaders.length - 1) * rowPadding;

    return SizedBox(
      height: tableHeight,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _buildTable(context, screenWidth, totalColumnWidth),
      ),
    );
  }

  Widget _buildTable(
      BuildContext context, double screenWidth, double totalColumnWidth) {
    // Determine column width based on screen size
    double columnWidth = totalColumnWidth > screenWidth
        ? 100.0
        : screenWidth / columnHeaders.length;

    return Column(
      children: [
        // Fixed Header Row
        Row(
          children: columnHeaders.map((header) {
            return Container(
              width: columnWidth,
              padding: EdgeInsets.all(rowPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: borderColor),
              ),
              child: Text(
                header,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.adaptiveFontSize(context, 14.0),
                ),
              ),
            );
          }).toList(),
        ),
        // Scrollable Rows
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: rowData.map((row) {
                return Row(
                  children: row.map((cell) {
                    return Container(
                      width: columnWidth,
                      padding: EdgeInsets.all(rowPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 16,
                        ),
                        child: Text(
                          cell,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                            fontSize:
                                ResponsiveUtils.adaptiveFontSize(context, 14.0),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
