import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:voice_chat/core/network/model/user_contact.dart';
import 'package:voice_chat/core/widgets/user_profile_card.dart';

class HomeContactsListItem extends StatelessWidget {
  const HomeContactsListItem({super.key, required this.userContact, this.onTap});

  final UserContact userContact;
  final Function()? onTap ;

  @override
  Widget build(BuildContext context) {
    return UserProfileCard(
      userContact: userContact,
      showMic: true,
      onTap: onTap,
    );
  }
}
