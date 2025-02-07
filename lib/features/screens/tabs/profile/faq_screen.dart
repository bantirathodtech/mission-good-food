import 'package:flutter/material.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<bool> _expandedItems = [];

  final List<Map<String, String>> faqItems = [
    {
      'question': 'How to send my package',
      'answer':
          'Lorem ipsum, or lips um as it is sometime known, is dummy text used in laying out print, graphic or web designs. In publish and graphic design, Lorem ipsum is a placeholder text commonly used to',
    },
    {
      'question': 'Can i change pick up location',
      'answer': '',
    },
    {
      'question': 'How to Edit Profile',
      'answer': '',
    },
    {
      'question': 'What does Lorem Ipsum mean',
      'answer': '',
    },
    {
      'question': 'Can i send a fragile package',
      'answer': '',
    },
    {
      'question': 'How to send my package',
      'answer': '',
    },
    {
      'question': 'Why do we use Lorem Ipsum',
      'answer': '',
    },
  ];

  @override
  void initState() {
    super.initState();
    _expandedItems = List.generate(faqItems.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: greenShadowDecoration,
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'FAQ',
              style: GlobalTextStyles.qsTitle,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: faqItems.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Colors.transparent,
              margin: const EdgeInsets.only(bottom: 8),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faqItems[index]['question']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: _expandedItems[index]
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: _expandedItems[index]
                              ? Color.fromRGBO(34, 43, 69, 1)
                              : Color.fromRGBO(34, 43, 69, 1),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (_expandedItems[index])
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(112, 112, 112, 1),
                          thickness: 0.5,
                        ),
                    ],
                  ),
                  trailing: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                      border: Border.all(color: Colors.green),
                    ),
                    // child: Center(
                    //   child: Icon(
                    //     _expandedItems[index]
                    //         ? Icons.keyboard_arrow_down_sharp
                    //         : Icons.arrow_forward_ios,
                    //     color: Colors.white,
                    //     size: 16,
                    //   ),
                    // ),
                    child: Center(
                      child: Image.asset(
                        _expandedItems[index]
                            ? 'assets/icons/ic_arrow_down.png'
                            : 'assets/icons/ic_arrow_right.png',
                        color: Colors.white,
                        height: 10,
                        width: 10,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _expandedItems[index] = isExpanded;
                    });
                  },
                  textColor: Colors.black,
                  iconColor: Colors.white,
                  childrenPadding: EdgeInsets.zero,
                  tilePadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  children: [
                    if (faqItems[index]['answer']!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          faqItems[index]['answer']!,
                          style: GlobalTextStyles.medium4Black.copyWith(
                            color: const Color.fromRGBO(34, 43, 69, 1),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
