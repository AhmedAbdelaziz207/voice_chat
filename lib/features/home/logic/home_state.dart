part of 'home_users_cubit.dart';

@immutable
sealed class HomeUsersState {}

final class HomeUsersLoading extends HomeUsersState {}

final class HomeUsersFailed extends HomeUsersState {
  final String failedMessage;

  HomeUsersFailed({required this.failedMessage});
}

final class HomeUsersSuccess extends HomeUsersState {
  final List<UserModel> usersContact;
  HomeUsersSuccess({ required this.usersContact,});
}

final class HomeSearchSuccess extends HomeUsersState {
  final List<UserModel> searchedContacts;

  HomeSearchSuccess({required this.searchedContacts});
}


