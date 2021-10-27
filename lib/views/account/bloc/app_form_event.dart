part of 'app_form_bloc.dart';

abstract class AppFormEvent extends Equatable {
  const AppFormEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberChanged extends AppFormEvent {
  final String value;

  const PhoneNumberChanged(this.value);
}
