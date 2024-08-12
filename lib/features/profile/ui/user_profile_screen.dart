import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';
import '../../../core/utils/constants/app_keys.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            color: AppColors.primaryColor,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.mintGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                )),
            height: 300.h,
          ),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.all(20.0.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppKeys.profile,
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(16.r)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage(AssetsKeys.contactImage),
                                radius: 25.0,
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Text(
                                "Profile Name ",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                         Divider(
                          color: AppColors.grey,
                          thickness: .2,
                          indent: 12.w,
                          endIndent: 12.w,
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        ListTile(
                          onTap: () {},
                          title: const Text(
                            "Change Name ",
                            style: TextStyle(color: AppColors.white),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            print("Clicked ");
                          },
                          title: const Text(
                            "Change Name ",
                            style: TextStyle(color: AppColors.white),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: AppColors.white,
                            size: 20,
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            print("Clicked ");
                          },
                          title: const Text(
                            "Notifications ",
                            style: TextStyle(color: AppColors.white),
                          ),
                          trailing: Switch(
                            value: false,
                            onChanged: (bool value) {},
                            activeColor: AppColors.mintGreen,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Divider(
                          color: AppColors.grey,
                          thickness: .2,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding:  EdgeInsets.all(16.0.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "More",
                                style: TextStyle(color: AppColors.grey,fontSize: 18.sp),
                              ) ,
                              SizedBox(height: 8.h,),
                              Text(
                                "About us",
                                style: TextStyle(color: AppColors.white,fontSize: 19.sp),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
