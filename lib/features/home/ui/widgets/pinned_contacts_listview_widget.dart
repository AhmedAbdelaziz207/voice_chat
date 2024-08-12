import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/router/routes.dart';

import 'home_contacts_list_item.dart';

class PinnedContactsListViewWidget extends StatelessWidget {
  const PinnedContactsListViewWidget({super.key});
  static var userContacts = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: userContacts.length,
        itemBuilder: (BuildContext context, int index) {
          return HomeContactsListItem(
            userContact: userContacts[index],
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
