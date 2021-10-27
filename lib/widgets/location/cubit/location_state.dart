part of 'location_cubit.dart';

class LocationState extends Equatable {
  const LocationState(
      {this.lgas, this.state, this.lga, this.location, this.isLoading = false});

  final List<Location>? location;
  final List<Location>? lgas;
  final Location? state;
  final Location? lga;
  final bool isLoading;

  LocationState stateChanged(Location? state) => LocationState(
        state: state ?? this.state,
        location: location ?? location,
      );

  LocationState lgasChanged(List<Location>? lgas) => LocationState(
      state: state ?? state,
      location: location ?? location,
      lgas: lgas ?? this.lgas);

  LocationState copyWith(
          {List<Location>? location, Location? lga, bool? isLoading}) =>
      LocationState(
          state: state,
          lga: lga ?? this.lga,
          lgas: lgas ?? lgas,
          location: location ?? this.location,
          isLoading: isLoading ?? false);
          
  @override
  List<Object?> get props => [location, isLoading, state, lga, lgas];

  @override
  String toString() => {
        state: state,
        lga: lga,
        lgas: lgas,
        location: location,
        isLoading: isLoading
      }.toString();
}
