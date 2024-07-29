import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_contact.dart';
import 'package:voice_chat/core/theming/app_colors.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';

class ContactsListItem extends StatelessWidget {
  const ContactsListItem({super.key, required this.userContact});
  final UserContact userContact ;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            CircleAvatar(
              backgroundImage:
                  AssetImage(userContact.imageUrl!),
              radius: 25.0,
            ),
            const Positioned(
              bottom: -3,
              right: -4,
              child: Icon(
                Icons.mic,
                color: AppColors.primaryColor,
                size: 24.0,
              ),
            ),

          ]),
          const SizedBox(height: 8.0),
           Expanded(
             child: Text(
              userContact.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.contactLabelStyle
                       ),
           ),
        ],
      ),
    );
  }
}
