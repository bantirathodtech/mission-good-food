import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SingleDateCalendarPopup extends StatefulWidget {
  final Function(DateTime?) onDateSelected;
  final DateTime? initialDate;
  final String title;

  const SingleDateCalendarPopup({
    super.key,
    required this.onDateSelected,
    this.initialDate,
    required this.title,
  });

  @override
  State<SingleDateCalendarPopup> createState() =>
      _SingleDateCalendarPopupState();
}

class _SingleDateCalendarPopupState extends State<SingleDateCalendarPopup> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 700,
          maxHeight: 900,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Single date display box
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE0E0E0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatDate(_selectedDate),
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            // Calendar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                  selectedDayHighlightColor: const Color(0xFF4CAF50),
                  weekdayLabelTextStyle: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  dayTextStyle: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  selectedDayTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  dayBorderRadius: BorderRadius.circular(100),
                  centerAlignModePicker: true,
                  customModePickerIcon: Container(),
                  firstDayOfWeek: 1,
                ),
                value: _selectedDate != null ? [_selectedDate] : [],
                onValueChanged: (dates) {
                  setState(() {
                    _selectedDate = dates.first;
                  });
                },
              ),
            ),
            // Buttons
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Color(0xFFE0E0E0),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          widget.onDateSelected(_selectedDate);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Apply',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
