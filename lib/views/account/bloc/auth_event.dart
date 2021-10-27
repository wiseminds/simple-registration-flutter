part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SubmitPhoneNumber extends AuthEvent {
  final String phoneNumber;

  const SubmitPhoneNumber(this.phoneNumber);
}

class SubmitOTP extends AuthEvent {
  final String otp;

  const SubmitOTP(this.otp);
}
