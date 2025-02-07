import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/core/calendar/date_range_calendar.dart';
import 'package:good_food_app/core/theme/text_styles/global_text_style.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../screens/tabs/home/model/product_model.dart';

class SubscriptionCard extends StatefulWidget {
  final ProductModel product;

  const SubscriptionCard({super.key, required this.product});

  @override
  State<SubscriptionCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<SubscriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(228, 242, 228, 0.6),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Product Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.product.productImage,
                    width: 114,
                    height: 114,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.productName,
                        style: GlobalTextStyles.qs16w7Black,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '₹${widget.product.productPrice}',
                            style: GlobalTextStyles.regular7Black,
                          ),
                          // const SizedBox(width: 4),

                          Text(
                            '(${widget.product.productQty} kg)',
                            style: GlobalTextStyles.tiny4Black,
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: 16,
                            color: Color.fromRGBO(240, 242, 245, 1),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.product.rate}',
                                style: GlobalTextStyles.tiny4Black,
                              ),
                              Text(
                                ' (${widget.product.totalRating})',
                                style: GlobalTextStyles.tiny4Black,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '6th July - 13th July, 2023',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color.fromRGBO(240, 241, 245, 1)),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  // icon: Icons.pause_circle_outline,
                  icon: SvgPicture.asset('assets/icons/pause_circle.svg'),
                  label: 'Pause',
                  // color: const Color(0xFFFFA726),
                  color: Color.fromRGBO(65, 61, 50, 1),
                  onTap: () {
                    // Handle pause
                  },
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: const Color.fromRGBO(240, 241, 245, 1),
                ),
                _buildActionButton(
                  // icon: Icons.edit_outlined,
                  icon: SvgPicture.asset('assets/icons/edit.svg'),
                  label: 'Modify',
                  color: Color.fromRGBO(65, 61, 50, 1),
                  onTap: () {
                    // Handle modify
                    // _showDateSelectionDialog(context);
                    // showDateRangePopup(context);
                    showDateRangePopup(context);
                  },
                ),
                Container(
                  width: 1,
                  height: 24,
                  // color: const Color(0xFFF0F1F5),
                  color: Color.fromRGBO(240, 241, 245, 1),
                ),
                _buildActionButton(
                  // icon: Icons.delete_outline,
                  icon: SvgPicture.asset('assets/icons/trash.svg'),
                  label: 'Delete',
                  // color: Colors.red,
                  color: Color.fromRGBO(65, 61, 50, 1),
                  onTap: () {
                    _showDeleteConfirmationDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required Widget icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(height: 20, width: 20, child: icon),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: HexColor("#F0F0F0"),
          child: SizedBox(
            width: 315,
            height: 201,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Are you sure\nyou want to delete?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF262B2E),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFEFA4C8),
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: GlobalTextStyles.roboto16w7White,
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Handle delete action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4FA56F),
                          minimumSize: const Size(130, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Sure',
                          style: GlobalTextStyles.roboto16w7White,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void showDateRangePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DateRangeCalendarPopup(
        onDateRangeSelected: (dates) {
          if (dates.length == 2) {
            final startDate = dates[0];
            final endDate = dates[1];
            print('Selected range: $startDate to $endDate');
          }
        },
      ),
    );
  }

  void _showDateSelectionDialog(BuildContext context) async {
    // Define initial date range
    List<DateTime?> _dialogCalendarPickerValue = [
      DateTime(2022, 1, 6),
      DateTime(2022, 1, 13),
    ];

    final values = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        selectedDayHighlightColor: const Color(0xFF4FA56F),
        selectedRangeHighlightColor: const Color(0xFF4FA56F).withOpacity(0.1),
        centerAlignModePicker: true,
        customModePickerIcon: const SizedBox(),
        lastMonthIcon: const Icon(Icons.chevron_left),
        nextMonthIcon: const Icon(Icons.chevron_right),
        dayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
        ),
        selectedDayTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 15,
        ),
        // Custom buttons styling
        cancelButtonTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        okButtonTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        // Buttons customization
        cancelButton: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const Text('Cancel'),
        ),
        okButton: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF4FA56F),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const Text('Apply'),
        ),
        // Layout customization
        gapBetweenCalendarAndButtons: 16,
        dayBorderRadius: BorderRadius.circular(8),
      ),
      dialogSize: const Size(328, 520),
      borderRadius: BorderRadius.circular(8),
      value: _dialogCalendarPickerValue,
      dialogBackgroundColor: Colors.white,
    );

    if (values != null) {
      // Handle the selected date range
      setState(() {
        _dialogCalendarPickerValue = values;
      });
    }
  }
}
