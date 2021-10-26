import 'package:challenge/constants/api_urls.dart';
import 'package:challenge/data/remote/interceptors/json_interceptor.dart';
import 'package:challenge/data/remote/provider/api_methods.dart';
import 'package:challenge/data/remote/provider/api_request.dart';
import 'package:challenge/data/remote/provider/api_response.dart';
import 'package:challenge/models/location_state.dart';

import '../api_client.dart';
import 'base_api_service.dart';

class AuthenticationService extends BaseApiService {
  Future<ApiResponse<LocationState, LocationState>> getStates() {
    return provider.send<LocationState, LocationState>(
        ApiClient.baseRequestNoAuth<LocationState, LocationState>().copyWith(
            path: ApiUrls.states,
            method: ApiMethods.get,
            interceptors: [JsonInterceptor()],
            error: ErrorDescription(key: ''),
            dataKey: ''));
  }

  Future<ApiResponse<List<String>, String>> cities(String state) {
    return provider.send<List<String>, String>(
        ApiClient.baseRequestNoAuth<List<String>, String>().copyWith(
            path: ApiUrls.cities(state),
            method: ApiMethods.get,
            interceptors: [JsonInterceptor()],
            error: ErrorDescription(key: ''),
            dataKey: ''));
  }
}
