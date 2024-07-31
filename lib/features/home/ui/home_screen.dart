import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/home/ui/widgets/home_contacts_gridview_widget.dart';
import 'package:voice_chat/features/home/ui/widgets/home_groups_title.dart';
import 'package:voice_chat/features/home/ui/widgets/home_search_widget.dart';
import 'package:voice_chat/features/home/ui/widgets/pinned_contacts_listview_widget.dart';
import '../../../core/theming/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          SizedBox(
            width: 30.w,
            child: IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 30.w,
            child: IconButton(
              icon: const Icon(Icons.volume_off),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 30.w,
            child: IconButton(
              icon: Icon(Icons.check_box),
              onPressed: () {},
            ),
          ),
          SizedBox(width: 6.w,)
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu_sharp),
          onPressed: () {},
        ),
      ),
      body: AppBackground(
        isDark: true,
        child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20.h),
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r))),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 14.0.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppKeys.pin,
                            style: AppTextStyles.homeTextStyle,
                          ),
                          const Icon(
                            Icons.push_pin,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const PinnedContactsListViewWidget(),
                    const HomeSearchWidget(),
                    SizedBox(
                      height: 30.h,
                    ),
                    const HomeGroupsTitle(),
                    const HomeContactsGridviewContacts()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
