import 'error_model.dart';
import 'location_state.dart';

abstract class ToJson {
  Map<String, dynamic> toJson();
}

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

Map<Type, JsonFactory> factories = {
  ErrorModel: (json) => ErrorModel.fromJson(json),
  LocationState: (json) => LocationState.fromJson(json),
};
