import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/model/chat.dart';
import 'home_chat_state.dart';

class HomeChatCubit extends Cubit<HomeChatState> {
  HomeChatCubit() : super(HomeChatsLoading());

  Future<void> listenToChats(String currentUserId) async {
    debugPrint("Start Listening to chats ");
    try {
          FirebaseFirestore.instance
              .collection('chats')
              .where('users_id', arrayContains: currentUserId)
              .snapshots()
              .listen((snapshot) {
            final List<Chat> chats = snapshot.docs.map((doc) {
              final data = doc.data();
              debugPrint(data.toString());
              return Chat.fromJson(data);
            }).toList();

            emit(HomeChatsLoaded(chats: chats));
          }
      );
    } catch (e) {
      emit(HomeChatsFailed(
        failedMessage: e.toString(),
      ));
      debugPrint("Listen to all user chats error: $e");
    }
  }
}
