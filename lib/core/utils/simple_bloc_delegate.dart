import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if(kDebugMode)print(event.toString());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if(kDebugMode)print(transition.toString());
  }

  @override
  void onChange(BlocBase cubit, Change change) {
    super.onChange(cubit, change);
    if(kDebugMode)print(change.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    if(kDebugMode)print(error.toString());
  }
}
