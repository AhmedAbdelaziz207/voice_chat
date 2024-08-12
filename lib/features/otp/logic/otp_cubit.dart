import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
    OtpCubit() : super(OtpInitial());
    late String correctCode;

    void confirmOtpCode(smsCode) async {
        emit(OtpLoading());

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: correctCode, smsCode: smsCode);
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signInWithCredential(credential);

        if (auth.currentUser != null) {
            // save user data to firebase
            // save user token to local storage
            UserModel user = UserModel(
                userId: auth.currentUser!.uid,
                phoneNumber: auth.currentUser!.phoneNumber!,
                name: "Ahmed Abdelaziz ",
                isOnline: true,
                profileImageUrl:
                "https://firebasestorage.googleapis.com/v0/b/voice-chat-b428d.appspot.com/o/char1_icon.png?alt=media&token=e149f5ce-648e-4358-8fe1-b0eebd87a2c3"
            ,);

            FirebaseService.createUserWithFireStore(user.toJson());

            print(credential.token);
            SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString(AppKeys.token, credential.token.toString());
            emit(OtpSuccess());
        } else {
            emit(OtpFailed(failedMessage: "Invalid OTP code"));
        }
    }

    void sendOtpRequest(phoneNumber) async {
        await FirebaseService.loginWithPhoneNumber(
            phoneNumber, (credential) {}, (e) {}, (verificationId, resendToken) {
                correctCode = verificationId;
            }, (verificationId) {});
    }
}
