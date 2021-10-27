import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String id;
  final String name;
  @JsonKey(name: 'active', defaultValue: true)
  final bool isActive;

  const Location(
      {required this.id, required this.name, required this.isActive});

  @override
  String toString() => 'Location(id: $id, name: $name, isActive: $isActive)';

  factory Location.fromJson(Map<String, dynamic> json) {
    return _$LocationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Location copyWith({
    String? id,
    String? name,
    bool? isActive,
  }) {
    return Location(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! Location) return false;
    return other.id == id && other.name == name && other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isActive.hashCode;
}
