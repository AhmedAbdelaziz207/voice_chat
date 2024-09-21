import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_chat/core/network/model/chat.dart';
import 'package:voice_chat/core/network/services/firebase_service.dart';
import '../../../core/network/model/user_model.dart';
part 'home_state.dart';

class HomeUsersCubit extends Cubit<HomeUsersState> {
    HomeUsersCubit() : super(HomeUsersLoading());
    TextEditingController homeSearchController = TextEditingController();
    List<UserModel> userContacts = [];
    List<UserModel> favouriteContacts = [];
    List<UserModel> searchedContacts = [];

    TextEditingController searchController = TextEditingController();
    Future<void> getAllContacts() async {
        try {
            QuerySnapshot<Map<String, dynamic>> snapshot =
            await FirebaseService.getUsersData();
            userContacts = snapshot.docs.map((doc) {
                    return UserModel.fromJson(doc.data());
                }).toList();
            emit(HomeUsersSuccess(usersContact: userContacts));
        } catch (e) {
            emit(HomeUsersFailed(failedMessage: e.toString()));
        }
    }

    getUser(userId) async {
        DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseService
            .getUserData(userId);
        if (doc.data() != null) {
            return UserModel.fromJson(doc.data()!);
        } else {
            debugPrint("User document not fount $userId");
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
        homeSearchController.dispose();
        return super.close();
    }
}