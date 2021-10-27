import 'package:bloc/bloc.dart';
import 'package:challenge/core/utils/validators.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with Validator {
  AuthBloc() : super(AuthInitial()) {
    on<SubmitPhoneNumber>((event, emit) async {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 1));
      nigerianNumber.hasMatch(event.phoneNumber)
          ? emit(SuccessAuthState())

          /// for demo purpose, naturally this would be added to the validator, but
          /// the spec doesn't specify nigerian number
          : emit(
              const FailureAuthState('Please enter a valid Nigerian number'));
    });
    on<SubmitOTP>((event, emit) async {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 1));
      emit(SuccessAuthState());
    });
    on<SubmitRegister>((event, emit) async {
      emit(LoadingAuthState());
      await Future.delayed(const Duration(seconds: 1));
      emit(SuccessAuthState());
    });
  }
}
