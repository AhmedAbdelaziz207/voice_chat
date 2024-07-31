part of 'otp_cubit.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}
final class OtpLoading extends OtpState {}
final class OtpFailed extends OtpState {
  final String failedMessage ;
  OtpFailed({required this.failedMessage});
}
final class OtpSuccess extends OtpState {}
