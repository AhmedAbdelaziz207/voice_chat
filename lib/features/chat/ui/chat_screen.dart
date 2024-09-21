import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:voice_chat/core/network/model/chat_message.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/features/chat/logic/chat_cubit.dart';
import 'package:voice_chat/features/chat/ui/widgets/recieved_voice_message_widget.dart';
import 'package:voice_chat/features/chat/ui/widgets/sent_voice_message_widget.dart';
import 'package:voice_chat/features/chat/ui/widgets/voice_message_widget.dart';
import '../../../core/router/routes.dart';
import '../logic/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.userContact});

  final UserModel userContact;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  double position = 0;

  @override
  void initState() {
    debugPrint("Init state ");
    context.read<ChatCubit>().clearUnreadMessages(widget.userContact.userId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Chat Screen ${widget.userContact.userId}");

    context.read<ChatCubit>().getOrCreateChat(widget.userContact);
    context.read<ChatCubit>().getChatMessages(widget.userContact.userId!);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.white,
          ),
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
                backgroundImage:
                    NetworkImage(widget.userContact.profileImageUrl!),
                radius: 25.0,
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userContact.name!,
                  style: AppTextStyles.contactLabelStyle
                      .copyWith(color: AppColors.white),
                ),
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ChatCubit, ChatState>(
            builder: (BuildContext context, state) {
          List<ChatMessage> messages = state is ChatMessagesLoaded
              ? state.messages
              : context.read<ChatCubit>().messages;

          return BlocBuilder<ChatCubit, ChatState>(
            builder: (BuildContext context, state) {
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  if(messages[index].senderId == widget.userContact.userId) {
                    return SentVoiceMessageWidget(
                     audioSource:  AudioSource.uri(
                        Uri.parse(messages[index].messageContent!),
                        tag: MediaItem(
                          id: messages[index].messageId!,
                          title: "Voice Chat",
                          artist: messages[index].senderId,
                        ),
                      ), id: '${messages[index].messageId}',
                    );
                  } else {
                    return ReceivedVoiceMessageWidget(
                      audioSource:  AudioSource.uri(
                        Uri.parse(messages[index].messageContent!),
                        tag: MediaItem(
                          id: messages[index].messageId!,
                          title: "Voice Chat",
                          artist: messages[index].senderId,
                        ),
                      ), id: '${messages[index].messageId}',
                    );
                  }
                },
              );
            },
          );
        }),
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
                  context
                      .read<ChatCubit>()
                      .stopRecording(widget.userContact.userId!);
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
          color: AppColors.secondaryColor,
          shape: CircularNotchedRectangle(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    context.read<ChatCubit>().clearUnreadMessages(widget.userContact.userId!);
    super.dispose();
  }
}
