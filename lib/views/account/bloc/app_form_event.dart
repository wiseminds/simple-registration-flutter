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

class PinChanged extends AppFormEvent {
  final String value;

  const PinChanged(this.value);
}

class GenderChanged extends AppFormEvent {
  final Gender gender;

  const GenderChanged(this.gender);
}

class FullnameChanged extends AppFormEvent {
  final String name;

  FullnameChanged(this.name);
}

class SecurityQuestionChanged extends AppFormEvent {
  final SecurityQuestion value;

  SecurityQuestionChanged(this.value);
}

class AltSecurityQuestionChanged extends AppFormEvent {
  final SecurityQuestion value;

  AltSecurityQuestionChanged(this.value);
}

class DateChanged extends AppFormEvent {
  final DateTime value;

  DateChanged(this.value);
}

class Answer1Changed extends AppFormEvent {
  final String value;

  Answer1Changed(this.value);
}

class Answer2Changed extends AppFormEvent {
  final String value;

  Answer2Changed(this.value);
}

class StateChanged extends AppFormEvent {
  final Location? value;

  StateChanged(this.value);
}

class LgaChanged extends AppFormEvent {
  final Location? value;

  LgaChanged(this.value);
}
