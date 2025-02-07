import 'package:flutter/material.dart';
import 'package:good_food_app/features/routes/app_route_manager.dart';

import '../../../core/decoration/single_side_shadow_decoration.dart';
import '../../../core/theme/text_styles/global_text_style.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Container(
          decoration: greenShadowDecoration,
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              // onPressed: widget.onBackToHome,
              onPressed: () => AppRouteManager.goBack(context),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            title: Text(
              'Preference',
              style: GlobalTextStyles.qsTitle,
            ),
            actions: [
              // Padding(
              //   padding: const EdgeInsets.only(right: 32),
              //   child: SvgPicture.asset('assets/icons/ic_search.svg'),
              // ),
            ],
            centerTitle: true,
          ),
        ),
      ),
    );
  }
}
