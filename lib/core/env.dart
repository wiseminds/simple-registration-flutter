import './extensions/index.dart';

// /// Application environment variables
abstract class Env {
  static const productionBaseUrl = 'PRODUCTION_BASE_URL';
  static const developmentBaseUrl = 'DEVELOPMENT_BASE_URL';
  static const locationBaseUrl = 'LOCATION_BASE_URL';
  final Map<String, dynamic> env;
  Env(this.env);

  String get baseUrl;
  String get locationUrl;
}

class Production extends Env {
  Production(Map<String, dynamic> env) : super(env);

  @override
  String get baseUrl => env.getKey(Env.productionBaseUrl);

  @override
  String get locationUrl => env.getKey(Env.locationBaseUrl);
}

class Development extends Env {
  Development(Map<String, dynamic> env) : super(env);

  @override
  String get baseUrl => env.getKey(Env.developmentBaseUrl);
  @override
  String get locationUrl => env.getKey(Env.locationBaseUrl);
}

class Test extends Env {
  Test(Map<String, dynamic> env) : super(env);

  @override
  String get baseUrl => env.getKey(Env.developmentBaseUrl);
  @override
  String get locationUrl => env.getKey(Env.locationBaseUrl);
}
