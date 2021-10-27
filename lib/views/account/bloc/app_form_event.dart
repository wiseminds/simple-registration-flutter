part of 'app_form_bloc.dart';

abstract class AppFormEvent {
  const AppFormEvent();
}

class PhoneNumberChanged extends AppFormEvent {
  final String value;

  const PhoneNumberChanged(this.value);
}

class OtpNumberChanged extends AppFormEvent {
  final String value;

  const OtpNumberChanged(this.value);
}
