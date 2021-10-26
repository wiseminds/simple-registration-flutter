import 'package:json_annotation/json_annotation.dart';

part 'location_state.g.dart';

@JsonSerializable()
class LocationState {
  final String? name;
  final String? capital;

  const LocationState({this.name, this.capital});

  @override
  String toString() => 'LocationState(name: $name, capital: $capital)';

  factory LocationState.fromJson(Map<String, dynamic> json) {
    return _$LocationStateFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationStateToJson(this);

  LocationState copyWith({
    String? name,
    String? capital,
  }) {
    return LocationState(
      name: name ?? this.name,
      capital: capital ?? this.capital,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! LocationState) return false;
    return other.name == name && other.capital == capital;
  }

  @override
  int get hashCode => name.hashCode ^ capital.hashCode;
}
