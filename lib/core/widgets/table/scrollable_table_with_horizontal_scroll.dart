import 'package:flutter/material.dart';

class ScrollableTableWithHorizontalScroll extends StatelessWidget {
  final List<String> columnHeaders;
  final List<List<String>> rowData;
  final double rowPadding;
  final Color borderColor;

  const ScrollableTableWithHorizontalScroll({
    super.key,
    required this.columnHeaders,
    required this.rowData,
    this.rowPadding = 8.0,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: DataTable(
              columnSpacing: 0,
              dataRowMinHeight: 48.0,
              dataRowMaxHeight: 48.0,
              headingRowHeight: 40,
              horizontalMargin: 0,
              columns: columnHeaders.map((header) {
                return DataColumn(
                  label: Expanded(
                    child: Container(
                      padding: EdgeInsets.all(rowPadding),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: borderColor),
                      ),
                      child: Text(header),
                    ),
                  ),
                );
              }).toList(),
              rows: rowData.map((row) {
                return DataRow(
                  cells: row.map((cell) {
                    return DataCell(
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(rowPadding),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: borderColor),
                          ),
                          child: Text(cell),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
