import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import 'package:voice_chat/core/utils/constants/app_keys.dart';
import '../../../core/network/model/user_model.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
    HomeCubit() : super(HomeInitial());
    TextEditingController homeSearchController  = TextEditingController();
    List<UserModel> userContacts = [];
    List<UserModel> favouriteContacts = [];
    List<UserModel> searchedContacts = [];

    TextEditingController searchController = TextEditingController();

    Future<void> getAllContacts() async {
        try {
            emit(HomeLoading());
            QuerySnapshot<Map<String, dynamic>> snapshot =
                await FirebaseService.getUserData();
            userContacts = snapshot.docs.map((doc) {
                return UserModel.fromJson(doc.data());
            }).toList();
            emit(HomeSuccess(usersContact: userContacts));
        } catch (e) {
            emit(HomeFailed( failedMessage: e.toString()));
        }
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
