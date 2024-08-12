import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';

class FirebaseService {
    static FirebaseAuth auth = FirebaseAuth.instance;
    static FirebaseFirestore fireStore = FirebaseFirestore.instance;

    static loginWithPhoneNumber(
        String phoneNumber,
        Function(PhoneAuthCredential credential) verificationCompleted,
        Function(FirebaseAuthException e) verificationFailed,
        Function(String verificationId, int? resendToken) codeSent,
        Function(String verificationId) codeAutoRetrievalTimeout,
    ) async {
        await auth.verifyPhoneNumber(
            phoneNumber: phoneNumber,
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        );
    }

    static void createUserWithFireStore(user) async {
        await fireStore.collection(AppKeys.users).add(user).then(
            (value) {
                debugPrint(user);
            },
        );
    }

    static Future<QuerySnapshot<Map<String, dynamic>>> getUserData() async {
        QuerySnapshot<Map<String, dynamic>> response =
        await fireStore.collection(AppKeys.users).get().then(
            (event) {
              for (var doc in event.docs) {
                print("${doc.id} => ${doc.data()}");
              }
              return event ;
            },
        );

        return response;
    }
}
