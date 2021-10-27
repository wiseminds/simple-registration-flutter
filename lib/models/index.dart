import 'package:challenge/models/location.dart';

import 'error_model.dart';

abstract class ToJson {
  Map<String, dynamic> toJson();
}

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

Map<Type, JsonFactory> factories = {
  ErrorModel: (json) => ErrorModel.fromJson(json),
  Location: (json) => Location.fromJson(json),
};
