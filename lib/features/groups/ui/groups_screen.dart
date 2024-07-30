import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/groups/ui/widgets/groups_chat_list_item.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: const Icon(
          Icons.menu_sharp,
          color: AppColors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: AppBackground(
        isDark: true,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  AppKeys.groups,
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const GroupsChatListItem();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
