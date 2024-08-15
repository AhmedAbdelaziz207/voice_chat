import 'package:chat_bubbles/bubbles/bubble_normal_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/chat/logic/chat_cubit.dart';
import '../../../core/router/routes.dart';
import '../logic/chat_state.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.userContact});

  final UserModel userContact;

  @override
  Widget build(BuildContext context) {
    context.read<ChatCubit>().getOrCreateChat(userContact.userId!);
    context.read<ChatCubit>().getChatMessages(userContact.userId!);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.profile);
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(userContact.profileImageUrl!),
                radius: 25.0,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userContact.name!,
                  style: AppTextStyles.contactLabelStyle
                      .copyWith(color: AppColors.primaryColorDark),
                ),
              ],
            )
          ],
        ),
      ),
      body: AppBackground(
        isDark: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ChatCubit, ChatState>(
              builder: (BuildContext context, state) {
            List<ChatMessage> messages = state is ChatMessagesLoaded
                ? state.messages
                : context.read<ChatCubit>().messages;
            return BlocBuilder<ChatCubit,ChatState> (
              builder: (BuildContext context, state) {
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    bool isPlaying = context.read<ChatCubit>().isPlaying ;
                    ChatMessage message = messages[index];
                    bool isSender = message.senderId != userContact.userId;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: BubbleNormalAudio(
                        seen: message.isRead?? false ,
                        isSender: isSender ,
                        onSeekChanged: (value) {},
                        isPlaying: isPlaying,
                        isPause: !isPlaying ,
                        bubbleRadius: 16.0,
                        onPlayPauseButtonClick: () {
                          if(isPlaying){
                            context.read<ChatCubit>().stopAudio();
                          }else{
                            context.read<ChatCubit>().playAudio(message);
                          }
                        },
                      ),
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var isRecording = state is ChatRecording ? state.isRecording : false;

          return FloatingActionButton(
            onPressed: () {},
            backgroundColor: AppColors.transparent,
            shape: const CircleBorder(),
            child: IconButton(
              icon: Icon(
                isRecording ? Icons.pause : Icons.mic,
                size: 40.r,
              ),
              onPressed: () {
                if (isRecording) {
                  context.read<ChatCubit>().stopRecording(userContact.userId!);
                } else {
                  context.read<ChatCubit>().startRecord();
                }
              },
              style: IconButton.styleFrom(backgroundColor: AppColors.white),
            ),
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 50.h,
        child: const BottomAppBar(
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }
}
