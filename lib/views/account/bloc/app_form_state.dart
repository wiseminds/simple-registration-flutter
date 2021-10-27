part of 'app_form_bloc.dart';

@immutable
class AppFormState extends Equatable with Validator {
  final String? phoneNumber, otp;

  AppFormState({this.phoneNumber, this.otp});

  /// clone the current state with updated values
  AppFormState copyWith({String? phoneNumber, String? otp}) => AppFormState(
      phoneNumber: phoneNumber ?? this.phoneNumber, otp: otp ?? this.otp);

  bool get isPhoneNumberValid => verifyPhoneNumber(phoneNumber) == null;

  @override
  List<Object?> get props => [phoneNumber, otp];
}
