import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:voice_chat/core/network/model/chat.dart';
import 'package:voice_chat/core/network/services/session_provider.dart';
import 'package:voice_chat/core/router/routes.dart';
import 'package:voice_chat/core/theming/app_text_styles.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import 'package:voice_chat/features/home/logic/home_chat_cubit.dart';
import 'package:voice_chat/features/home/logic/home_users_cubit.dart';
import 'package:voice_chat/features/home/ui/widgets/home_chat_list_item.dart';
import 'package:voice_chat/features/home/ui/widgets/home_groups_title.dart';
import 'package:voice_chat/features/home/ui/widgets/pinned_contacts_listview_widget.dart';
import '../../../core/theming/app_colors.dart';
import '../logic/home_chat_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? currentUserId = '';

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    SessionProvider sessionProvider = SessionProvider();
    await sessionProvider.loadSession();
    setState(() {
      currentUserId = sessionProvider.session?.userId;
    });
    if (currentUserId != null) {
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Home Screen ${SessionProvider.user.userId}, name ${SessionProvider.user.name}");
    context.read<HomeChatCubit>().listenToChats(SessionProvider.user.userId!);
    context.read<HomeUsersCubit>().getAllContacts();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chats",
          style: TextStyle(
              color: AppColors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.transparent,
        iconTheme: const IconThemeData(color: AppColors.white),
        actions: [
          SizedBox(
            width: 30.w,
            child: IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 30.w,
            child: IconButton(
              icon: const Icon(Icons.volume_off),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 35.w,
            child: IconButton(
              icon: const Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {},
            ),
          ),
          SizedBox(
            width: 6.w,
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: AppColors.primaryColor,
        child: Column(
          children: [
            SafeArea(
              child: ListTile(
                title: Text(
                  "Logout",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: AppColors.white,
                ),
                onTap: () async {
                  logout(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.0.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppKeys.all,
                      style: AppTextStyles.homeTextStyle,
                    ),
                    const Icon(
                      Icons.all_inclusive_outlined,
                      color: AppColors.white200,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              const PinnedContactsListViewWidget(),
              Padding(
                padding: EdgeInsets.only(left: 8.0.w),
                child: const MyChatsTitle(),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.h),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r))),
                child: BlocBuilder<HomeUsersCubit, HomeUsersState>(
                    builder: (context, state) {
                  if (state is HomeUsersLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 500.h,
                          child: BlocBuilder<HomeChatCubit, HomeChatState>(
                              builder: (context, state) {
                            if (state is HomeChatsLoading) {
                              return const CircularProgressIndicator();
                            }

                            List<Chat>? chats =
                                state is HomeChatsLoaded ? state.chats : [];
                            return ListView.separated(
                              itemBuilder: (context, index) {
                                return HomeChatListItem(
                                  chat: chats[index],
                                  currentUserId: currentUserId ?? "",
                                );
                              },
                              itemCount: chats!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(height: 16.h);
                              },
                            );
                          }),
                        )
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> logout(context) async {
    SessionProvider session = SessionProvider();
    await session.clearSession();
    Navigator.pushNamed(context, Routes.login);
  }
}
