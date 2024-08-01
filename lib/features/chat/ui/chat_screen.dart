import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_contact.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/assets_keys.dart';
import 'package:voice_chat/core/widgets/app_background.dart';
import 'package:voice_chat/features/chat/ui/widgets/received_voice_message_widget.dart';
import 'package:voice_chat/features/chat/ui/widgets/sent_voice_message_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.userContact});
  final UserContact userContact ;
  @override
  Widget build(BuildContext context) {
    debugPrint(userContact.name);

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
             CircleAvatar(
              backgroundImage: AssetImage(userContact.imageUrl!),
              radius: 25.0,
            ),
            SizedBox(
              width: 8.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userContact.name!,
                  style: AppTextStyles.contactLabelStyle
                      .copyWith(color: AppColors.primaryColorDark),
                ),
                Text(
                  "Online",
                  style: AppTextStyles.contactLabelStyle
                      .copyWith(color: AppColors.yellow),
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
          child: ListView(
            children: [
              const SizedBox(height: 10,),

              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: ReceivedVoiceMessageWidget(
                    contactImageUrl: userContact.imageUrl!,
                  )),
              const SizedBox(height: 10,),
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: SentVoiceMessageWidget()),    const SizedBox(height: 10,),
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: SentVoiceMessageWidget()),
              const SizedBox(
                height: 10,
              ),
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: SentVoiceMessageWidget()),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () {},
          child: Image.asset(AssetsKeys.micIcon),
        ),
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
