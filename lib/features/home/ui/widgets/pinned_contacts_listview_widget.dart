import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/user_model.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/features/home/logic/home_users_cubit.dart';

import 'home_contacts_list_item.dart';

class PinnedContactsListViewWidget extends StatefulWidget {
   const PinnedContactsListViewWidget({super.key});

  @override
  State<PinnedContactsListViewWidget> createState() => _PinnedContactsListViewWidgetState();
}

class _PinnedContactsListViewWidgetState extends State<PinnedContactsListViewWidget> {
   List<UserModel> userContacts = [];

   String? currentUserId = '' ;

  getCurrentUser()async{
    SessionProvider sessionProvider = SessionProvider();
   await sessionProvider.loadSession().then((value) {
     currentUserId = sessionProvider.session?.userId;
   });}

   @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.h,
      width: double.infinity,
      child: BlocBuilder<HomeUsersCubit,HomeUsersState>(
        builder: (context, state) {
          if(state is HomeUsersLoading ){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(state is HomeUsersSuccess) {
            userContacts = state.usersContact;
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: userContacts.length,
            itemBuilder: (BuildContext context, int index) {
              if(currentUserId == userContacts[index].userId){
                userContacts[index].name = "Me";
              }
              return HomeContactsListItem(
                userContact: userContacts[index],
                onTap: () {
                  Navigator.pushNamed(context, Routes.chat,arguments: userContacts[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
