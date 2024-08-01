import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/features/home/logic/home_cubit.dart';

class HomeSearchWidget extends StatelessWidget {
  const HomeSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 60.h,
      child: TextField(
        controller: context.read<HomeCubit>().homeSearchController ,
        onChanged: context.read<HomeCubit>().getSearchedContacts,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white200,
          hintText: AppKeys.search,
          suffixIcon: const Icon(Icons.search,color: AppColors.grey,),
          hintStyle: AppTextStyles.contactLabelStyle.copyWith(
            color: AppColors.grey
          ),
          border:  OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20.r)
          )
        ),
      ),
    );
  }
}
