import 'package:challenge/constants/api_urls.dart';
import 'package:challenge/data/remote/interceptors/json_interceptor.dart';
import 'package:challenge/data/remote/provider/api_methods.dart';
import 'package:challenge/data/remote/provider/api_request.dart';
import 'package:challenge/data/remote/provider/api_response.dart';
import 'package:challenge/models/location.dart';

import '../api_client.dart';
import 'base_api_service.dart';

class LocationApiService extends BaseApiService {
  Future<ApiResponse<List<Location>, Location>> getStates() {
    return provider.send<List<Location>, Location>(
        ApiClient.baseRequestNoAuth<List<Location>, Location>().copyWith(
            path: ApiUrls.states,
            method: ApiMethods.get,
            interceptors: [JsonInterceptor()],
            error: ErrorDescription(key: ''),
            dataKey: 'data'));
  }

  Future<ApiResponse<List<Location>, Location>> cities(String state) {
    return provider.send<List<Location>, Location>(
        ApiClient.baseRequestNoAuth<List<Location>, Location>().copyWith(
            path: ApiUrls.cities(state),
            method: ApiMethods.get,
            interceptors: [JsonInterceptor()],
            error: ErrorDescription(key: ''),
            nestedKey: 'data',
            dataKey: 'data'));
  }
}
