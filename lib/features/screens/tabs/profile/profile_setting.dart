import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:good_food_app/core/main_screen_navigation.dart';
import 'package:good_food_app/features/pages/subscriptions/old/subscription_screen.dart';

import '../../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../../core/localization/screens/language_screen.dart';
import '../../../../core/localization/static/widgets/auto_translate_text.dart';
import '../../../../core/theme/text_styles/global_text_style.dart';
import '../../profile/location_screen.dart';
import '../../profile/notification_screen.dart';
import '../../profile/preference_screen.dart';
import '../../profile/settings_screen.dart';
import '../../profile/support_screen.dart';
import '../../profile/voucher_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  // final VoidCallback onBackToHome;

  const ProfileSettingsScreen({
    super.key,
    // required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      // backgroundColor: Colors.grey[100],
      appBar: buildProfileAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileHeader(),
            buildAccountSection(context),
            const SizedBox(height: 32),
            buildOtherInfoSection(context),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildProfileAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        decoration: greenShadowDecoration, // Applying the reusable decoration

        // decoration: BoxDecoration(
        //   color: Colors.white,
        //   boxShadow: [
        //     BoxShadow(
        //       color: Color.fromRGBO(
        //           228, 242, 228, 0.6), // Lighter, more transparent green
        //       blurRadius: 10,
        //       spreadRadius: 1,
        //       offset: Offset(0, 8),
        //     ),
        //   ],
        // ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => MainScreenNavigation.popToHomeTab(context),
            // onPressed: () => Navigator.pop(context),
          ),
          title: AutoTranslateText
              // Text
              (
            'Profile Details',
            style: GlobalTextStyles.qsTitle,
          ),
          centerTitle: true,
        ),
      ),
    );
  }

  Widget buildProfileHeader() {
    return Container(
      decoration: greenShadowDecoration, // Applying the reusable decoration

      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   // color: Colors.grey[100],
      //   boxShadow: [
      //     BoxShadow(
      //       color: Color.fromRGBO(228, 242, 228, 0.6), // Softer green shadow
      //       blurRadius: 15,
      //       spreadRadius: 1,
      //       offset: Offset(0, 8),
      //     ),
      //   ],
      // ),

      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 0, 0, 0),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[200],
              ),
              child:
                  ClipOval(child: Image.asset('assets/images/avtaar-png.png')),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoTranslateText(
                    'John Doe',
                    style: GlobalTextStyles.regular6Black,
                  ),
                  AutoTranslateText(
                    'johndoe@fakemail.com',
                    style: GlobalTextStyles.small5Black.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: AutoTranslateText(
                      'Edit Profile',
                      style: GlobalTextStyles.small5Black.copyWith(
                        color: Color.fromRGBO(119, 119, 119, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          AutoTranslateText(
            'Account',
            style: GlobalTextStyles.huge6Black.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // buildAccountItem(Icons.shopping_bag_outlined, 'Your Order'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              spacing: 8,
              children: [
                SvgPicture.asset('assets/icons/Frame.svg',
                    width: 24, height: 24),
                AutoTranslateText(
                  'Your Order',
                  style: GlobalTextStyles.regular5Black,
                ),
              ],
            ),
          ),
          // buildAccountItem(
          //   SvgPicture.asset('assets/icons/Frame.svg', width: 24, height: 24),
          //   'Your Order',
          // ),
          Divider(
            height: 0.5,
            thickness: 0.2,
            color: Colors.grey,
          ), // Optional: Set the color of the line)

          // Divider(
          //   height: 0.5, // Space around the divider
          //   thickness: 0.2, // Actual thickness of the line
          //   color: Color.fromRGBO(
          //       247, 247, 247, 1), // Optional: Set the color of the line
          // ),
          // buildAccountItem(Icons.settings_outlined, 'Settings'),
          // buildAccountItem(Icon(Icons.settings_outlined), 'Settings'),
          const SizedBox(height: 8),
          // buildAccountItem(Icons.shopping_bag_outlined, 'Your Order'),
          buildAccountItem(
            // context,
            Image.asset(
              'assets/icons/ic_subscribe.png',
              height: 24,
              width: 24,
            ),
            'My Subscriptions',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SubscriptionScreen()),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8),
          //   child: Row(
          //     spacing: 8,
          //     children: [
          //       // SvgPicture.asset('assets/icons/Frame.svg',
          //       //     width: 24, height: 24),
          //       Image.asset('assets/icons/ic_subscriptions.png'),
          //       AutoTranslateText(
          //         'My Subscriptions',
          //         style: GlobalTextStyles.regular5Black,
          //       ),
          //     ],
          //   ),
          // ),
          // buildAccountItem(
          //   SvgPicture.asset('assets/icons/Frame.svg', width: 24, height: 24),
          //   'Your Order',
          // ),
          Divider(
            height: 0.5,
            thickness: 0.2,
            color: Colors.grey,
          ),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/setting.svg', width: 24, height: 24),
            'Settings',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingsScreen())),
          ),
          Divider(
            height: 0.5, // Space around the divider
            thickness: 0.2, // Actual thickness of the line
            color: Colors.grey, // Optional: Set the color of the line
          ),
          // Divider(
          //   height: 0.5, // Space around the divider
          //   thickness: 0.2, // Actual thickness of the line
          //   color: Color.fromRGBO(
          //       247, 247, 247, 1), // Optional: Set the color of the line
          // ),
          // buildAccountItem(Icons.card_giftcard_outlined, 'Voucher'),
          // buildAccountItem(Icon(
          //       Icons.card_giftcard_outlined,
          //     ), 'Voucher'),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/Ticket_use.svg',
                width: 24, height: 24),
            'Voucher',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => VoucherScreen())),
          ),
          Divider(
            height: 0.5, // Space around the divider
            thickness: 0.2, // Actual thickness of the line
            color: Colors.grey, // Optional: Set the color of the line
          ),
          // buildAccountItem(Icons.notifications_outlined, 'Notification'),
          // buildAccountItem(Icon(Icons.notifications_outlined), 'Notification'),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/Bell.svg', width: 24, height: 24),
            'Notification',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationScreen())),
          ),
          Divider(
            height: 0.5, // Space around the divider
            thickness: 0.2, // Actual thickness of the line
            color: Colors.grey, // Optional: Set the color of the line
          ),
          // buildAccountItem(Icons.support_agent_outlined, 'Support'),
          // buildAccountItem(
          //   Icon(Icons.support_agent_outlined, size: 24, color: Colors.black87),
          //   // Wrap IconData with Icon
          //   'Support',
          // ),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/Message.svg', width: 24, height: 24),
            'Support',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SupportScreen())),
          ),
        ],
      ),
    );
  }

  Widget buildOtherInfoSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoTranslateText(
            'Other Info',
            style: GlobalTextStyles.huge6Black.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          // buildOtherInfoItem(Icons.language_outlined, 'Language'),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/globe.svg', width: 24, height: 24),
            'Language',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LanguageScreen())),
          ),
          Divider(
            height: 0.5, // Space around the divider
            thickness: 0.2, // Actual thickness of the line
            color: Colors.grey, // Optional: Set the color of the line
          ),
          // buildOtherInfoItem(Icons.location_on_outlined, 'Location'),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/Pin_alt.svg', width: 24, height: 24),
            'Location',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationScreen())),
          ),
          Divider(
            height: 0.5, // Space around the divider
            thickness: 0.2, // Actual thickness of the line
            color: Colors.grey, // Optional: Set the color of the line
          ),
          // buildOtherInfoItem(Icons.tune_outlined, 'Preference'),
          buildAccountItem(
            // context,
            SvgPicture.asset('assets/icons/Blank.svg', width: 24, height: 24),
            'Preference',
            () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PreferenceScreen())),
          ),
          buildOtherInfoItem(
              Icon(
                Icons.logout,
                color: Colors.red,
              ),
              'Sign Out',
              isSignOut: true),
          // buildAccountItem(
          //   Icon(
          //     Icons.logout,
          //     color: Colors.red,
          //   ),
          //   'Sign Out',
          // )
        ],
      ),
    );
  }

  Widget buildAccountItem(
    Widget leadingIcon,
    String title,
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 16, 12),
        child: Row(
          children: [
            leadingIcon,
            const SizedBox(width: 12),
            Expanded(
              child: AutoTranslateText(
                title,
                style: GlobalTextStyles.regular5Black,
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: Color.fromRGBO(34, 34, 34, 1)),
          ],
        ),
      ),
    );
  }

  Widget buildOtherInfoItem(
    Widget leadingIcon,
    String title, {
    bool isSignOut = false,
    VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 12, 16, 12),
        child: Row(
          children: [
            leadingIcon,
            const SizedBox(width: 12),
            Expanded(
              child: AutoTranslateText(
                title,
                style: GlobalTextStyles.regular5Black.copyWith(
                  color: isSignOut ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (!isSignOut)
              const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
