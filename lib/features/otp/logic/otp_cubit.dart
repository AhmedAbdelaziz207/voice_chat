import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  late String correctCode;
  SessionProvider sessionProvider = SessionProvider();

  void confirmOtpCode(smsCode, userName) async {
    emit(OtpLoading());

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: correctCode, smsCode: smsCode);
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signInWithCredential(credential);
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      bool accountExist = await FirebaseService.doesAccountExist(currentUser.phoneNumber!);
      if (!accountExist) {
        UserModel user = UserModel(
          userId: currentUser.uid,
          phoneNumber: currentUser.phoneNumber!,
          name:userName,
          isOnline: true,
          profileImageUrl:
              "https://firebasestorage.googleapis.com/v0/b/voice-chat-b428d.appspot.com/o/char1_icon.png?alt=media&token=e149f5ce-648e-4358-8fe1-b0eebd87a2c3",
        );
        FirebaseService.createUserWithFireStore(user.toJson());
      }else{
        debugPrint("Account Already Exist ");
      }
      sessionProvider.saveSession(credential.token.toString(), currentUser.uid,userName);

      // Debug statements
      debugPrint("Name: $userName, UserId: ${currentUser.uid}");
      SessionProvider.user = UserModel(name: userName, userId: currentUser.uid);

      emit(OtpSuccess());
    } else {
      emit(OtpFailed(failedMessage: "Invalid OTP code"));
    }
  }

  void sendOtpRequest(phoneNumber) async {
    await FirebaseService.loginWithPhoneNumber(
      phoneNumber,
      (credential) {},
      (e) {
        emit(OtpFailed(failedMessage: e.message.toString()));
      },
      (verificationId, resendToken) {
        correctCode = verificationId;
      },
      (verificationId) {},
    );
  }
}
