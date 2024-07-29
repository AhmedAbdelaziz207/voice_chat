import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/home/ui/widgets/contacts_list_item.dart';
import 'package:voice_chat/features/home/ui/widgets/home_groups_title.dart';
import 'package:voice_chat/features/home/ui/widgets/home_search_widget.dart';

import '../../../core/network/model/user_contact.dart';
import '../../../core/theming/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<UserContact> userContacts = [
    UserContact(
        name: "Abdelaziz  ",
        imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Abdelaziz  ",
        imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
    UserContact(
        name: "Ahmed", imageUrl: "assets/images/contact_image.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        iconTheme: IconThemeData(color: AppColors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.volume_off),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.check_box),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu_sharp),
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
                    SizedBox(
                      height: 120.h,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userContacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ContactsListItem(
                              userContact: userContacts[index]);
                        },
                      ),
                    ),
                    const HomeSearchWidget(),
                    SizedBox(
                      height: 30.h,
                    ),
                    const HomeGroupsTitle(),
                    SizedBox(
                      width: double.infinity,
                      height: 500,
                      child: GridView.builder(
                        itemCount: userContacts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 6.0,
                          crossAxisCount: 5,
                          childAspectRatio: .8,
                        ),
                        itemBuilder: (context, index) {
                          return ContactsListItem(
                            userContact: userContacts[index],
                          );
                        },
                      ),
                    )
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
