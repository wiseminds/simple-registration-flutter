import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  final String? message;
  final int? code;

  const ErrorModel({this.message, this.code});

  @override
  String toString() => 'ErrorModel(message: $message, code: $code)';

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return _$ErrorModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ErrorModelToJson(this);

  ErrorModel copyWith({
    String? message,
    int? code,
  }) {
    return ErrorModel(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! ErrorModel) return false;
    return other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}
