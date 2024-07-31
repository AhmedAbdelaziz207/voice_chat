import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  String correctCode = "12345";

  void confirmOtpRequest(otpCode) async {
    emit(OtpLoading());


    debugPrint("Resend code ");


    await Future.delayed(const Duration(seconds: 2));

    if (isCorrectCode(otpCode)) {
      emit(OtpSuccess());
    } else {
      emit(OtpFailed(
        failedMessage: "Wrong OTP Code , try again "
      ));
    }
  }

  bool isCorrectCode(otpCode) {
    if (otpCode == correctCode) {
      return true;
    }
    return false;
  }

  void resendOtpRequest(){
    ///TODO Implement Resend Otp Request Function
    debugPrint("Resend code ");
  }
}
