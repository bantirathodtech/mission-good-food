import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeCalendarPopup extends StatefulWidget {
  final Function(List<DateTime?>) onDateRangeSelected;
  final List<DateTime?>? initialDates;

  const DateRangeCalendarPopup({
    super.key,
    required this.onDateRangeSelected,
    this.initialDates,
  });

  @override
  State<DateRangeCalendarPopup> createState() => _DateRangeCalendarPopupState();
}

class _DateRangeCalendarPopupState extends State<DateRangeCalendarPopup> {
  List<DateTime?> _selectedDates = [];

  @override
  void initState() {
    super.initState();
    _selectedDates = widget.initialDates ?? [];
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('MMM d, yyyy').format(date);
  }

  Widget _buildDateBox(DateTime? date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _formatDate(date),
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
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
          maxWidth: 360, // Match image width
          maxHeight: 520, // Match image height
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Date range display boxes
              Row(
                children: [
                  Expanded(
                    child: _buildDateBox(
                      _selectedDates.isNotEmpty ? _selectedDates[0] : null,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '—',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildDateBox(
                      _selectedDates.length > 1 ? _selectedDates[1] : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Calendar
              Expanded(
                child: CalendarDatePicker2(
                  config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range,
                    selectedDayHighlightColor: const Color(0xFF4CAF50),
                    selectedRangeHighlightColor: const Color(0xFFE8F5E9),
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
                    selectedRangeDayTextStyle: const TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    dayBorderRadius: BorderRadius.circular(100),
                    centerAlignModePicker: true,
                    customModePickerIcon: Container(),
                    firstDayOfWeek: 1, // Monday
                    controlsTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  value: _selectedDates,
                  onValueChanged: (dates) {
                    setState(() {
                      _selectedDates = dates;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
                        widget.onDateRangeSelected(_selectedDates);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CAF50),
                        padding: const EdgeInsets.symmetric(vertical: 12),
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
            ],
          ),
        ),
      ),
    );
  }
}

// Usage example:
/*
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
}*/
