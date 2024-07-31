import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/features/login/logic/login_state.dart';



class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  TextEditingController loginController = TextEditingController();
  int selectedCountryCodeIndex = 0;

  late String countryCode;

  void login() async {
    countryCode = AppKeys.countryCodes[selectedCountryCodeIndex];
    emit(LoginLoading());

    if (validPhoneNumber()) {
      await Future.delayed(const Duration(seconds: 2));

      emit(LoginSuccess(phoneNumber: loginController.text));
    } else {
      emit(LoginFailed(failedMessage: "Invalid phone number"));
    }
  }

  bool validPhoneNumber() {
    String phoneNumber = loginController.text.trim();
    String pattern = r'^(01[0-9]{9}|(\+201)[0-9]{9})$';
    RegExp regExp = RegExp(pattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (!regExp.hasMatch(phoneNumber)) {
      return false;
    }



    /// TODO Implement OTP Request



    return true;
  }

@override
  Future<void> close() {
    loginController.dispose();
    return super.close();
  }
}
