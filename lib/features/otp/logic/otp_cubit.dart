import 'package:cloud_firestore/cloud_firestore.dart';
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


    void confirmOtpCode(smsCode) async {
        emit(OtpLoading());

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: correctCode, smsCode: smsCode);
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth.signInWithCredential(credential);

        final currentUser = auth.currentUser;
        if (currentUser != null) {
            // get or save user data to firebase
            // save user token to local storage

            DocumentSnapshot userSnapshot = await FirebaseService.getUserData(
                currentUser.uid);
            if(!userSnapshot.exists){
                UserModel user = UserModel(
                    userId: currentUser.uid,
                    phoneNumber: currentUser.phoneNumber!,
                    name: "Ahmed Abdelaziz ",
                    isOnline: true,
                    profileImageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/voice-chat-b428d.appspot.com/o/char1_icon.png?alt=media&token=e149f5ce-648e-4358-8fe1-b0eebd87a2c3",
                );
                FirebaseService.createUserWithFireStore(user.toJson());
            }

            //
            // SharedPreferences preferences = await SharedPreferences.getInstance();
            // preferences.setString(AppKeys.token, credential.token.toString());


            sessionProvider.saveSession(credential.token.toString(),
                currentUser.uid );

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
                emit(OtpFailed(failedMessage: e.message.toString() ));
            },
            (verificationId, resendToken) {
                correctCode = verificationId;
            },
            (verificationId) {},
        );
    }
}
