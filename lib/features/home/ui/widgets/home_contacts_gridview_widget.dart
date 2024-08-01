import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_contact.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/features/home/logic/home_cubit.dart';
import 'home_contacts_list_item.dart';

class HomeContactsGridviewContacts extends StatelessWidget {
  const HomeContactsGridviewContacts({super.key, required this.users});
  final List<UserContact> users ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 500.h,
        child:
        GridView.builder(
          itemCount: users
              .length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 6.0,
            crossAxisCount: 5,
            childAspectRatio: .8,
          ),
          itemBuilder: (context, index) {
            return HomeContactsListItem(
              userContact: users[index],
              onTap: () {
                Navigator.pushNamed(context, Routes.chat);
              },
            );
          },
        )
    );
  }
}
