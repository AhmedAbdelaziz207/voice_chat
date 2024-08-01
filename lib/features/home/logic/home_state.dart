part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeLoading extends HomeState {}
final class HomeFailed extends HomeState {
  final String failedMessage ;
  HomeFailed({required this.failedMessage});
}
final class HomeSuccess extends HomeState {
  final List<UserContact> usersContact ;

  HomeSuccess({required this.usersContact});

}final class HomeSearchSuccess extends HomeState {
  final List<UserContact> searchedContacts ;

  HomeSearchSuccess({required this.searchedContacts});

}
