import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/chat.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/features/home/logic/home_users_cubit.dart';

import '../../../../core/router/routes.dart';

class HomeChatListItem extends StatefulWidget {
  const HomeChatListItem({super.key, this.chat, required this.currentUserId});

  final Chat? chat;
  final String currentUserId;

  @override
  State<HomeChatListItem> createState() => _HomeChatListItemState();
}

class _HomeChatListItemState extends State<HomeChatListItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = widget.currentUserId == widget.chat!.fromUserId;
    String userName =
        isCurrentUser ? widget.chat!.toUserName! : widget.chat!.fromUserName!;

    ChatMessage? lastMessage = widget.chat?.lastMessage;
    String lastMessageText =
        lastMessage != null ? (lastMessage.messageDuration! / 100).toStringAsFixed(2)  : '';

    int unreadMessagesNumber = isCurrentUser
        ? widget.chat!.toUserMessagesNum!
        : widget.chat!.fromUserMessagesNum!;

    return InkWell(
      onTap: () {
        String userId =
            isCurrentUser ? widget.chat!.toUserId! : widget.chat!.fromUserId!;
        UserModel userModel = UserModel(
          userId: userId,
          name: userName,
          isOnline: false,
          phoneNumber: '0000000000',
          profileImageUrl:
              'https://firebasestorage.googleapis.com/v0/b/voice-chat-b428d.appspot.com/o/char1_icon.png?alt=media&token=e149f5ce-648e-4358-8fe1-b0eebd87a2c3',
        );

        Navigator.pushNamed(context, Routes.chat, arguments: userModel);
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: const NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/voice-chat-b428d.appspot.com/o/char1_icon.png?alt=media&token=e149f5ce-648e-4358-8fe1-b0eebd87a2c3",
            ),
            radius: 30.0.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text  (
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    if (lastMessage != null)
                      const Icon(
                        Icons.mic,
                        size: 16,
                        color: AppColors.grey,
                      ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      lastMessageText,
                      style: const TextStyle(color: AppColors.grey),
                    ),
                  ],
                )
              ],
            ),
          ),
          if (unreadMessagesNumber > 0)
            Container(
              padding: EdgeInsets.all(4.sp),
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Text(
                "$unreadMessagesNumber",
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            )
        ],
      ),
    );
  }
}
