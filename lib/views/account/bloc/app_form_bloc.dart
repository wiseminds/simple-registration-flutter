import 'package:bloc/bloc.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_form_event.dart';
part 'app_form_state.dart';

class AppFormBloc extends Bloc<AppFormEvent, AppFormState> {
  AppFormBloc() : super(AppFormState()) {
    
    on<PhoneNumberChanged>((event, emit) {
      emit(state.copyWith(phoneNumber: event.value));
    });
    on<AppFormEvent>((event, emit) {});
  }
}
