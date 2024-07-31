import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/core/utils/extensions/alert_dialog.dart';
import 'package:voice_chat/features/otp/logic/otp_cubit.dart';
import 'package:voice_chat/features/otp/ui/widgets/otp_form_widget.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool isCompleted = false;

  late String pinValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppKeys.confirmOTP,
          style: AppTextStyles.otpAppbar,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        backgroundColor: AppColors.primaryColor,
      ),
      body: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          handleOtpStates(context, state);
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  widget.phoneNumber,
                  style: AppTextStyles.otpPhoneNumber,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 4.h, horizontal: 8.w),
                  child: Text(
                    AppKeys.enterOtpCode,
                    style: AppTextStyles.otpInstruction,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                OTPFormWidget(
                  onCompleted: (pinValue) {
                    setState(() {
                      this.pinValue = pinValue;
                      isCompleted = true;
                    });
                  },
                  onChanged: (_) {
                    setState(() {
                      isCompleted = false;
                    });
                  },
                ),
                SizedBox(
                  height: 60.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppKeys.haveNotConfirmCode,
                      style: AppTextStyles.otpInstruction,
                    ),
                    InkWell(
                      onTap: () {
                        context.read<OtpCubit>().resendOtpRequest();
                      },
                      child: Text(
                        AppKeys.resend,
                        style: AppTextStyles.otpInstruction.copyWith(
                            color: AppColors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 90.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isCompleted) {
                      context
                          .read<OtpCubit>()
                          .confirmOtpRequest(pinValue);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 54.h),
                      backgroundColor: isCompleted
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor),
                  child: BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) {
                      if (state is OtpLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.white,
                          ),
                        );
                      }
                      return Text(
                        AppKeys.confirm,
                        style: AppTextStyles.otpButton,
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleOtpStates(BuildContext context, OtpState state) {
    if (state is OtpSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
      );
    } else if (state is OtpFailed) {
      context.showAlertDialog(
          title: "OTP Failed ", contentMessage: state.failedMessage);
    }
  }
}
