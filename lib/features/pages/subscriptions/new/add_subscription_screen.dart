import 'package:flutter/material.dart';
import 'package:good_food_app/core/calendar/single_date_calendar_popup.dart';
import 'package:good_food_app/features/pages/subscriptions/new/subscription_new_card.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../../products/model/document.dart';

class AddSubscriptionScreen extends StatefulWidget {
  final Document product;
  const AddSubscriptionScreen({super.key, required this.product});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  // late List<ProductModel> favoriteProducts;
  String selectedSchedule = 'Someday';
  String selectedInstantOption = '';
  List<bool> selectedDays = [
    true,
    false,
    true,
    true,
    false,
    false,
    false
  ]; // S,M,T,W,Th,F,S
  int quantity = 1;
  String selectedWeight = '500 g';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 30));
  // DateTime startDate = DateTime(2023, 8, 6);
  // DateTime endDate = DateTime(2023, 8, 13);

  // @override
  // void initState() {
  //   super.initState();
  //   // favoriteProducts = [
  //   //   ProductModel(
  //   //       productName: 'Whole Wheat Flour Chakki 1 kg',
  //   //       productPrice: 299,
  //   //       productImage: 'assets/images/whole_wheat_1.png',
  //   //       productQty: 1,
  //   //       isFavorite: true,
  //   //       rate: 4.3,
  //   //       totalRating: 1533),
  //   //   // ... other products
  //   // ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Container(
          decoration: greenShadowDecoration,
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Text('Add Subscriptions', style: GlobalTextStyles.qsTitle),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubscriptionNewCard(product: widget.product),
                    // Product Cards
                    // ...favoriteProducts.map((product) => SubscriptionNewCard(
                    //       product: product,
                    //     )),
                    const SizedBox(height: 24),

                    // Delivery Schedule Section
                    Text('Personalize Your Delivery Schedule',
                        style: GlobalTextStyles.qs16w7Black
                        // const TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w700,
                        //   color: Colors.black,
                        // ),
                        ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildChoiceButton(
                            'Everyday', selectedSchedule == 'Everyday'),
                        _buildChoiceButton('Alternate Days',
                            selectedSchedule == 'Alternate Days'),
                        _buildChoiceButton(
                            'Someday', selectedSchedule == 'Someday'),
                        _buildChoiceButton(
                            'Weekly', selectedSchedule == 'Weekly'),
                        _buildChoiceButton(
                            'Biweekly', selectedSchedule == 'Biweekly'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Instant Options Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Instant Options',
                            style: GlobalTextStyles.qs16w7Black),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildRadioOption('Weekends'),
                            const SizedBox(width: 8),
                            _buildRadioOption('Weekdays'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Delivery Days Section
                    Text('Select days you want your products to be delivered',
                        style: GlobalTextStyles.qs16w7Black
                        // const TextStyle(
                        //   fontSize: 16,
                        //   fontWeight: FontWeight.w700,
                        //   color: Colors.black,
                        // ),
                        ),
                    const SizedBox(height: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDaySelector('S', 0),
                            _buildDaySelector('M', 1),
                            _buildDaySelector('T', 2),
                            _buildDaySelector('W', 3),
                            _buildDaySelector('Th', 4),
                            _buildDaySelector('F', 5),
                            _buildDaySelector('S', 6),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Quantity and Weight Section
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select Quantity',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(65, 61, 50, 1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 34,
                                width: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(138, 141, 159, 1)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (quantity > 0) quantity--;
                                        });
                                      },
                                      child: Icon(Icons.remove, size: 18),
                                    ),
                                    Text(
                                      '$quantity',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      child: Icon(Icons.add, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Net Weight',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(65, 61, 50, 1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                height: 34,
                                width: 140,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromRGBO(138, 141, 159, 1)!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: DropdownButton<String>(
                                  value: selectedWeight,
                                  isExpanded: true,
                                  underline: Container(),
                                  icon: const Icon(
                                      Icons.keyboard_arrow_down_sharp),
                                  items: ['500 g', '1 kg', '2 kg']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedWeight = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Date Selection Section
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start from',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(65, 61, 50, 1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: showStartDatePicker,
                                child: Container(
                                  height: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(138, 141, 159, 1)!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Text(
                                    '${startDate.day.toString().padLeft(2, '0')}/${startDate.month.toString().padLeft(2, '0')}/${startDate.year}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(65, 61, 50, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End on',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(65, 61, 50, 1),
                                ),
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                onTap: showEndDatePicker,
                                child: Container(
                                  height: 34,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(138, 141, 159, 1)!),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: Text(
                                    '${endDate.day.toString().padLeft(2, '0')}/${endDate.month.toString().padLeft(2, '0')}/${endDate.year}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(65, 61, 50, 1),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Delivery Notice
                    Text(
                      'Hassle-Free Next Morning Delivery:',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(57, 61, 70, 1),
                      ),
                    ),
                    Text(
                      'Place Orders by 8:00 PM!',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(57, 61, 70, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Proceed Button
          Container(
            width: double.infinity,
            height: 44,
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                // MaterialPageRoute(
                //   builder: (context) => ProductDetailsScreen(
                //     // product: favoriteProducts.first,
                //     product: product,
                //   ),
                // ),
                // );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4FA56F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Proceed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceButton(String text, bool isActive) {
    return ElevatedButton(
      onPressed: () => setState(() => selectedSchedule = text),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive
            ? const Color.fromRGBO(79, 165, 111, 1)
            : const Color.fromRGBO(226, 241, 232, 1),
        foregroundColor:
            isActive ? Colors.white : const Color.fromRGBO(138, 153, 150, 1),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildRadioOption(String text) {
    return Row(
      children: [
        Radio(
          value: text,
          groupValue: selectedInstantOption,
          onChanged: (value) =>
              setState(() => selectedInstantOption = value.toString()),
          activeColor: const Color(0xFF4FA56F),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const SizedBox(width: 8),
        Text(text, style: GlobalTextStyles.regular4Black),
      ],
    );
  }

  Widget _buildDaySelector(String day, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedDays[index] = !selectedDays[index]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color:
                  selectedDays[index] ? const Color(0xFF4FA56F) : Colors.white,
              border: Border.all(
                color: selectedDays[index]
                    ? const Color(0xFF4FA56F)
                    : Color.fromRGBO(138, 141, 159, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              day,
              style: TextStyle(
                color: selectedDays[index]
                    ? Colors.white
                    : Color.fromRGBO(65, 61, 50, 1),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            selectedDays[index] ? '1' : '0',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(39, 34, 22, 1),
            ),
          )
        ],
      ),
    );
  }

  void showStartDatePicker() {
    showDialog(
      context: context,
      builder: (context) => SingleDateCalendarPopup(
        initialDate: startDate,
        title: 'Start Date',
        onDateSelected: (date) {
          if (date != null) {
            setState(() {
              startDate = date;
              // Ensure end date is not before start date
              if (endDate.isBefore(startDate)) {
                endDate = startDate.add(const Duration(days: 1));
              }
            });
          }
        },
      ),
    );
  }

  void showEndDatePicker() {
    showDialog(
      context: context,
      builder: (context) => SingleDateCalendarPopup(
        initialDate: endDate,
        title: 'End Date',
        onDateSelected: (date) {
          if (date != null) {
            setState(() {
              endDate = date;
              // Ensure start date is not after end date
              if (startDate.isAfter(endDate)) {
                startDate = endDate.subtract(const Duration(days: 1));
              }
            });
          }
        },
      ),
    );
  }
}
