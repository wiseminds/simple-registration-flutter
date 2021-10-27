import 'package:bloc/bloc.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:challenge/models/location.dart';
import 'package:challenge/models/security_question.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'app_form_event.dart';
part 'app_form_state.dart';

class AppFormBloc extends Bloc<AppFormEvent, AppFormState> {
  AppFormBloc() : super(AppFormState()) {
    on<OtpNumberChanged>((event, emit) {
      emit(state.copyWith(otp: event.value));
    });
    on<PhoneNumberChanged>((event, emit) {
      emit(state.copyWith(phoneNumber: event.value));
    });
    on<GenderChanged>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });
    on<FullnameChanged>((event, emit) {
      emit(state.copyWith(fullname: event.name));
    });
    on<SecurityQuestionChanged>((event, emit) {
      emit(state.copyWith(question: event.value));
    });
    on<AltSecurityQuestionChanged>((event, emit) {
      emit(state.copyWith(altQuestion: event.value));
    });
    on<DateChanged>((event, emit) {
      emit(state.copyWith(dateOfBirth: event.value));
    });
    on<PinChanged>((event, emit) {
      emit(state.copyWith(pin: event.value));
    });
    on<Answer1Changed>((event, emit) {
      emit(state.copyWith(answer1: event.value));
    });
    on<Answer2Changed>((event, emit) {
      emit(state.copyWith(answer2: event.value));
    });
    on<StateChanged>((event, emit) {
      emit(state.copyWith(state: event.value));
    });
    on<LgaChanged>((event, emit) {
      emit(state.copyWith(lga: event.value));
    });
  }
}
