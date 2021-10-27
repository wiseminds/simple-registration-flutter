import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:challenge/core/router/app_router.dart';
import 'package:challenge/data/data_repository.dart';
import 'package:challenge/data/local/local_repository.dart';
import 'package:challenge/data/remote/api_services/location_api_service.dart';
import 'package:challenge/data/remote/provider/api_response.dart';
import 'package:challenge/models/location.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'location_state.dart';
part 'location_repository.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({this.onStateFetched, this.onLgaFetched})
      : super(const LocationState());
  final Function()? onStateFetched, onLgaFetched;
  final LocationRepository _repository = LocationRepository();

  loadStates() async {
    emit(state.copyWith(isLoading: true));

    var result = await _repository.getLocation();
    if (result.isSuccessful && result.body != null) {
      emit(state.copyWith(location: result.body));
      if (onStateFetched != null) onStateFetched!();
    } else {
      ScaffoldMessenger.of(AppRouter.navigationKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text('Sorry could not load states'),
        backgroundColor: Colors.red,
      ));
    }

    emit(state.copyWith());
  }

  loadLga() async {
    emit(state.copyWith(isLoading: true));

    var result = await _repository.getLgaInState(state.state?.id ?? '');
    if (result.isSuccessful && result.body != null) {
      emit(state.lgasChanged(result.body));
      if (onLgaFetched != null) onLgaFetched!();
    } else {
      ScaffoldMessenger.of(AppRouter.navigationKey.currentContext!)
          .showSnackBar(const SnackBar(
        content: Text('Sorry could not load LGA'),
        backgroundColor: Colors.red,
      ));
    }

    emit(state.copyWith());
  }

  stateChanged(Location? _state) {
    emit(state.stateChanged(
      _state,
    ));
    loadLga();
  }

  lgaChanged(Location? lga) => emit(state.copyWith(
        lga: lga,
      ));
}
