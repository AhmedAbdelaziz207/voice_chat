import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'home_contacts_list_item.dart';

class HomeContactsGridviewContacts extends StatelessWidget {
  const HomeContactsGridviewContacts({super.key, required this.userContacts});
  final List<UserModel> userContacts ;
  @override
  Widget build(BuildContext context) {

    return SizedBox(
        width: double.infinity,
        height: 500.h,
        child:
        GridView.builder(
          itemCount: userContacts
              .length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 6.0,
            crossAxisCount: 5,
            childAspectRatio: .8,
          ),
          itemBuilder: (context, index) {
            return HomeContactsListItem(
              userContact: userContacts[index],
              onTap: () {
                Navigator.pushNamed(context, Routes.chat, arguments: userContacts[index]);
              },
            );
          },
        )
    );
  }
}
