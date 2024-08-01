import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import '../../../core/network/model/user_contact.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  TextEditingController homeSearchController  = TextEditingController();
  List<UserContact> userContacts = [];
  List<UserContact> favouriteContacts = [];
  List<UserContact> searchedContacts = [];

  TextEditingController searchController = TextEditingController();

  getAllContacts() async {
    emit(HomeLoading());

    // Simulate request
    await Future.delayed(const Duration(seconds: 2));

    // TODO Call API or FireBase to get contacts
    AppKeys.userContacts.forEach(
      (element) {
        userContacts.add(element);
      },
    );
    emit(HomeSuccess(usersContact: userContacts));
  }

  getFavouriteFavourite() {
    /// TODO Call API or FireBase to get Favourite contacts
    favouriteContacts = userContacts;
  }

  getSearchedContacts(String value) {
    searchedContacts = userContacts.where((contact) {
      final contactName = contact.name?.toLowerCase();
      final searchValue = value.toLowerCase();
      return contactName!.contains(searchValue);
    }).toList();

    emit(HomeSearchSuccess(searchedContacts: searchedContacts));
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
