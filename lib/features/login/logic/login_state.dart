
import 'package:flutter/material.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String phoneNumber;
  final String userName;

  LoginSuccess({required this.phoneNumber,required this.userName});
}

final class LoginFailed extends LoginState {
  LoginFailed({required this.failedMessage});

  final String failedMessage;
}
